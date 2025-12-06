#include<stdio.h>
#include<stdlib.h>
#include<conio.h>
#include<string.h>

struct node{
	int data;
	int bf; // Chi so can bang
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

tree rotateleft(tree root){
	tree p;
	p=root;
	if(root==NULL)	printf("\nCay rong");
	else{
		if(root->r==NULL)	printf("\nKhong xoay trai duoc vi node con ben phai khong co");
		else{
			p=root->r;
			root->r=p->l;
			p->l=root;
		}
	}
	return p;
}
tree rotateright(tree root){
	tree p;
	p=root;
	if(root==NULL)	printf("\nCay rong");
	else{
		if(root->l==NULL)	printf("\nKhong xoay phai duoc vi node con ben trai khong co");
		else{
			p=root->l;
			root->l=p->r;
			p->r=root;
		}
	}
	return p;
}
void insert(tree *pavltree,int x){
	tree fp,p,q,fya,ya,s;
	int dolech;
	fp=fya=NULL;
	p=*pavltree;
	ya=p;
	while(p !=NULL){
		if(x==p->data)		return;
		if(x<p->data )		q=p->l;
		if(x>p->data )		q=p->r;
		if(q->bf != 0){
			fya=p;	ya=q;
		}
		fp=p;	p=q;
	}
	q=createNode(x);
	if(x<fp->data)			fp->l=q;
	else	p=ya->r;
	s=p;
	while(p != p){
		if(x<p->data){
			p->bf=1;	p=p->l;
		}else{
			p->bf=-1;	p=p->r;	
		}
	}
	// Tim huong lenh
	if(x<ya->data)	dolech=1;
	else			dolech=-1;
	if(ya->bf==0){
		ya->bf=dolech;
		return;
	}
	if(ya->bf != dolech){
		ya->bf=0;	return;
	}
	if(s->bf==dolech){
		if(dolech==1)	p=rotateright(ya);
		else			p=rotateleft(ya);
		ya->bf=0;
		s->bf=0;
	}else{
		if(dolech==1){
			ya->l=rotateleft(s);
			p=rotateright(ya);
		}else{
			ya->r=rotateright(s);
			p=rotateleft(ya);
		}
		if(p->bf==0){
			ya->bf=0;
			s->bf=0;
		}else{
			if(p->bf==dolech){
				ya->bf=-dolech;
				s->bf=0;
			}else{
				ya->bf=0;
				s->bf=dolech;
			}
			p->bf=0;
		}
	}
	if(fya==NULL)		*pavltree=p;
	else
		if(ya==fya->r)	fya->r=p;
		else			fya->l=p;
}

void insertMatrixforTree(int a[],int &n,tree &root,tree *pavltree){
	printf("\nNhap so phan tu cua mang: ");		scanf("%d",&n);
	for(int i=0;i<n;i++){
		printf("\nMoi nhap phan tu thu %d: ",i+1);
		scanf("%d",&a[i]);
		insert(pavltree,a[i]);
	}
}

int main(){
	int n,a[100],kt=0,x;
	char k;
	tree root,*pavltree;
	while(1){
		printf("\n\t\t*** CAY NHI PHAN TIM KIEM ***\n");
		printf("\n\t1. Xay dung cay");
		printf("\n\t2. Them phan tu vao cay nhi phan can bang tu 1 mang");
		printf("\n\t3. Kiem tra cay nhi phan tim kiem co can bang hay khong ?");
		printf("\n\t0. Thoat chuong trinh");
		do{
			printf("\nMoi chon chuc nang: ");	
			k=getche();
		}while(k != '1' && k != '0' && k != '2' && k != '3' );
		k=k-48;
		switch( k ){
			case 1:
				init(root);
				kt=1;
				printf("\nCay da duoc xay dung\n");
				break;
			case 2:
				insertMatrixforTree(a,n,root,pavltree);
				printf("\nDa them cac phan tu cua mang vao cay nhi phan\n");
				kt=2;
				break;
			case 3:
				if(kt==0 || kt==1)
					printf("\nCay chua duoc xay dung hoac ban chua nhap du lieu vao cay\n");
				else{
					
				}
				break;
			case 0:
				printf("\nBan da thoat chuong trinh");
				return 0;
		}
	}
	return 0;
}
