CC = /usr/bin/gcc
CFLAGS = -Wall -Wextra -O3 -fomit-frame-pointer -march=corei7-avx

HEADERS = src/crypto_stream_chacha20.h src/params.h src/poly.h src/randombytes.h src/ntt.h src/error_correction.h src/reduce.h
CFILES  = src/crypto_stream_chacha20.c src/poly.c src/ntt.c src/precomp.c src/error_correction.c src/newhope.c src/reduce.c src/fips202.c

all:	test/test_newhope \
        test/speed

test/test_newhope: $(HEADERS) $(CFILES) test/test_newhope.c src/randombytes.c
	$(CC) $(CFLAGS) $(CFILES) src/randombytes.c test/test_newhope.c -o $@

test/speed: $(HEADERS) $(CFILES) test/speed.c src/cpucycles.c src/randombytes.c
	$(CC) $(CFLAGS) $(CFILES) src/randombytes.c test/speed.c src/cpucycles.c -o $@

.PHONY: clean

clean:
	-rm test/test_newhope
