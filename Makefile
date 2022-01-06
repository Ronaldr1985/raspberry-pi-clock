include config.mk

NAME=rbp-clock

TARGET=rbp-clock

all: options ssd1305.o ${TARGET}.o $(TARGET)

$(TARGET): $(TARGET).c ${TARGET}.o ssd1305.o
	$(CC) -o $(TARGET) ${TARGET}.o ssd1305.o ${CFLAGS}

ssd1305.o: ssd1305.c ssd1305.h
	gcc -c ssd1305.c ${CFLAGS}

${TARGET}.o: ${TARGET}.c ssd1305.h 
	gcc -c ${TARGET}.c ${CFLAGS}

options:
	@echo ${NAME} build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "CC       = ${CC}"

clean:
	rm ssd1305.o ${TARGET}.o ${TARGET}

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f $(TARGET) ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/$(TARGET)

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/$(TARGET)

PHONY: all options clean install uninstall
