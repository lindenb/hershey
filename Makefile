CC=gcc
CFLAGS=-Wall -O2
.PHONY=all clean
all: hershey.xml

hershey.xml: hershey ./hershey2xml
	./hershey2xml < $< | xmllint --format - > $@

hershey2xml : hershey2xml.c
	$(CC) $(CFLAGS) -o $@ $<

hershey:
	curl -o $@.zip "http://paulbourke.net/dataformats/hershey/$@.zip"
	unzip $@.zip $@
	rm  $@.zip

clean:
	rm -f hershey hershey2xml 
