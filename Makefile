 
PROGS = codegroup
CFLAGS = -O -Wall
PAGER = more

all:	$(PROGS)

clean:
	rm -f $(PROGS) *.o *.bak *.zip core code.* *.out

codegroup: codegroup.o
	$(CC) codegroup.o -o codegroup $(CFLAGS)

#   Create zipped archive

RELFILES = Makefile codegroup.1 codegroup.c \
	   codegroup.html codegroup.jpg codegroup.man codegrp.exe

release:
	rm -f codegroup.zip
	zip codegroup.zip $(RELFILES)
	
#   Test by encoding and decoding the program binary

check:	codegroup
	./codegroup -e <codegroup >codegroup1.bak
	./codegroup -d <codegroup1.bak >codegroup2.bak
	-cmp -s codegroup codegroup2.bak ; if test $$? -ne 0  ; then \
	    echo '** codegroup:  Redirection test failed. **' ; else \
	./codegroup -e codegroup codegroup1.bak ;\
	./codegroup -d codegroup1.bak codegroup2.bak ;\
	cmp -s codegroup codegroup2.bak ; if test $$? -ne 0  ; then \
	    echo '** codegroup:  Command line file argument test failed. **' ; else \
	    echo 'All tests passed.' ; fi ; fi
	@rm codegroup1.bak codegroup2.bak

#   View manual page

manpage:
	nroff -man codegroup.1 | $(PAGER)

#   Print manual page

printman:
	groff -man codegroup.1 | lp
