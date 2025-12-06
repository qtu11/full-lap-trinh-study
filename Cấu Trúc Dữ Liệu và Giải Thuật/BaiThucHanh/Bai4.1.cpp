#include<stdio.h>
#include<stdlib.h>
#include<conio.h>
#include<string.h>

struct node{
	int data;
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
tree createNode(int x){
	tree q = new node;
	q->data = x;
	q->l = NULL;
	q->r = NULL;
	return q;
}
void insert(tree &root,int x){
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
// Nhap mang
void input(int a[],int &n,tree &root){
	printf("\nNhap so phan tu can them vao cay nhi phan: ");		scanf("%d",&n);
	for(int i=0;i<n;i++){
		printf("\nMoi nhap phan tu thu %d: ",i+1);
		scanf("%d",&a[i]);
		insert(root,a[i]);
	}
}
// 8. DUYET CAY
// duyet truoc
void NLR(tree root){ // duyet theo thu tu Goc-Trai-Phai
	if(root != NULL){
		printf("-> %d",root->data); // tham goc
		NLR(root->l); // tham trai
		NLR(root->r); // tham phai
	}
}
// duyet giua
void LNR(tree root){  // duyet theo thu tu Trai-Goc-Phai
	if(root != NULL){
		LNR(root->l);
		printf("-> %d",root->data); // tham goc
		LNR(root->r);
	}
}
// duyet sau Trai-Phai-Giua
void LRN(tree root){
		if(root != NULL){
		LNR(root->l);
		LNR(root->r);
		printf("-> %d",root->data); // tham goc
	}
}
// 9. Tim kiem node x
node* search(tree root,int x){
	node* p= new node;
	if(root == NULL)	return NULL;
	if(root->data == x)
		return root;
	p=search(root->l,x);
	if(p==NULL)
		p=search(root->r,x);
	return p;
}
// 11.Xoa cay
void deleteTree(tree &root){
	if(root != NULL){
		deleteTree(root->l);
		deleteTree(root->r);
		delete root;
	}
}
void searchTheNode(tree &p, tree &q){
	if(q->l != NULL){
		searchTheNode(p,q->l);
	}
	else{
		p->data = q->data;
		p=q;
		q=q->r;
	}
}
// 11.5 Tinh chieu sau cua cay
int deepTree(tree root){
	if( !root ) 	return 0;
	int a =deepTree(root->l);
	int b =deepTree(root->r);
	if(a > b)
		return a+1;
		return b+1;
}
// 12. Xoa node trong cây
int delnode(tree &root,int x){
	if(root == NULL)
		return 0;
	if(root->data > x)  // tim va xoa ben trai
		return delnode(root->l,x);
	if(root->data < x)  // tim va xoa ben phai
		return delnode(root->r,x);
// Neu root->data == x thi
	node* p=root;
	if(root->l == NULL)
		root = root->r;
	else
		if(root->r == NULL)
			root = root->l;
		else 
			searchTheNode(p,root->r);
	delete p;
	return 1;
}
int main(){
	int n,a[100],kt=0,x;
	char k;
	tree root;
	while(1){
		printf("\n\t\t*** CAY NHI PHAN TIM KIEM ***\n");
		printf("\n\t1. Xay dung cay");
		printf("\n\t2. Them phan tu vao cay nhi phan tu 1 mang");
		printf("\n\t3. Duyet cay nhi phan");
		printf("\n\t4. Tim gia tri cua 1 nut trong cay tim kiem");
		printf("\n\t5. Dem muc (do sau) cua 1 cay");
		printf("\n\t6. Xoa 1 nut trong cay");
		printf("\n\t0. Thoat chuong trinh");
		do{
			printf("\nMoi chon chuc nang: ");	
			k=getche();
		}while(k != '1' && k != '0' && k != '2' && k != '3' && k != '4' && k != '5' && k != '6');
		k=k-48;
		switch( k ){
			case 1:
				init(root);
				kt=1;
				printf("\nCay da duoc xay dung\n");
				break;
			case 2:
				input(a,n,root);
				printf("\nDa them cac phan tu cua mang vao cay nhi phan\n");
				kt=2;
				break;
			case 3:
				if(kt==0 || kt==1)
					printf("\nCay chua duoc xay dung hoac ban chua nhap du lieu vao cay\n");
				else{
					int s=0;
					printf("\n\t1. Duyet Truoc\n");
					printf("\t2. Duyet Giua");
					printf("\n\t3. Duyet Sau\n");
					printf("Moi chon: "); scanf("%d",&s);
					if(s==1){
						printf("\nDuyet Truoc\n");
						NLR(root);}
					if(s==2){
						printf("\nDuyet Giua\n");
						LNR(root);}
					if(s==3){
						printf("\nDuyet Sau\n");
						LRN(root);}
				}
				break;
			case 4:
				if(kt==0 || kt==1)
					printf("\nCay chua duoc xay dung hoac ban chua nhap du lieu vao cay\n");
				else{
					printf("\nNhap gia tri can tim: ");
					scanf("%d",&x);
					if(search(root,x) !=NULL)
						printf("Tim thay gia tri %d trong BST \n",x);
					else
						printf("Khong tim thay gia tri %d trong BST \n",x);	
				}
				break;
			case 5:
				if(kt==0 || kt==1)
					printf("\nCay chua duoc xay dung hoac ban chua nhap du lieu vao cay\n");
				else{
					printf("\nDo sau cua cay nhi phan la: %d",deepTree(root));
				}
				break;
			case 6:
				if(kt==0 || kt==1)
					printf("\nCay chua duoc xay dung hoac ban chua nhap du lieu vao cay\n");
				else{
					printf("\nNhap gia tri can xoa: ");
					scanf("%d",&x);
					delnode(root,x);
					printf("Da thuc hien xoa nut gia tri %d\n",x);
				}
				break;
			case 0:
				printf("\nBan da thoat chuong trinh");
				return 0;
		}
	}
	return 0;
}
