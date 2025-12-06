//Ho tên:TranDucTai		LuongXuanNhat
//MSSV : 2090606906		2011064280
// Chude3_Cau1

#include<stdio.h>
#include<stdlib.h>
#include<conio.h>
#include<string.h>

struct node{
	int data;
	int deep;
	struct  node* l;
	struct  node* r;
};
typedef struct node* tree;
void init(tree &root){
	root=NULL;
}
int isempty(tree root){
	return (root == NULL);
}
tree createNode(int x,int d){
	tree q = new node;
	q->data = x;
	q->l = NULL;
	q->r = NULL;
	q->deep = d;
	return q;
}
void insert(tree &root,int x,int d){
	if(isempty(root))
		root = createNode(x,d);
	else{
		if(x == root->data) return;
		if(x < root->data)
			insert(root->l,x,root->deep+1); 
		else
			insert(root->r,x,root->deep+1);
		}
}
void input(tree &root){
	int n,a[100];
	do{
		printf("\nNhap so phan tu can them vao cay nhi phan: ");		
		scanf("%d",&n);
	}while(n < 2 && printf("Moi nhap lai mot so > 1"));
	for(int i=0;i<n;i++){
		printf("\nMoi nhap phan tu thu %d: ",i+1);
		scanf("%d",&a[i]);
		insert(root,a[i],0);
	}
}
void LNR(tree root){ 
	if(root != NULL){
		LNR(root->l);
		printf("  %d",root->data); 
		LNR(root->r);
	}
}
void RNL(tree root){ 
	if(root != NULL){
		RNL(root->r);
		printf("  %d",root->data); 
		RNL(root->l);
	}
}
void cleartree(tree &root){
	if(root != NULL){
		cleartree(root->l);
		cleartree(root->r);
		delete root;
	}
}
void searchthenode(tree &p, tree &q){
	if(q->l != NULL){
		searchthenode(p,q->l);
	}
	else{
		p->data = q->data;
		p=q;
		q=q->r;
	}
}
int remove(tree &root,int x){
	if(root == NULL)
		return 0;
	if(root->data > x)  // tim va xoa ben trai
		return remove(root->l,x);
	if(root->data < x)  // tim va xoa ben phai
		return remove(root->r,x);
// Neu root->data == x thi
	node* p=root;
	if(root->l == NULL)
		root = root->r;
	else
		if(root->r == NULL)
			root = root->l;
		else 
			searchthenode(p,root->r);
	delete p;
//	return 1;
}
int strictlytrue(tree root){
	if(root == NULL) return 1;
	else{
		strictlytrue(root->l);
		if(root->l == NULL && root->r != NULL)
			return 0;
		if(root->r == NULL && root->l != NULL)
			return 0;
		strictlytrue(root->r);
	}
}
int deeptree(tree root)
{// Lay muc cua la
	if(root->l == NULL) 
		return root->deep;
	deeptree(root->l);
}
int completetree(tree root,int d){
	if(root == NULL) return 1;
	else{
		if(strictlytrue(root) == 0) return 0;
		else{
			completetree(root->l,d);
			if(root->l == NULL && root->r == NULL && root->deep != d)
				return 0;
			completetree(root->r,d);
		}
	}
}
node* searchfathernode(tree root,int x){
	if(root == NULL)	return NULL;
	else{
		if(root->l != NULL && root->l->data == x )
			return root;
		if(root->r != NULL && root->r->data == x)
			return root;
		if(x < root->data)
			return searchfathernode(root->l,x);
		return searchfathernode(root->r,x);
	}
}
int main(){
	int x;
	tree root,p;
	init(root);
	input(root);
	LNR(root);
	printf("\nXuat gia tri tang dan: ");
	LNR(root);
	printf("\nXuat gia tri giam dan: ");
	RNL(root);
	printf("\nNhap gia tri can xoa: ");
	scanf("%d",&x);
	remove(root,x);
 	LNR(root);
	if(strictlytrue(root) != 0)
		printf("\nDay la cay nhi phan dung >_<");
	else
		printf("\nDay khong phai la cay nhi phan dung -_-");
	if(completetree(root,deeptree(root)) != 0)
		printf("\nDay la cay nhi phan day du >_<");
	else
		printf("\nDay khong phai la cay nhi phan day du -_-");
	printf("\nMoi nhap khoa x: ");		scanf("%d",&x);
	p=searchfathernode(root,x);
	if(p != NULL)
		printf("Tim thay nut cha cua %d la %d",x,p->data);
	else
		printf("Khong tim thay nut cha cua %d",x);	
	cleartree(root);
	return 0;
}



