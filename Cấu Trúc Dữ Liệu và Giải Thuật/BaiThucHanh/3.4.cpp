#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct node{
	char info;
	struct node* next;
};
struct stack{
	node* phead; 
}; 

void init(stack &s){
	s.phead=NULL;
}
int isempty(stack s){
	if(s.phead == NULL)
		return 0;
		return 1;
}
node* createnode(char x){
	node* q = new node;
	q->info = x;
	q->next = NULL;
	return q;
}
int push(stack &s,char x){ 
	node *p = createnode(x);
	if(isempty(s)==0) s.phead== p;
	else{
		p->next = s.phead;
		s.phead =p;
	}
}
node* pop(stack &s){ 
	if(s.phead == NULL)
		return NULL;
	node* p=s.phead;
	s.phead=s.phead->next;
	return p;
}
char top(stack s){
	if(isempty(s)==1)
		return s.phead->info;
	else{
		printf("\nStack rong");
	}
}
void xuat(stack s){
	printf("\nXUAT\n");
	while(s.phead != NULL){
		printf("%c",s.phead->info);	
		s.phead=s.phead->next;	

	}
}
int analysis(stack &s,char expression[]){
	char x;
	init(s);
	for(int i=0;i < strlen(expression);i++){
		if(expression[i] == ')' && isempty(s) == 0)	return 1;
		else{
		if(expression[i] == '(' )
				push(s,expression[i]);
		if(expression[i] == ')' && top(s) == '(' )
					pop(s);
		}
	}
	if(isempty(s)==0)	return 0; 
	else 	return 1;
}
int main(){
	stack s;
	char expression[30];
	push(s,10);
	printf("\nMoi nhap bieu thuc: ");
	fflush(stdin); gets(expression);
	if(isempty(s)==0) printf("rong");
	if(analysis(s,expression)==0) printf("\nBieu thuc dung");
	else	printf("\nBieu thuc sai");	
//	xuat(s);
//	if(isempty(s)==0) printf("rongCmn");	
	return 0;
}
