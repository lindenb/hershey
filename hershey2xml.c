
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h> 

#define MIN(a,b) (a < b ? a: b)
#define MAX(a,b) (a > b ? a: b)

static int fgetskipcr()
	{
	int c;
	while((c=fgetc(stdin))!=EOF)
		{
		if(c=='\n') continue;
		return c;
		}
	fprintf(stderr,"Expected char but got EOF");
	exit(EXIT_FAILURE);
	}

int main(int argc,char** argv)
	{
	int maxx=0,maxy=0;
	int minx=0,miny=0;
	
	fputs("<?xml version=\'1.0\'?>\n<hershey>\n",stdout);
	for(;;)
		{
		int letter_id=0,num_vertices=0,i=0;
		int c;
		
		while(i< 5)
			{
			c=fgetc(stdin);
			if(c==EOF) { letter_id=0; break;}
			if(c=='\n') {i=0;continue;}
			i++;
			if(isspace(c)) continue;
			letter_id=letter_id*10+(c-'0');
			}
		if(letter_id==0) break;
		

		
		for( i=0;i< 3;++i)
			{
			int c=fgetc(stdin);
			if(isspace(c)) continue;
			num_vertices = num_vertices*10+(c-'0');
			}
		
		
		int vertex=0;
		int prev_was_R=1;
		while(vertex < num_vertices )
			{
			int c1,c2;
			
			c1=fgetskipcr();
			if(c1==' ')
				{
				c1=fgetc(stdin);
				if(c1!='R')
					{
					fprintf(stderr, "R Expected\n");
					return -1;
					}
				prev_was_R=1;
				vertex++;
				continue;
				}
			if(isspace(c1) || c1==EOF)
				{
				fprintf(stderr, "c1 not space Expected\n");
				return -1;
				}
			c2=fgetskipcr();
			if(isspace(c2) || c2==EOF)
				{
				fprintf(stderr, "c1 not space Expected\n");
				return -1;
				}
			vertex++;
			
			c1-='R';
			c2-='R';
			
			maxx=MAX(maxx,c1);
			maxy=MAX(maxy,c2);
			minx=MIN(minx,c1);
			miny=MIN(miny,c2);
			
			if(vertex==1)
				{
				printf("  <letter id=\"%d\" count=\"%d\" left=\"%d\" right=\"%d\">\n",
					letter_id,
					num_vertices,
					c1,
					c2
					);
				prev_was_R=1;
				}
			else
				{
				printf("    <%s x=\"%d\" y=\"%d\"/>\n",
					(prev_was_R==1?"moveto":"lineto"),
					c1,
					c2
					);
				prev_was_R=0;
				}
				
			}

		printf("  </letter>\n");
		int c1;
		if((c1=fgetc(stdin))!='\n')
			{
			fprintf(stderr, "syntax error\n");
			return -1;
			}
		}
	printf("  <sizes minx=\"%d\" maxx=\"%d\" miny=\"%d\" maxy=\"%d\" width=\"%d\" height=\"%d\"/>\n",
		minx,maxx,
		miny,maxy,
		(maxx-minx),
		(maxy-miny)
		);
	fputs("\n</hershey>\n",stdout);
	return 0;
	}
