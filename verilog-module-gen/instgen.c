#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>

int main()
{
	char s[1024];
	scanf("%s",s);
	scanf("%s",s);
	printf("%s\n(\n",s);
	int c;
	while((c=getchar())!='('){}
	//scanf("%s",s);
	
	int state=1;
	int index=0;
	while((c=getchar())!=EOF && c!=';')
	{
		switch(state)
		{
			case 1:
				if(isalnum(c))
				{
					state=2;
					s[index++]=c;
				}
				else 
				{
					//state=1;
					goto $L0;
				}
				break;
			case 2:
				if(isalnum(c))
				{
					state=2;
					s[index++]=c;
				}
				else if(isspace(c))
				{
					state=3;
					s[index]='\0';
				}
				else if(c==',')
				{
					state=4;
					s[index]='\0';
					goto $T4;
				}
				else if(c==')')
				{
					state=5;
					s[index]='\0';
					goto $T5;
				}
				else 
					goto $L0;
				break;
			case 3:
				if(isspace(c))
					state=3;
				else if(c==',')
				{
					state=4;
					s[index]='\0';
					goto $T4;
				}
				else if(c==')')
				{
					state=5;
					s[index]='\0';
					goto $T5;
				}
				else if(isalnum(c))
				{
					state=2;
					index=0;
					s[index++]=c;
				}
				else 
					goto $L0;
				break;	

			default:
				printf("Error\n");
				return 1;
		}
		continue;
	$T4:
		printf("\t.%s(),\n",s);
		goto $L0;
	$T5:
		printf("\t.%s()\n);\n",s);
		goto $L0;
		
	$L0:
		index=0;
		state=1;
		
	}
	
}
