// VIÊT CHUONG TRINH CHUYÊN TU BIÊU THUC TRUNG TÔ SANG HÂU TÔ
#include<stdio.h>
#include<string.h>


struct node{
	char info;
	struct node* next;
};
typedef node * stack;

// Khoi tao
void init(stack &s){
	s=NULL;
}
// Kiem tra rong
int isempty(stack s){
	return (s == NULL);
}
// Them phan tu x vao stack
int push(stack &s,char x){  // insertFirst
	node* p = new node;
	if(p == NULL)
		return 0;
	p->info = x;
	p->next = s;
	s = p;
	return 1;
}
// Xoa 1 phan tu ra khoi stack
int pop(stack &s,char &x){ 
	if(isempty(s))
		return 0;
	node* p=s;
	x=p->info;
	s=s->next;
	delete p;
	return 1;
}
// Hien thi phan tu dau stack
int top(stack s){
	if(!isempty(s))
		return s->info; 
	else{
		printf("\nStack rong");
	}
}
void chuyendoi(char bieuthuc[]){
	for(int i=0;i<strlen(bieuthuc);i++){
		if(strcmp(bieuthuc[i],'(' )== 0){
			push(s,bieuthuc[i]);
		}
	}
}
int main(){
	stack s;
	char bieuthuc[15];
	printf("\nMoi nhap vao BIEU THUC TRUNG TO can chuyen doi: ");
	fflush(stdin);		gets(bieuthuc);
	chuyendoi(bieuthuc);
	return 0;
}
