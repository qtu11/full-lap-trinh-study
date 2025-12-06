#include<stdio.h>


// a
struct ticket{
	int stt;
	int quay;
};
// b
struct node{
	ticket giatri;
	struct node* next;
};
struct queue{
	node* phead;
	node* ptail;
};
void init(queue &l){
	l.phead =NULL;
	l.ptail =NULL;
}
int isempty(queue l){
	return (l.phead == NULL);
}
// c
void them1vecho(ticket &x){
	printf("\nMoi nhap so thu tu: ");
	scanf("%d",&x.stt);
	printf("\nMoi nhap so quay: ");
	scanf("%d",&x.quay);
}
node* createnode(ticket x){
	node* p = new node;
	p->giatri = x;
	p->next = NULL ;
	return p;
}
void push(queue &l,ticket x){
	node *p = createnode(x);
	if(isempty(l)) l.phead=l.ptail= p;
	else{
		l.ptail->next=p;
		l.ptail	= p; 
		}
}
void input(queue &l){
	ticket x;
	printf("\nThem 1 ve cho:\n");
	them1vecho(x);
	push(l,x);
}
int countlist(queue l){
	int dem=0;
	while(l.phead != NULL){
		dem++;
		l.phead=l.phead->next;
	}
	return dem;
}
node* pop(queue &l){
	if(l.phead == NULL)
		return NULL;
	node* p=l.phead;
	l.phead=l.phead->next;
	return p;
}
void showlist(queue l){
	printf("\nSo ve \t Quay\n");
	while(l.phead != NULL){
		printf("%d\t  %d\n",l.phead->giatri.stt,l.phead->giatri.quay);
		l.phead=l.phead->next;
	}
}
int main()
{
	int a;
	ticket x;
	queue l;
	init(l);
	while(1){
		printf("\n\t\tMENU VE CHO\n");
		printf("\t1. Thêm 1 ve cho moi (Khach hang moi toi giao dich)\n");
		printf("\t2. Kiem tra hang doi con bao nhieu ve\n");
		printf("\t3. Goi khach den giao dich\n");
		printf("\t4. Hien thi hang cho\n");
		printf("\tNhan phim bat ki de thoat chuong trinh\n");
		printf("Moi chon chuc nang: ");		scanf("%d",&a);
		switch( a ){
			case 1:
				input(l);
				break;
			case 2: 
				printf("\nHang doi con %d ve cho",countlist(l));
				break;
			case 3:
				printf("\nDa thuc hien goi khach hang tiep theo den giao dich");
				pop(l);
				break;
			case 4:
				showlist(l);
				break;
			default:
				printf("\nBan da thoat chuong trinh");
				return 0;	
		}
	}
}
