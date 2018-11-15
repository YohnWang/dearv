#include<stdio.h>
#include<stdlib.h>

int main()
{
	int c;
	
	int state=1;
	while((c=getchar())!=EOF)
	{
		switch(state)
		{
			case 1:
				if(c=='m')
					state=2;
				else 
					state=1;
				break;
			case 2:
				if(c=='o')
					state=3;
				else 
					state=1;
				break;
			case 3:
				if(c=='d')
					state=4;
				else 
					state=1;
				break;
			case 4:
				if(c=='u')
					state=5;
				else 
					state=1;
				break;
			case 5:
				if(c=='l')
					state=6;
				else 
					state=1;
				break;
			case 6:
				if(c=='e')
					state=7;
				else 
					state=1;
				break;
			case 7:
				if(c==' ')
					goto $L0;
				else 
					state=1;
				break;
		}
	}
$L0:
	printf("module ");
	
	
	while((c=getchar())!=EOF && c!=';')
	{
		printf("%c",c);
	}
	printf(";\n");
}
