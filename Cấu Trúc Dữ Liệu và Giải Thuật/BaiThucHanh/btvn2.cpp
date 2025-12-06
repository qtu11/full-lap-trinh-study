#include<stdio.h>
#include<conio.h>

struct ps{
	int tu;
	int mau;
};
struct node{
	ps value;
	struct node* next;
};
struct list{
	node* phead;
};

// 	a)
 // khoi dong
 void init(list &l){
 	l.phead= NULL;
 }
 // NULL or not NULL
int isempty(list l){
	return (l.phead == NULL);
}
// Tao node gia tri x
node* createnode(ps x){
	node* p= new node;
	p->value=x;
	p->next=NULL;
	return p;
}
// Them phan tu moi vao dau danh sach
void insertfirst(list &l,ps x){
	node* q=createnode(x);
	if(isempty(l))	l.phead=q;
	else{
		q->next = l.phead;
		l.phead=q;
	}
}
// Nhap thong tin mang phan so
void nhap1ps(ps &x){
	printf("\nMoi nhap tu so: ");	scanf("%d",&x.tu);
	do{
		printf("\nMoi nhap mau so: ");	scanf("%d",&x.mau);
		if(x.mau == 0)	printf("Ban nhap sai ! Moi nhap lai");
	}while(x.mau == 0);
}
// Nhap du lieu dau vao
void input(list &l){
	ps x;
	int n;
	printf("\nMoi nhap so luong phan so: ");	scanf("%d",&n);
	// khoi tao danh sach
	init(l);
	for(int i=0;i<n;i++){
		printf("\nNhap gia tri phan so thu %d\n",i+1);
		nhap1ps(x);
		insertfirst(l,x);
	}
}

//	 b)
// xuat
void showlist(list l){
	printf("\n\t\tDANH SACH PHAN SO\n");
	node* p;
	p=l.phead;
	while(p!=NULL)
    {
        printf("%d/%d\t",p->value.tu,p->value.mau);
        p=p->next;
    }
}

//	 c)
// dem so luong phan so co tu so > 1
int countps(list l){
	node* p;
	int dem=0;
	p=l.phead;
	while(p != NULL){
		if(p->value.tu > 1)
			dem++;
		p=p->next;
	}
	return dem;
}

// 	d)
// Rut gon phan so
int ucln(int x,int y){
	while(x != y)
	{
		if(x>y)	x=x-y;
		else	y=y-x;
	}
	return x;
}
void pstg(list l){
	int rutgon;
	node* p=l.phead;
	while(p != NULL){
		rutgon=ucln(p->value.tu,p->value.mau);
		p->value.tu/=rutgon;
		p->value.mau/=rutgon;
		p=p->next;
	}
}
int main(){
	list l;
	int chon;
	char k;
	input(l);
	while(1){
		printf("\n\t\t*** MENU PHAN SO ***\n");
		printf("\n\t1. Xuat mang phan so");
		printf("\n\t2. Dem so luong phan so co tu so > 1");
		printf("\n\t3. Rut gon phan so");
		printf("\n\t0. Thoat chuong trinh");
		do{
			printf("\nMoi chon chuc nang: ");	
			k=getche();
		}while(k != '1' && k != '0' && k != '2' && k != '3');
		k=k-48;
		switch( k ){
			case 1:
				showlist(l);
				break;
			case 2:
				printf("\nSo phan so co tu so > 1 la: %d",countps(l));
				break;
			case 3:
				pstg(l);
				showlist(l);
				break;
			case 0:
				printf("\nBan da thoat chuong trinh");
				return 0;
		}
	}
}



