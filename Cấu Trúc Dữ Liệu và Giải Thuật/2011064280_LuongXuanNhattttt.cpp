#include<stdio.h>

// danh sach lien ket quan li so nguyen

struct node{
	int info;
	struct node* next;
};

// khoi dong danh sach lien ket
void init(node* &p){
	p = NULL;
}

// Kiem tra danh sach co rong hay khong
int isempty(node* p){
	return (p == NULL);
}

// Tao nut
// 1 là nut chua du lieu - 2 là con tro
node* createNode(int x){
	node*q = new node;
	q->info = x;
	q->next = NULL;
	return q;
}

// Them gia tri vao dau danh sach
void insertFirst(node* &p,int x){
	node* q = createNode(x);
	if(p == NULL)
		p = q; // dien that su
	else{
		q->next = p;
		p = q;
	}
}

// Xoa dau
void deleteFirst(node* &p)
{
	node* tam = p;
	if(p != NULL){
		p = p->next;
		delete tam;
	}
}


// them sau nut p
void insertAfter(node* p,int x){ // q,9 
	node* tam = createNode(x);
	if(p != NULL){
		tam -> next = p->next;
		p->next = tam;
	}
}

// Them vao cuoi danh sach
void insertLast(node* p,int x){
	node* tam=createNode(x);
	if(p == NULL)
		p = tam;
	else
	{
		// chuyen contro den cuoi
		while(p->next != NULL){
			p=p->next;
		}
		p->next=tam;
	}
}
	
// tim 1 nut co gia tri x
node* search(node* p,int x){
	node* q = p;
	while(q->info != x && q != NULL){
		q = q->next;
	} 
	return q;
}

// xoa sau nut p
void deleteAfter(node* p){
	node* q ;
	if(p == NULL || p->next==NULL){
		printf("\nKhong the xoa\n");
	}
	else{
		q = p->next;
		p->next = q->next;	
		delete q;
	}
}

// input data for list
void input(node* &p){
	int n,x;
	init(p); // khoi tao danh sach
	printf("Nhap so phan tu node: ");		scanf("%d",&n);
	for(int i=0;i<n;i++)
	{
		printf("Nhap gia tri phan tu thu %d cua node: ",i+1);
		scanf("%d",&x);
		insertFirst(p,x);
	}
}

// Xoa danh sach
void cleanList(node* &p){
	node* q;
	while(p != NULL)
	{
		q=p;
		p=q->next;
		delete q;
	}
}

// Sap xep danh sach tang dan
void sortList(node* &p){
	node* a, *b,* amin;
	a=p;
	int min;
	while(a->next != NULL){
		min = a->info;
		amin = a;
		for( b = a->next; b != NULL; b=b->next)
			if(b->info < min){
				min= b->info;
				amin=b;
			}
		amin->info = a->info;
		a->info = min;
		a=a->next;
	}
}

// Hien thi full danh sach
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

int main(){
	node* p; // Luu dia chi nut dau tien trong danh sach
	input(p);
	printf("\nHien thi danh sach\n");
	showList(p);	// in danh sach ra man hinh
	
	// tim 1 nut p co info = x
	
	int x;	
	printf("\n\tNhap x: ");
	scanf("%d",&x);
	node* q = search(p,x);
	printf("\n\tThem sau nut p\n");
	insertAfter(q,9);
	showList(p);
	
	 //q = search(p,x);
	printf("\n\tThem cuoi :\n");
	insertLast(q,9);
	showList(p);

	deleteFirst(p);
	printf("\n\tXoa dau :\n");
	showList(p);

	printf("\tXoa sau :\n");
	deleteAfter(p);
	showList(p);
	
	printf("\t\nDanh sach duoc sap xep: \n");
	sortList(p);
	showList(p);
	
	cleanList(p);
	printf("\t\nXoa tat ca danh sach\n");
	showList(p);
	return 0;
}









