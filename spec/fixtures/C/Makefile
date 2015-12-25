#
#
#
TARGET=libtest.so
OBJS=argv_test.o
SOURCES=$(OBJS:.o=.c)
CC=gcc
CFLAGS=-Wall -g -fPIC
LDFLAGS=-shared $(CFLAGS)

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $<

clean:
	$(RM) $(TARGET) $(OBJS)

.PHONY: clean
