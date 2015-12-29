#
#
#
# default value for OS_NAME
#
OS_NAME = linux

ifeq ($(OS_NAME), linux)
  SUFFIX = so
	OSFX = o
endif
ifeq ($(OS_NAME), osx)
  SUFFIX = dylib
	OSFX = o
endif

TARGET=libtest.$(SUFFIX)
OBJS=set_argv_test.$(OSFX) set_string_test.$(OSFX) struct_test.$(OSFX)
SOURCES=$(OBJS:.o=.c)
CC=gcc
CFLAGS=-Wall -g -fPIC -I.
LDFLAGS=-shared $(CFLAGS)

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $(OBJS)

clean:
	$(RM) $(TARGET) $(OBJS)

.PHONY: clean
