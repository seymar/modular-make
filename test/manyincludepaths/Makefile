INCLUDES = a b others z

INCLUDES_MORE = a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
INCLUDES_MORE += b1 b2 b3 b4 b5 b6 b7 b8 b9 b10
INCLUDES_MORE += c1 c2 c3 c4 c5 c6 c7 c8 c9 c10
INCLUDES_MORE += d1 d2 d3 d4 d5 d6 d7 d8 d9 d10
INCLUDES_MORE += e1 e2 e3 e4 e5 e6 e7 e8 e9 e10

CMD1 := gcc -o main main.c $(INCLUDES:%=-I%)
CMD2 := gcc -o main main.c $(INCLUDES:%=-I%) $(INCLUDES_MORE:%=-I%)

all: $(INCLUDES:%=%/header.h)
	time for i in {1..100}; do $(CMD1); done
	time for i in {1..100}; do $(CMD2); done

%/header.h:
	mkdir -p $(dir $@)
	touch $@