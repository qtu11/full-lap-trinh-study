#include<stdio.h>
#include<stdlib.h>
#include<conio.h>
#include<math.h>

typedef struct node{
	int info;
	int height;
	struct node *left;
	struct node *right;
}Node;

void Init(Node* &p){ 
	p=NULL ;
}
Node* createNode(int x){
	Node* p = new node;
	if(p==NULL) return 0;
	p->info = x; 
	p->left = NULL;
	p->right = NULL;
	p->height = 1;
	 return p;
}
// Lay chieu cao cua cay
int getHeight(Node *p){
	if (p == NULL)
	return 0;
	return p->height;
}
// Tinh chi so can bang cua nut
int balanceFactor(Node *p){
	if (p == NULL)
	return 0;
	return getHeight(p->left) - getHeight(p->right);
}
// GTLN
int max(int a, int b){
	return a > b ? a : b;
}
Node *rotateLeft(Node *p){
	if (p == NULL)	// Rong 
		return NULL;
	if (p->right == NULL)	// Ko xoay vi khong co nut con phai
		return NULL;
	Node *pivot = p->right; // Xoay
	p->right = pivot->left; // Trai pivot->Phai p
	pivot->left = p;		// p=con trai
	p->height = 1 + max(getHeight(p->right), getHeight(p->left));
	pivot->height = 1 + max(getHeight(pivot->right), getHeight(pivot->left));
	return pivot;
}
Node *rotateRight(Node *p){
	if (p == NULL)	// Rong 
		return NULL;
	if (p->left == NULL)	// Ko xoay vi khong co nut con trai
		return NULL;
	Node *pivot = p->left; // Xoay
	p->left = pivot->right; // Trai pivot->Phai p
	pivot->right = p;		// p=con trai
	p->height = 1 + max(getHeight(p->right), getHeight(p->left));
	pivot->height = 1 + max(getHeight(pivot->right), getHeight(pivot->left));
	return pivot;
}
// Thuc hien can bang cay BST
Node * balance(Node *p){
	if (balanceFactor(p) < -1)
	{
		if (balanceFactor(p->right) > 0){
			p->right = rotateRight(p->right);
		}
		p = rotateLeft(p);
	}
	else 
		if (balanceFactor(p) > 1){
			if (balanceFactor(p->left) < 0)
			{
				p->left = rotateLeft(p->left);
			}
			p = rotateRight(p);
		}
	return p;
}
//Them nut 
Node *insert(Node *p, int x){
	if (p == NULL)
		return createNode(x);
	if (x < p->info) // them p
		p->left = insert(p->left, x);
	else 
		if (x > p->info) // them t
			p->right = insert(p->right, x);
	p->height = 1 + max(getHeight(p->left), getHeight(p->right));
	return balance(p); 
}
Node* createAVL(int a[], int n){
	Node *p = NULL;
	for (int i = 0; i < n; i++){
		p = insert(p, a[i]);
	}
	return p;
}
// 8. DUYET CAY
// duyet truoc
void NLR(Node* p){ // duyet theo thu tu Goc-Trai-Phai
	if(p != NULL){
		printf("-> %d",p->info); // tham goc
		NLR(p->left); // tham trai
		NLR(p->right); // tham phai
	}
}
// duyet giua
void LNR(Node* p){  // duyet theo thu tu Trai-Goc-Phai
	if(p != NULL){
		LNR(p->left);
		printf("-> %d",p->info); // tham goc
		LNR(p->right);
	}
}
// duyet sau Trai-Phai-Giua
void LRN(Node* p){
		if(p != NULL){
		LNR(p->left);
		LNR(p->right);
		printf("-> %d",p->info); // tham goc
	}
}
int checkTree(Node *p){
	if(p==NULL)
        return 0;
}
int main(){
	int n,a[100],kt,x=1,y=1;
	char k;
	Node* p;
	while(1){
		printf("\n\t\t*** CAY NHI PHAN TIM KIEM ***\n");
		printf("\n\t1. Xay dung cay");
		printf("\n\t2. Them phan tu vao cay nhi phan tu 1 mang");
		printf("\n\t3. Kiem tra cay nhi phan tim kiem co can bang hay khong ?");
		printf("\n\t4. Duyet cay ");
		printf("\n\t0. Thoat chuong trinh");
		do{
			printf("\nMoi chon chuc nang: ");	
			k=getche();
		}while(k != '1' && k != '0' && k != '2' && k != '3' && k != '4' );
		k=k-48;
		switch( k ){
			case 1:
				Init(p);
				kt=1;
				printf("\nCay da duoc xay dung\n");
				break;
			case 2:
				printf("\nNhap so phan tu cua mang: ");
				scanf("%d",&n);
				for (int i = 0; i < n; i++){
					printf("Nhap phan tu thu %d: ",i+1);
					scanf("%d",&a[i]);
				}
				createAVL(a,n);
				printf("\nDa them cac phan tu cua mang vao cay nhi phan \n");
				kt=2;
				break;
			case 3:
				if(kt==0 || kt==1)
					printf("\nCay chua duoc xay dung hoac ban chua nhap du lieu vao cay\n");
				else{
					x=getHeight(p->left);
					y=getHeight(p->right);
					if(abs(x-y) <= 1)
						printf("\nCay nhi phan da can bang\n");
					else	printf("\nCay nhi phan chua can bang\n");
				}
				break;
			case 4:
				if(kt==0 || kt==1)
					printf("\nCay chua duoc xay dung hoac ban chua nhap du lieu vao cay\n");
				else{
					int s=0;
					p = createAVL(a,n);
					printf("\n\t1. Duyet Truoc\n");
					printf("\t2. Duyet Giua");
					printf("\n\t3. Duyet Sau\n");
					printf("Moi chon: "); scanf("%d",&s);
					if(s==1){
						printf("\nDuyet Truoc\n");
						NLR(p);}
					if(s==2){
						printf("\nDuyet Giua\n");
						LNR(p);}
					if(s==3){
						printf("\nDuyet Sau\n");
						LRN(p);}
				}
				break;
			case 0:
				printf("\nBan da thoat chuong trinh");
				return 0;
		}
	}
}







