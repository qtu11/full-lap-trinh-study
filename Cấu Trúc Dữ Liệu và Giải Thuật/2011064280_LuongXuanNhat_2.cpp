#include<stdio.h>

struct node{
	unsigned int info;
	struct node* next;
};

// cau 1
// Tao danh sach LKD ,them dau vs du lieu so nguyen duong
void init(node* &p){
	p = NULL;
}

int isempty(node* p){
	return (p == NULL);
}

node* createNode(int x){
	node*q = new node;
	q->info = x;
	q->next = NULL;
	return q;
}

void insertFirst(node* &p,unsigned int x){
	node* q = createNode(x);
	if(p == NULL)
		p = q; 
	else{
		q->next = p;
		p = q;
	}
}

void input(node* &p){
	int n,x;
	init(p); // khoi tao danh sach
	printf("Nhap so phan tu cua danh sach: ");		scanf("%d",&n);
	for(int i=0;i<n;i++)
	{
		printf("Nhap gia tri phan tu thu %d : ",i+1);
		scanf("%u",&x);
		insertFirst(p,x);
	}
}

// cau 2
// Xuat danh sach LKD
void showList(node* p){
	node* q = p;
	if(q == NULL)
		printf("\nDanh Sach Rong");
	else{
		while(q != NULL){
			printf("%d \t",q -> info);
			q = q -> next;
		}
		printf("\n");
	}
}

// cau 3
// Viet ham xoa phan tu cuoi danh sach
void deletelast(node* &p){
	node* tam=p;
	while(tam->next->next != NULL){
		tam=tam->next;
	}
	tam->next=tam->next->next;
	tam=NULL;
}

// cau 4
void themmoi(node* &p){
	unsigned int n;
	int kt=0;
	node* tam=p;
	do{
		printf("Nhap phan tu moi: ");		scanf("%u",&n);
		kt=0;
		while(tam != NULL){
			if(n == tam->info){
				kt=1;
				break;
			}
			tam=tam->next;
		}
		if(kt == 1)
			printf("Ban nhap trung so ! Moi nhap lai\n");
	}while(kt == 1);
	insertFirst(p,n);
}
int main(){
	node* p;
	input(p);
	printf("\nHien thi danh sach\n");
	showList(p);
	deletelast(p);
	showList(p);
	themmoi(p);
	showList(p);
	return 0;
}
