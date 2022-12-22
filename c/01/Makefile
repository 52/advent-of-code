# This code is licensed under the MIT license.
#  (C) 2022 by Max Karou


CC = clang
CFLAGS = -Wall

all: 
		mkdir -p ./out
		$(CC) $(CFLAGS) ./main.c -o ./out/main

exec:
		./out/main input.txt

clean:
		rm -rf ./out/main