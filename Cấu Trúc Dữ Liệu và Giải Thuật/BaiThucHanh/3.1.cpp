#include<stdio.h>
#include<conio.h>


struct node{
	int giatri;
	struct node* next;
};
struct stack{
	node* phead;
	node* ptail;
};
void init(stack &l){
	l.phead =NULL;
	l.ptail =NULL;
}
int isempty(stack l){
	return (l.phead == NULL);
}
node* createnode(int x){
	node* p = new node;
	p->giatri = x;
	p->next = NULL ;
	return p;
}
void push(stack &l,int x){
	node *p = createnode(x);
	if(isempty(l)) l.phead=l.ptail= p;
	else 
	{
		p->next = l.phead;
		l.phead = p;
	}
}
void input(stack &l){
	int n,x;
	printf("\nNhap so luong danh sach: ");
	scanf("%d",&n);
	init(l);
	for(int i=0;i<n;i++){
		printf("\nNhap phan tu thu %d: ",i+1);
		scanf("%d",&x);
		push(l,x);
	}
}
node* pop(stack &l){
	if(l.phead == NULL)
		return NULL;
	node* p=l.phead;
	l.phead=l.phead->next;
	return p;
}
int countlist(stack l){
	int dem=0;
	while(l.phead != NULL){
		dem++;
		l.phead=l.phead->next;
	}
	return dem;
}
void browselist(stack l){
	printf("\n\tDANH SACH\n");
	while(l.phead != NULL){
		printf("%d\t",l.phead->giatri);
		l.phead=l.phead->next;
	}
}
int main(){
	stack l;
	char k;
	int x,y;
	input(l);
	while(1){
		printf("\n\t\t***MENU DANH SACH SO NGUYEN***");
		printf("\n 1. Them 1 So Nguyen Vao Stack");
		printf("\n 2. Lay ra va xoa phan tu dau tien trong stack");
		printf("\n 3. Dem so luong phan tu trong stack");
		printf("\n 4. Hien thi tat ca phan tu trong stack");
		printf("\n 5. Thoat chuong trinh\n");
		do{
			printf("\nMoi chon chuc nang: ");	
			k=getche();
		}while(k != '1' && k != '0' && k != '2' && k != '3' && k != '5' && k != '4');
		k=k-48;
		switch( k ){
			case 1:
				printf("\nMoi nhap so: ");
				scanf("%d",&x);
				push(l,x);
				break;
			case 2:
				node* temp;
				temp = pop(l);
				printf("\nPhan tu xoa dau stack la: %d",temp->giatri);
				break;
			case 3: 
				printf("\nSo luong phan tu trong stack la: %d",countlist(l));
				break;
			case 4:
				browselist(l);
				break;
			case 5:
				printf("\nBan da thoat chuong trinh");
				return 0;
		}
	}
}
