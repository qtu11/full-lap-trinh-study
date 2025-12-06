#include<stdio.h>
#include<stdlib.h>
struct node{
	int data;
	struct  node* l;
	struct  node* r;
};
typedef struct node* B;
void init(B &root){
	root=NULL;
}
int isempty(B root){
	return (root == NULL);
}
B createNode(int x){
	B q = new node;
	q->data = x;
	q->l = NULL;
	q->r = NULL;
	return q;
}
void nhapmang(int A[],int &n){
	printf("\nNhap so phan tu cua mang: ");
	scanf("%d",&n);
	for(int i=0;i<n;i++){
		printf("\nMoi nhap phan tu thu %d: ",i+1);
		scanf("%d",&A[i]);
	}
}
void insert(B &root,int x){
	if(isempty(root))
		root = createNode(x);
	else{
		if(x == root->data) return;
		else{
			if(x < root->data)
				insert(root->l,x); // chen trai
			else
				insert(root->r,x); // chen phai
		}
	}
}
// Nhap mang vao cay
void nhapcay(int A[],int n,B &root){
	for(int i=0;i<n;i++){
		insert(root,A[i]);
	}
}
// duyet truoc
void NLR(B root){ 
	if(root != NULL){
		printf("-> %d",root->data); 
		NLR(root->l); 
		NLR(root->r); 
	}
}
// duyet giua
void LNR(B root){  
	if(root != NULL){
		LNR(root->l);
		printf("-> %d",root->data); 
		LNR(root->r);
	}
}
// duyet sau Trai-Phai-Giua
void LRN(B root){
		if(root != NULL){
		LNR(root->l);
		LNR(root->r);
		printf("-> %d",root->data); 
	}
}
int timmang(int A[],int n,int c){
	int dem=0;
	for(int i=0;i<n;i++){
		dem++;
		if(A[i] == c)
		{
			printf("\nTim thay gia tri %d trong mang",c);
			return dem;
		}
	}
	return dem;
}
int timcay(B root,int c){
	int dem=0;
	B p = root;
	while(p!=NULL){
		dem++;
		if(p->data==c)
		{
			printf("\nTim thay gia tri %d trong mang",c);
			return dem;	
		}
		if(p->l != NULL)
			p=p->l;
		else
			p=p->r;
	}
	return dem;
}
int main(){
	int A[100];
	int n,c;
	B root;
	init(root);
// a
	nhapmang(A,n);
// b
	nhapcay(A,n,root);
	printf("\nDa thuc hien nhap mang vao cay nhi phan");
// c
	printf("\nDuyet cay truoc: ");
	NLR(root);
	printf("\nDuyet cay giua: ");
	LNR(root);
	printf("\nDuyet cay sau: ");
	LRN(root);
// c,d
	printf("\nMoi nhap so can tim: ");	scanf("%d",&c);
	timmang(A,n,c);
	timcay(root,c);
// e
	printf("\nSo lan tim kiem cua mang la: %d\nSo lan tim kiem cua cay la: %d",timmang(A,n,c),timcay(root,c));
	return 0;
}
