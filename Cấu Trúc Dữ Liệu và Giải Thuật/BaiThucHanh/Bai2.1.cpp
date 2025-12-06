#include<stdio.h>

// Danh sach lien ket o nho co dan theo du lieu
struct node{
	int info;
	struct node* next;
};
struct list{
	// giu dia chi cua node dau tien
	node* p;
};
//	a)
 // khoi dong
 void init(node *&p){
 	p= NULL;
 }
 // NULL or not NULL
int isempty(node* p){
	return (p == NULL);
}
// Tao node gia tri x
node* createnode(int x){
	node* p= new node;
	p->info=x;
	p->next=NULL;
	return p;
}
// Them phan tu moi vao dau danh sach
void insertfirst(node* &p,int x){
	node* q=createnode(x);
	if(p == NULL)	p=q;
	else{
		q->next = p;
		p=q;
	}
}
// Nhap du lieu dau vao
void input(node* &p){
	int x,i=1;
	// khoi tao danh sach
	init(p);
	while(x != -1){
		printf("\nNhap gia tri phan tu thu %d: ",i);
		scanf("%d",&x);
		insertfirst(p,x);
		i++;
	}
}
//	b)
// Xuat danh sach
void showlist(node* p){
	node* q = p;
	printf("\n");
	if(q == NULL){
		printf("\nDanh sach rong");
	}
	else{
		while(q != NULL){
			printf("%d \t",q->info);
			q = q->next;
		}
		printf("\n");
	}
}
//	c)
// Tim x them vao sau node p
node* search(node* p,int x){
	node* tim=p;
	while(tim->info != x && tim != NULL){
		tim=tim->next;
	}
	return tim;
}
void insertafter(node* p,int x){
	node *q=createnode(x);
	if(p != NULL){
		q->next=p->next;
		p=q;
	}
}
int main(){
	int n;
	node* p;
//	printf("Nhap so phan tu cua danh sach: ");	scanf("%d",&n);
	input(p);
	showlist(p);
}
