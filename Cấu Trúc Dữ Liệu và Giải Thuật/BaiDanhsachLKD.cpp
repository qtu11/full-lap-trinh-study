#include<stdio.h>

struct node{
	int info;
	struct node* next;
};
 // khoi dong
 void init(node *&p){
 	p= NULL;
 }
 //Kiem tra danh sach rong
 int isempty(node* p){
 	return (p == NULL);
}
// Tao nut
node* createNode(int x){
	node* q = new node;
	q->info = x;
	q->next = NULL;
	return q;
}
//Them gia tri vao dau danh sach
void themDau(node* &p,int x){
	node* q= createNode(x);
	if(p == NULL)
		p=q;
	else{
		q->next = p;
		p=q;	
	}
}
//Them sau nut p
void themSau(node* p,int x){
	node* tam = createNode(x);
	if(p != NULL){
		tam -> next = p->next;
		p->next = tam;
	}
}
// Them cuoi danh sach
void themCuoi(node* p,int x){
	node* tam = createNode(x);
	if(p == NULL)
		p = tam;
	else{
		// chuyenr con tro nut ve cuoi
		while(p->next != NULL){
			p=p->next;
		}
		p->next=tam;
	}
}
// Xoa dau
void xoaDau(node* &p){
	node* tam=p;
	if(p != NULL){
		p=p->next;
		delete tam;
	}
}
// Xoa sau nut p
void xoaSau(node* p){
	node* q;
	if(p == NULL || p->next==NULL){
		printf("\nKhong co gia tri sau");}
	else{
		q=p->next;
		p->next=q->next;
		delete q;
	}
}
// Tim nut co gia tri x
node* search(node* p,int x){
	node* q=p;
	while(q->info != x && q != NULL){
		q->next;
	}
	return q;
}
// Nhap du lieu cho danh sach
void input(node* &p){
	int n,x;
	init(p); // Khoi tao danh sach
	printf("Nhap so phan tu: ");	scanf("%d",&n);
	for(int i=0;i<n;i++)
	{
		printf("Nhap gia tri phan tu thu %d cua node: ",i+1);
		scanf("%d",&x);
		themDau(p,x);
	}
}
//Hien thi danh sach
void showList(node* p){
	node* q=p;
	if(q == NULL){
		printf("\nDanh sach rong");
	}
	else{
		while(q != NULL){
			printf("%d \t",q->info);
			q=q->next;
		}
		printf("\n");
	}
}
// Xoa danh sach
void xoaHet(node* &p){
	node*q;
	while(p != NULL){
		q=p;
		p=q->next;
		delete q;
	}
}
// Sap xep danh sach

int main(){
	
}
