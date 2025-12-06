#include<stdio.h>
#include<conio.h>
#include<stdlib.h>
#include<string.h>

struct node{
	char benhnhan[30];
	struct node * next;
};

struct queue{
	node * phead;
	node * ptail;
};
void init(queue &l){
	l.phead =NULL;
	l.ptail =NULL;
}
int isempty(queue l){
	return (l.phead == NULL);
}
node* createnode(char x[]){
	node* p = new node;
	strcpy(x,p->benhnhan);
	p->next = NULL ;
	return p;
}
// a)
// insert tail
void push(queue &l,char x[]){
	node *p = createnode(x);
	if(isempty(l)) l.phead=l.ptail= p;
	else{
		l.ptail->next=p;
		l.ptail	= p; 
		}
}
void input(queue &l){
	int n;
	char x[30];
	printf("\nNhap so luong danh sach benh nhan: ");
	scanf("%d",&n);
	init(l);
	for(int i=0;i<n;i++){
		printf("\nNhap danh sach benh nhan thu %d: ",i+1);
		fflush(stdin); gets(x);
		push(l,x);
	}
}
// b)
// Lay dau queue va xoa
int demsokham(int &dem){
	dem++;
	return dem;
}
node* pop(queue &l){
	if(l.phead == NULL)
		return NULL;
	node* p=l.phead;
	l.phead=l.phead->next;
	return p;
}
int countlist(queue l){
	int dem=0;
	while(l.phead != NULL){
		dem++;
		l.phead=l.phead->next;
	}
	return dem;
}
void browselist(queue l){
	printf("\n\tDANH SACH\n");
	while(l.phead != NULL){
		printf("\t%s\n",l.phead->benhnhan);
		l.phead=l.phead->next;
	}
}





int main(){
	queue l;
	char bn[30];
	char k;
	int x,y,dem=0;
	input(l);	
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
				push(l,bn);			
				break;
			case 2:
				node* temp;
				temp = pop(l);
				demsokham(dem);
				printf("\nBenh nhan tiep theo se kham la: %d",temp->benhnhan);
				break;
			case 3: 
				printf("\nSo benh nhan da kham la: %d",demsokham(dem));
				break;
			case 4:
				printf("\nSo benh nhan da kham la: %d",demsokham(dem));
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
