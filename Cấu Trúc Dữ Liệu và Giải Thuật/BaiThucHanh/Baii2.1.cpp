#include<stdio.h>
#include<conio.h>
// Danh sach lien ket o nho co dan theo du lieu
struct node{
	int info;
	struct node* next;
};
struct list{
	// giu dia chi cua node dau tien
	node* phead;
};
//	a)
 // khoi dong
void init(list &l){
 	l.phead = NULL;
 }
 // NULL or not NULL
int isempty(list l){
	return (l.phead == NULL);
}
// Tao node gia tri x
node* createnode(int x){
	node* p= new node;
	p->info=x;
	p->next=NULL;
	return p;
}
// Them phan tu moi vao dau danh sach
void insertfirst(list &l,int x){
	node* q=createnode(x);
	if(isempty(l))	l.phead=q;
	else{
		q->next = l.phead;
		l.phead=q;
	}
}
// Nhap du lieu dau vao
void input(list &l){
	int x,i=1;
	// khoi tao danh sach
	init(l);
	while(x != -1){
		printf("\nNhap gia tri phan tu thu %d: ",i);
		scanf("%d",&x);
		insertfirst(l,x);
		i++;
	}
}
//	b)
// Xuat danh sach
void showlist(list l){
	node* q = l.phead;
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
node* search(list l,int x){
	node* tim=l.phead;
	while(tim->info != x && tim != NULL){
		tim=tim->next;
	}
	return tim;
}
void insertafter(list l,int y,int x){
	node *p =createnode(y);
	l.phead =search(l,x);
	if(l.phead != NULL){
		p->next=l.phead->next;
		l.phead->next=p;
	}
}
//	d)
// dem so node <3
int demnode(list l){
	int a=0;
	while(l.phead != NULL){
		a++;
		l.phead=l.phead->next;
	}
	return a;
}
//	e)
void giatrinode(list l){
	int x,i=-1;
	printf("\nMoi nhap nut thu k ma ban muon biet gia tri: ");
	scanf("%d",&x);	
	while(l.phead != NULL ){
		i++;
		if(i == x)
			break;
		l.phead=l.phead->next;
	}
	printf("\nGia tri nut thu %d trong danh sach la: %d",x,l.phead->info);
}
int main(){
	int x,y,dung=0,chon;
	list l;
	while(1){
		printf("\n\t\t*** MENU ***\n");
		printf("\n\t 1. Nhap du lieu: Nhap 1 day so nguyen");
		printf("\n\t 2. Xuat day so nguyen");
		printf("\n\t 3. Tim gia tri x trong mang gan nut=x va them gia tri y sau nut");
		printf("\n\t 4. Dem nut tren danh sach");
		printf("\n\t 5. Cho biet gia tri nut thu k trong danh sach");
		printf("\n\t 6. Thoat chuong trinh");
		char k;
		do{
			printf("\n\nMoi chon chuc nang: ");	
			k=getche();
		} while(k != '1' && k != '2' && k != '3' && k != '4' && k != '5' && k != '6');
		chon=k-48;
		switch( chon ){
			case 1:
				input(l);
				dung=1;
				break;
			case 2:
				if(dung == 0){
					printf("\nBan chua nhap du lieu ! ");
					break;
				}
				showlist(l);
				break;
			case 3: 
				if(dung == 0){
					printf("\nBan chua nhap du lieu ! ");
					break;
				}
				printf("\nNhap gia tri muon tim: ");	scanf("%d",&x);
				printf("\nMoi nhap gia tri can chen: ");	scanf("%d",&y);
				insertafter(l,y,x);
				printf("\nSau khi them ,danh sach hien la:");		
				showlist(l);
				break;
			case 4:
				if(dung == 0){
					printf("\nBan chua nhap du lieu ! ");
					break;
				}
				printf("\nSo nut tren danh sach la: %d",demnode(l));
				break;
			case 5:
				if(dung == 0){
					printf("\nBan chua nhap du lieu ! ");
					break;
				}	
				giatrinode(l);
				break;
			case 6:
				printf("\nBan da thoat chuong trinh");
				return 0;
		}
	}
}

