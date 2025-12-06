//Ho tên:TranDucTai		LuongXuanNhat
//MSSV : 2090606906		2011064280
// Chude4_Cau1

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

void init(Node* &p){ 
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
int getHeight(Node *p){
	if (p == NULL)
	return 0;
	return p->height;
}
int balanceFactor(Node *p){
	if (p == NULL)
	return 0;
	return getHeight(p->left) - getHeight(p->right);
}
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
	Node* p=NULL;
	for (int i = 0; i < n; i++){
		p = insert(p,a[i]);
	}
	return p;
}
void NLR(Node* p){ // duyet theo thu tu Goc-Trai-Phai
	if(p != NULL){
		printf(" %d",p->info); // tham goc
		NLR(p->left); // tham trai
		NLR(p->right); // tham phai
	}
}
int main(){
	int n,a[100],kt,x=1,y=1;
	char k;
	Node* p;
	init(p);
	printf("\nNhap so phan tu cua cay: ");
	scanf("%d",&n);
	for (int i = 0; i < n; i++){
		printf("Nhap phan tu thu %d: ",i+1);
		scanf("%d",&a[i]);
	}
	createAVL(a,n);
	printf("\nDuyet cay: "); p=createAVL(a,n); NLR(p);
	return 0;
}

