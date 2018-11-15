#include<stdio.h>
#include<stdlib.h>

int main(int argc,char *argv[])
{
	char s[1024];
	while(scanf("%s",s)!=EOF)
	{
		char t[2048];
		sprintf("cat %s | %s | %s ",s,argv[1],argv[2]);
		printf("%s",t);
		system(t);
	}
}
