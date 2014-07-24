#include <stdlib.h>
#include "hershey_font.h"
#include "hershey.h"

static const char* psCodeFor(int opcode)
	{
	return LETTERS[opcode].glyph;
	}

int main(int argc,char** argv)
	{
	size_t i=0UL;
	int count=0;
	HersheyPtr hershey=HersheyNew();
	hershey->getCodeFor=psCodeFor;
	while(LETTERS[i++].opcode > 0 ) count++;
	
	fputs("%!PS\n",stdout);
	fputs("%%BoundingBox: 0 0 400 400\n",stdout);
	fprintf(stdout,"%%Pages: %d\n",count);
	
	i=0;
	while(LETTERS[i].opcode > 0 )
		{

		fprintf(stdout,"%%Page: %d %d\n",(int)i,(int)i);
		if(i==0) fputs( "/Times-Roman findfont 20 scalefont setfont 10.0 setlinewidth ",stdout);
		fprintf(stdout,"20 380  moveto (%d) show\n",LETTERS[i].opcode);
		fputs(" 10 10 moveto ",stdout);
		HersheyPSPaintChar(hershey,stdout,(int)i,200,200,100,100);
		
		fputs(" stroke showpage\n",stdout);
		++i;
		}
	fputs("%%EOF\n",stdout);
	HersheyFree(hershey);
	return EXIT_SUCCESS;
	}
