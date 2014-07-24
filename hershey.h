/*
The MIT License (MIT)

Copyright (c) 2014 Pierre Lindenbaum PhD.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/
#ifndef HERSHEY_H
#define HERSHEY_H
#include <stdio.h>
#ifndef DISABLE_CAIRO
#include <cairo.h>
#endif

typedef struct hershey_t
	{
	double scalex;
	double scaley;
	void* _priv;
	
	/** callback to get hershey string for charater 'code'. Default : NULL */
	const char* (*getCodeFor)(int code);
	/** postcript move operator.  Default: NULL = moveto */
	char* ps_moveto;
	/** postcript line operator.  Default: NULL = lineto */
	char* ps_lineto;
	}Hershey,*HersheyPtr;

HersheyPtr HersheyNew();
void HersheyFree(HersheyPtr ptr);

#ifndef DISABLE_CAIRO
void HersheyCairoPaint(
	HersheyPtr ptr,
	cairo_t *cr,
	const char* s,
	double x, double y,
	double width, double height
	);
#endif


void HersheyPSPaintString(
	HersheyPtr ptr,
	FILE* out,
	const char* s,
	double x, double y,
	double width, double height
	);

void HersheyPSPaintChar(
	HersheyPtr ptr,
	FILE* out,
	int character,
	double x, double y,
	double width, double height
	);

#endif
