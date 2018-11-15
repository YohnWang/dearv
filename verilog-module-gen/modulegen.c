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
	char module_name[1024];
	scanf("%s",module_name);
	printf("%s",module_name);

	//while((c=getchar())!='EOF' && isspace(c)){}
	for(;;)
	{
		c=getchar();
		if(c=='(')
			goto $L1;
		if(c=='#')
		{
			while((c=getchar())!=EOF && c!=')'){}
			break;
		}
		if(c==';')
		{
			printf(";");
			return 0;
		}
		
	}
	
	while((c=getchar())!=EOF && c!=';')
	{
	$L1:
		printf("%c",c);
	}
	printf(";\n");
}
