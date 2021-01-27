# file: Makefile
# author: Ted Baker
# date: February 2015
#
# makefile for P4
#
# To use this, first run "configure", then "make"
#
include Config
DEPS=config.h Config Makefile echolib.h checks.h list.h
FILES=README Makefile configure echolib.c usleep.c echolib.h echocli.c echosrv.c multisrv.c submitP4.sh checks.h driver.c timer.c testone list.h

# the program or programs we want to build

EXECUTABLES=echocli echosrv usleep multisrv driver timer

# If you just type "make", it will default to "make all".

default: $(EXECUTABLES)

# rule to remind people to run configure first

Config config.h:
	@echo first run configure to build Config and config.h

echocli: echolib.o echocli.c $(DEPS)
	gcc $(CCOPTS) -o $@ echolib.o $(LIBS) $@.c

echosrv: echolib.o echosrv.c $(DEPS)
	gcc $(CCOPTS) -o $@ echolib.o $(LIBS) $@.c

multisrv: echolib.o multisrv.c $(DEPS)
	gcc $(CCOPTS) -o $@ echolib.o $(LIBS) $@.c

echolib.o: echolib.c $(DEPS)
	gcc $(CCOPTS) -c echolib.c

driver: driver.c echolib.o
	gcc $(CCOPTS) -o driver driver.c $(LIBS) echolib.o

timer: timer.c
	gcc $(CCOPTS) -o timer timer.c $(LIBS)

testit: testit.c
	gcc $(CCOPTS) -o $@ echolib.o $(LIBS) $@.c

usleep: usleep.c
	gcc $(CCOPTS) -o usleep usleep.c

# "make clean" removes all the files created by "make" and editors

clean:
	rm -rf *.o $(EXECUTABLES) *~ *# a.out *.dSYM

# "make realclean" also removes all the files created by "configure"

realclean: clean
	rm -rf Config config.h results testdir

archive:
	tar czvpf P4.tgz $(FILES) results.sample
#
