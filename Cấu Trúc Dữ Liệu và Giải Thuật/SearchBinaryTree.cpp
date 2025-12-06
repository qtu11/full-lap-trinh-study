#include<stdio.h>
#include<stdlib.h>
#include<conio.h>
#include<string.h>
#include<ctype.h>

struct node{
	int data;
	struct  node* l;
	struct  node* r;
};
typedef struct node* tree;
tree root;
// 1.Khoi tao cay
void init(tree &root){
	root=NULL;
}
// 2.Kiem tra rong
int isempty(tree roof){
	return (root == NULL);
}
// 3. Tao nut
node* createNode(int x){
	node* q = new node;
	q->data = x;
	q->l = NULL;
	q->r = NULL;
	return q;
}
// Them Nuut
void insertNode(tree &root,int x){
	if(root != NULL){
		if(root->data == x)
			return;
		if(root->data > x)
			return insertNode(root->l,x);
		else
			return insertNode(root->r,x);
		else
			root=x;
	}
}
// 4.Them trai
void insertleft(tree p,int x){
	if(p == NULL)
		printf("\nNut khong ton tai");
	else
		if(p->l != NULL)
			printf("\nNut p da co con ben trai");
		else
			p->l=createNode(x);
}
// 5. Them phai

// 6. Xoa trai

// 7. Xoa phai

// Tao CAY bang cach nhap truc tiep tu ban phim
void createTree(tree &root){
	int x,n;
	printf("Nhap so phan tu cay: ");
	scanf("%d",&n);
	for(int i=0;i<n;i++){
		printf("\nNhap giatri node: ");
		scanf("%d",&x);
		insertNode(root,x);
	}
}
// 8. DUYET CAY
// duyet truoc
void NLR(tree root){ // duyet theo thu tu Goc-Trai-Phai
	if(root != NULL){
		printf("Hello first data: %d",root->data); // tham goc
		NLR(root->l); // tham trai
		NLR(root->r); // tham phai
	}
}
// duyet giua
void LNR(tree root){  // duyet theo thu tu Trai-Goc-Phai
	if(root != NULL){
		LNR(root->l);
		printf("Hello first data: %d",root->data); // tham goc
		LNR(root->r);
	}
}
// duyet sau Trai-Phai-Giua
void LRN(tree root){
		if(root != NULL){
		LNR(root->l);
		LNR(root->r);
		printf("Hello first data: %d",root->data); // tham goc
	}
}
// 9. Tim kiem node x
node* search(tree root,int x){
	if(root != NULL){
		if(root->data==x)
			return root;
		if(root->data>x)
			return search(root->l,x);
	}
	else
		return NULL;
}
//node* search(tree root,char x){
//	node* p= new node;
//	if(root == NULL)	return NULL;
//	if(root->data == x)
//		return root;
//	p=search(root->l,x);
//	if(p==NULL)
//		p=search(root->r,x);
//	return p;
//}
// 10. Cay nhi phan tim kiem

// 11.Xoa cay
void xoaCay(tree &root){
	if(root != NULL){
		xoaCay(root->l);
		xoaCay(root->r);
		delete root;
	}
}
int main(){
	tree root;
	init(root);
	createTree(root);
	printf("\nDuyet truoc");
	NLR(root);
//	char x;
//	printf("\nNhap ki tu: ");
//	scanf("%c",&x);
//	if(search(root,x)==NULL)
//		printf("\nKo");
//	else
//		printf("\nThay");
//	return 0;
}
