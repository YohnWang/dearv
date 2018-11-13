#include<stdio.h>
#include<ctype.h>
char s[100000];
int main()
{
	int c;
	int state=0;
	int count=0;
	char text[128];
	int  itext=0;
	char inst[128];
	int  ttext;
	while((c=getchar())!=EOF)
	{
		switch(state)
		{
			case 0:
				if(isdigit(c)|| (c>='a' && c<='f'))
				{
					state=1;
					count+=1;
					text[itext++]=c;
				}
				else 
				{
					itext=0;
					ttext=0;
					count=0;
				}
			
				break;
			case 1:
				if(count<8 && isdigit(c)|| (c>='a' && c<='f'))
				{
					state=1;
					count+=1;
					text[itext++]=c;
				}
				else if(count==8 && (c==' ' || c=='\t'))
				{
					state=2;
					text[itext]='\0';
					
				}
				else 
				{
					state=0;
					itext=0;
					ttext=0;
					count=0;
				}
				break;
			case 2:
				if(c==' ' || c=='\t')
				{
					state=2;
					
				}
				else 
				{
					state=3;
					inst[ttext++]=c;
				}
				break;
			case 3:
				if(c!='\n')
				{
					inst[ttext++]=c;
				}
				else 
				{
					state=4;
					inst[ttext]='\0';
					printf("%c%c %c%c %c%c %c%c  // %s\n",text[6],text[7],text[4],text[5],text[2],text[3],text[0],text[1],inst);
					state=0;
					itext=0;
					ttext=0;
				}
				break;
		}
		
		
		
	}
}
