//Ho tên:TranDucTai		LuongXuanNhat
//MSSV : 2090606906		2011064280
// Chude4_Cau1

#include<stdio.h>
#include<string.h>

struct node{
	char info;
	int value;
	struct node* next;
};
typedef node * stack; 
stack s; 
void init(stack &s){
	s=NULL;
}
int isempty(stack s){
	return (s == NULL);
}
int push(stack &s,char x){ 
	node* p = new node;
	if(p == NULL)
		return 0;
	p->info = x;
	p->next = s;
	s = p;
	return 1;
}
int push1(stack &s,int x){ 
	node* p = new node;
	if(p == NULL)
		return 0;
	p->value = x;
	p->next = s;
	s = p;
	return 1;
}
int pop(stack &s,char &x){
	if(isempty(s))
		return 0;
	node* p=s;
	x=p->info;
	s=s->next;
	delete p;
	return 1;
}
int pop1(stack &s,int &x){
	if(isempty(s))
		return 0;
	node* p=s;
	x=p->value;
	s=s->next;
	delete p;
	return 1;
}
char top(stack s){
	if(!isempty(s))
		return s->info; 
	else{
		printf("\nStack rong");
	}
}
// xuat
void xuat(stack s){
	stack p=s;
	while(s != NULL){
		printf("%d\n",p->value);	
		p=p->next;	
	}
}
int priority(char x){
	switch(x){
		case '*':
			return 2;
		case '/':
			return 2;
		case '+':
			return 1;
		case '-':
			return 1;	
		case '(':
			return 0;
		default:
			return 3;
	}
}
void hauto(char ht[],char k,int &t){
	t++;
	ht[t]=k;
}
void process(stack &s,char bt[],char ht[],int &t){
	init(s);
	char y;
	int j=-1;
	for(int i=0;i<strlen(bt);i++){
		if(priority(bt[i]) == 0) 					push(s,bt[i]);
		if(priority(bt[i]) == 3 && bt[i] != ')')	{
			hauto(ht,bt[i],t);}
		if(priority(bt[i]) == 2 || priority(bt[i]) == 1){
			if(!(isempty(s))){
				while(!(isempty(s))){
					if(priority(bt[i]) > priority(top(s))){					
						push(s,bt[i]);
						break;
					}
					else
					{
						if((priority(bt[i]) < priority(top(s)) || 
						(priority(bt[i]) == priority(top(s)))) && priority(top(s)) != 0){
							pop(s,y); 	hauto(ht,y,t);		
						}					
						else{
							push(s,bt[i]);	
							break;
						}					
					}
				}
				if(isempty(s))
					push(s,bt[i]);
			}
			else
				push(s,bt[i]);
		}
		if(bt[i] == ')'){
			while(top(s) != '('){
				//top(s);
				pop(s,y); 		hauto(ht,y,t);
			}
			pop(s,y);
		}
	}
	while(s != NULL){
		pop(s,y);
		hauto(ht,y,t); 
	}
}
int giatrihauto(char ht[],stack &s){
	init(s); int x; int a,b;
	for(int i=0;i<strlen(ht);i++){
		if(priority(ht[i]) == 3 ){
			x=ht[i]-'0'; 
			push1(s,x);
		}
		if(priority(ht[i]) == 1 || priority(ht[i]) == 2){
			pop1(s,x); a=x;
			pop1(s,x); b=x;
			if(ht[i] == '*')	push1(s,a*b);
			if(ht[i] == '/')	push1(s,b/a);
			if(ht[i] == '+')	push1(s,a+b);
			if(ht[i] == '-')	push1(s,b-a);
		}		
	}
	pop1(s,x);
	return x;	
}
int main(){
	char bt[100],ht[100];
	int t=-1;
	printf("\nNhap bieu thuc (co cac toan hang < 10): ");
	fflush(stdin);
	gets(bt);
	process(s,bt,ht,t);
	printf("\nBieu thuc o dang hau to: ");
	for(int i=0;i<strlen(ht);i++){
		printf("%c",ht[i]);
	}
	printf("\n");
	printf("Gia tri bieu thuc hau to: %d",giatrihauto(ht,s));
return 0;
}
