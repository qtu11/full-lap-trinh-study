#include<stdio.h>

typedef struct PHANSO{
	int tu;
	int mau;
	struct PHANSO* next;
}ps;
ps* p;

void nhap(ps* &p,int n){
	
	for(int i=0;i<n;i++){
		printf("\nNhap gia tri phan so thu %d",i+1);
		printf("\nNhap tu so: ");		scanf("%d",p ->tu);
			printf("\nNhap mau so: ");
			scanf("%d",p->mau);
		p = p->next;
	}
}
void xuat(ps* p,int n){
	printf("\n Day phan so ");
	for(int i=0;i<n;i++){
		printf("%d/%d\t",p->tu,p->mau);
		p=p->next;
	}
}
int main(){
	int n=5;
	nhap(p,n);
	xuat(p,n);
}
