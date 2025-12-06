#include<stdio.h>

struct node{
	int info;
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

int push(stack &s,int x){ 
	node* p = new node;
	if(p == NULL)
		return 0;
	p->info = x;
	p->next = s;
	s = p;
	return 1;
}

void chuyendoi(int n,stack &s){
	if(n==0) {
		push(s,0);
		return ;
	}
	int sodu;
	init(s);
	while(n != 0){
		sodu = n%2;
		push(s,sodu);
		n/=2;
	}
}
void xuat(stack s){
	while(s != NULL){		
		printf("%d",s->info );
		s=s->next;		
	}
}
int main(){
	int n;
	do{
		printf("\nMoi nhap so thap phan can chuyen doi: ");
		scanf("%d",&n);
	}while(n<0);
	chuyendoi(n,s);
	printf("\nSo thap phan sau khi chuyen doi qua nhi phan: ");
	xuat(s);
	return 0;
}
