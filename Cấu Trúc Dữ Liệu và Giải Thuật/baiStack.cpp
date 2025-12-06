#include<stdio.h>

struct node{
	int info;
	struct node* next;
};
typedef node * stack;
// su dung 
stack s; // dong vai tro phead - Quan li danh sach
// 4 thao tac
// initStack - isempty - push - pop
// Khoi tao
void init(stack &s){
	s=NULL;
}
// Kiem tra rong
int isempty(stack s){
	return (s == NULL);
}

// Them phan tu x vao stack
int push(stack &s,int x){ // insertFirst sinhvien &x
	node* p = new node;
	if(p == NULL)
		return 0;
	p->info = x;
	p->next = s;
	s = p;
	return 1;
}
// Xoa 1 phan tu ra khoi stack
int pop(stack &s,int &x){ // sinhvien &x
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
// Input
void input(stack &p){
	int n,x;
	init(p); // Khoi tao danh sach
	printf("Nhap so phan tu: ");	scanf("%d",&n);
	for(int i=0;i<n;i++)
	{
		printf("Nhap gia tri phan tu thu %d cua node: ",i+1);
		scanf("%d",&x);
		push(p,x);
	}
}
//Ungdung stack chuyen doi so
void chuyendoi(int n,stack &s){
	int sodu;
	while(n != 0){
		sodu = n%2;
		push(s,sodu);
		n/=2;
	}
}
// xuat
void xuat(stack s){
	int x;
	while(s != NULL){
		pop(s,x);
		printf("%d",x);		
	}
}
int main(){
	int n=15,m;
	chuyendoi(n,s);
	printf("So thap phan: %d khi chuyen qua so nhi phan la: ",n);
	xuat(s);
//	push(s,10);
//	push(s,11);
//	push(s,12);
//	push(s,13);
//	printf("Hien thi dau stack: %d",top(s));
//	pop(s,m);
//	printf("\nSau khi xoa 1 stack, phan tu dau stack la: %d",top(s));
//	while(isempty(s)){
//		printf("%d\t",top(s)); 
//		pop(s,m);
//	}	
}
