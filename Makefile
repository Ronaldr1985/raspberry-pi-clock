include config.mk

NAME=rbp-clock

TARGET=rbp-clock

all: options $(TARGET)

options:
	@echo ${NAME} build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "CC       = ${CC}"

$(TARGET): options
	$(CC) -o $(TARGET) src/$(TARGET).c src/lib/ssd1305.c $(CFLAGS)

clean:
	rm -f ${TARGET}

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f $(TARGET) ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/$(TARGET)

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/$(TARGET)

PHONY: all options clean install uninstall
