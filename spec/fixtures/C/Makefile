#
#
#
TARGET=libtest.so
OBJS=set_argv_test.o set_string_test.o
SOURCES=$(OBJS:.o=.c)
CC=gcc
CFLAGS=-Wall -g -fPIC
LDFLAGS=-shared $(CFLAGS)

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $(OBJS)

clean:
	$(RM) $(TARGET) $(OBJS)

.PHONY: clean
