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
tree createNode(char x){
	tree q = new node;
	q->data = x;
	q->l = NULL;
	q->r = NULL;
	return q;
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
	char x;
	printf("Nhap gia tri node: ");
	x = getch();
	if(isspace(x) == 0){
		root = new node;
		root->data = x;
		printf("\nCon trai cua %c ",x);
		createTree(root->l);
		printf("\nCon phai cua %c ",x);
		createTree(root->r); 
	}  else
		root= NULL;
}
// 8. DUYET CAY
// duyet truoc
void NLR(tree root){ // duyet theo thu tu Goc-Trai-Phai
	if(root != NULL){
		printf(" %c",root->data); // tham goc
		NLR(root->l); // tham trai
		NLR(root->r); // tham phai
	}
}
// duyet giua
void LNR(tree root){  // duyet theo thu tu Trai-Goc-Phai
	if(root != NULL){
		LNR(root->l);
		printf(" %c",root->data); // tham goc
		LNR(root->r);
	}
}
// duyet sau Trai-Phai-Giua
void LRN(tree root){
		if(root != NULL){
		LNR(root->l);
		LNR(root->r);
		printf(" %c",root->data); // tham goc
	}
}
// 9. Tim kiem node x
node* search(tree root,char x){
	node* p= new node;
	if(root == NULL)	return NULL;
	if(root->data == x)
		return root;
	p=search(root->l,x);
	if(p==NULL)
		p=search(root->r,x);
	return p;
}
// 10. Cay nhi phan tim kiem

// 11.Xoa cay
void xoaCay(tree &root){
	if(root != NULL){
		xoaCay(root->l);
		xoaCay(root->r);
		delete root;
	}
}
// 
void searchThe(tree &p, tree &q){
	if(q->l != NULL){
		searchThe(p,q->l);
	}
	else{
		p=q;
		p->data = q->data;
//		p=q;
		q=q->r;
	}
}
// 12. Xoa node trong cây
int delnode(tree &root,int x){
	if(root == NULL)
		return 0;
	if(root->data > x)  // tim va xoa ben trai
		return delnode(root->l,x);
	if(root->data < x)
		return delnode(root->r,x);
// Neu root->data == x thi
	node* p=root;
	if(root->l == NULL)
		root = root->r;
	else
		if(root->r == NULL)
			root = root->l;
		else 
			searchThe(p,root->r);
	delete p;
	return 1;
}
int main(){
	tree root;
	init(root);
	createTree(root);
	printf("\nDuyet truoc\n");
	NLR(root);
	printf("\n");
	LNR(root);
	printf("\n");
	LRN(root);
	char x;
	int y;
	printf("\nNhap ki tu: ");
	scanf("%c",&x);
	if(search(root,x)==NULL)
		printf("\nKo");
	else
		printf("\nThay");
	printf("\nMoi nhap y de xoa: ");	scanf("%d",&y);
	delnode(root,y);	
	NLR(root);
	return 0;
}
