
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
	for(;;)
		{
		int letter_id=0,num_vertices=0,i=0,vertex;
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
		printf("%d\t",letter_id);

		
		for( i=0;i< 3;++i)
			{
			int c=fgetc(stdin);
			fprintf(stdout,"%c",c);
			if(isspace(c)) continue;
			num_vertices = num_vertices*10+(c-'0');
			}
		
		

		for( vertex=0;vertex < num_vertices;++vertex )
			{
			int c1 = fgetskipcr();
			printf("%c",c1);
			c1 = fgetskipcr();
			printf("%c",c1);
			}
			
		printf("\t%d",num_vertices);
		fputc('\n',stdout);
		
		if((c=fgetc(stdin))!='\n')
			{
			fprintf(stderr, "syntax error\n");
			return -1;
			}
		}
	return 0;
	}
