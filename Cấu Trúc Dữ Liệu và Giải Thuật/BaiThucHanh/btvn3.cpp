#include<stdio.h>
#include<conio.h>
#include<stdlib.h>

int stt=0,dakham=0;

struct bn{
	int stt;
	char ten[30];
	int tuoi;
};
struct node{
	bn info;
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
node* createnode(bn x){
	node* p = new node;
	p->info=x;
	p->next = NULL ;
	return p;
}
// a)
// insert tail
void push(queue &l,bn x){
	node *p = createnode(x);
	if(isempty(l)) l.phead=l.ptail= p;
	else{
		l.ptail->next=p;
		l.ptail	= p; 
		}
}
void nhap1bn(bn &x,int y){
	x.stt=y;
	printf("\nMoi nhap ho & ten benh nhan: ");
	fflush(stdin) ; gets(x.ten);
	printf("Moi nhap so tuoi: ");	scanf("%d",&x.tuoi);
}
void input(queue &l,int &stt,int n){
	bn x;
	init(l);
	for(int i=0;i<n;i++){
		printf("\nNhap danh sach benh nhan thu %d: ",i+1);
		nhap1bn(x,stt++);
		push(l,x);
	}
}
// b-c-d)
// Lay dau queue va xoa
node* pop(queue &l,int &dakham){
	if(l.phead == NULL)
		return NULL;
	dakham++;
	node* p=l.phead;
	l.phead=l.phead->next;
	return p;
}
// e)
void browselist(queue l){
	printf("\n\tDANH SACH BENH NHAN CON TRONG HANG DOI KHAM\n");
	while(l.phead != NULL){
		printf("%d\t%-30s\t\t %d\n",l.phead->info.stt,l.phead->info.ten,l.phead->info.tuoi);
		l.phead=l.phead->next;
	}
}
int main(){
	queue l;
	bn x;
	char k;
	int dem=0,n;
	printf("\nNhap so luong danh sach benh nhan: ");
	scanf("%d",&n);
	input(l,stt,n);	
	while(1){
		printf("\n\t\t*** CHUONG TRINH QUAN LI DANH SACH BENH NHAN ***\n");
		printf("\t 1. Them 1 benh nhan vao Queue");
		printf("\n\t 2. Lay benh nhan tiep theo toi kham");
		printf("\n\t 3. Cho biet so luong nguoi da tham gia kham");
		printf("\n\t 4. Cho biet so luong nguoi chua kham");
		printf("\n\t 5. Xuat danh sach benh nhan con trong hang doi kham");
		printf("\n\t 0. Thoat chuong trinh\n");
		do{
				printf("\nMoi chon chuc nang: ");	
				k=getche();
		}while(k != '1' && k != '0' && k != '2' && k != '3' && k != '5' && k != '4');
			k=k-48;
		switch( k ){
			case 1:
				n++;
				nhap1bn(x,stt++);
				push(l,x);			
				break;
			case 2:
				node* temp;
				temp = pop(l,dakham);
				if(temp == NULL)
					printf("\nDa het danh sach kham benh");
				else
					printf("\nBenh nhan tiep theo se kham la: %s",temp->info.ten);
				break;
			case 3: 
				printf("\nSo benh nhan da kham la: %d",dakham);
				break;
			case 4:
				printf("\nSo benh nhan chua kham la: %d",n-dakham);
				break;
			case 5:
				browselist(l);
				break;
			case 0:
				printf("\nBan da thoat chuong trinh");
				return 0;
		}
	}
	return 0;
}
