CC=gcc
CFLAGS=-Wall -O2
.PHONY=all clean
all:  hershey.pdf

hershey.pdf: hershey hershey2ps.c hershey2tsv hershey.c hershey.h
	./hershey2tsv < hershey |\
	sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' |\
	awk -F '	' 'BEGIN{ printf("#define MAX_GLYPH_LEN 400\nstruct hershey_letter {int opcode;char glyph[MAX_GLYPH_LEN];};\nstatic const struct hershey_letter LETTERS[]={\n");} {printf("\t{%d,\"%s\"},\n",$$1,$$2);} END {printf("\t{-1,\"\"}\n\t};\n");}' > hershey_font.h && \
	$(CC) $(CFLAGS) -DDISABLE_CAIRO -o a.out hershey2ps.c hershey.c  && \
	./a.out > hershey.ps && \
	ps2pdf hershey.ps && \
	rm -f hershey_font.h  a.out
 

hershey.xml: hershey ./hershey2xml
	./hershey2xml < $< | xmllint --format - > $@

hershey2xml : hershey2xml.c
	$(CC) $(CFLAGS) -o $@ $<

hershey2tsv : hershey2tsv.c
	$(CC) $(CFLAGS) -o $@ $<

hershey:
	curl -o $@.zip "http://paulbourke.net/dataformats/hershey/$@.zip"
	unzip $@.zip $@
	rm  $@.zip

clean:
	rm -f hershey hershey2xml  hershey2c *.o *~ a.out
