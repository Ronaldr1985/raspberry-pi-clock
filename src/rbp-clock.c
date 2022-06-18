#include "rbp-clock.h"

void get_ip_address(char *adapter, char *ip)
{
	int fd;
	struct ifreq ifr;
	fd = socket(AF_INET, SOCK_DGRAM, 0);
	ifr.ifr_addr.sa_family = AF_INET;
	memcpy(ifr.ifr_name, adapter, IFNAMSIZ - 1);
	ioctl(fd, SIOCGIFADDR, &ifr);
	close(fd);
	strcpy(ip, inet_ntoa(((struct sockaddr_in*)&ifr.ifr_addr)->sin_addr));
}

int main(int argc, char *argv[])
{
	char firstline[48];
	char value[10] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
	struct tm *timenow;
	time_t now;
	char ip_addr[15];
	if(!bcm2835_init()) {
	        return -1;
	}
	printf("OLED Clock. Press Ctrl + C to exit.\n");

	SSD1305_begin();

	while(1) {
		time(&now);
		timenow = localtime(&now);
 		get_ip_address("eth0", ip_addr);

		sprintf(firstline, "IP: %s", ip_addr);
		SSD1305_string(0, 0, firstline, 12, 0);

		// Clock
		SSD1305_char1616(0, 18, value[timenow->tm_hour / 10]);
		SSD1305_char1616(16, 18, value[timenow->tm_hour % 10]);
		SSD1305_char1616(32, 18, ':');
		SSD1305_char1616(48, 18, value[timenow->tm_min / 10]);
		SSD1305_char1616(64, 18, value[timenow->tm_min % 10]);
		SSD1305_char1616(80, 18, ':');
		SSD1305_char1616(96, 18, value[timenow->tm_sec / 10]);
		SSD1305_char1616(112, 18, value[timenow->tm_sec % 10]);

		SSD1305_display();
	}
	bcm2835_spi_end();
	bcm2835_close();
	return 0;
}

