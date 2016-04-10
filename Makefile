CC = gcc
CFLAGS = -std=gnu99 -Wall -I. -O1
CC_CMD = $(CC) $(CFLAGS) -o $@ -c $<

%.o: src/%.c
	$(CC_CMD)

nat: process_packet.o nat.o table.o checksum.o
	$(CC) $(CFLAGS) -o $@ $^ -lnfnetlink -lnetfilter_queue

process_packet.o: table.o checksum.o

debug: CFLAGS += -D_DEBUG -g -O0
debug: nat

clean:
	@rm -f nat *.o
