#include<stdio.h>
#include<stdlib.h>
#include<string.h>

typedef struct QuanLiThuVienSach{
	int masach;
	char tensach[40];
	float gia;
} sach;
void nhapsoluong(int &n){
	printf("Moi nhap so luong sach: ");		scanf("%d",&n);
}
void nhap(sach &x){
	printf("\nNhap ma sach: "); 	scanf("%d",&x.masach);
	printf("\nNhap ten sach: ");	fflush(stdin);	gets(x.tensach);
	printf("\nNhap gia sach: ");	scanf("%f",&x.gia);
}
void xuat(sach x){
	printf("\n%d\t\t %s\t\t %.2f",x.masach,x.tensach,x.gia);
}
void nhapds(sach ds[],int n){
	for(int i=0;i<n;i++){
		printf("\nNhap du lieu quyen sach thu %d",i+1);
		nhap(ds[i]);
	}
}
void xuatds(sach ds[],int n){
		for(int i=0;i<n;i++){
			xuat(ds[i]);
		}
}
void timsach(sach ds[],int n,int masach){
	sach s;
	for(int i=0;i<n;i++){
		if(ds[i].masach == masach){
			xuat(ds[i]);
		}
	}
	printf("\nKhong tim thay");
}
void xuatten(sach ds[],int n,char tensach[]){
	for(int i=0;i<n;i++){
		if(stricmp(ds[i].tensach,tensach)==0)
			xuat(ds[i]);
	}
}
void sachdatnhat(sach ds[],int n){
	int s=0,j;
	for(int i=1;i<n;i++){
		if(ds[s].gia < ds[i].gia)
			{
				s=ds[i].gia;
				j=i;
			}
	}
	xuat(ds[j]);
}
int main(){
	int n;
	sach  ds[100];
	nhapsoluong(n);
	nhapds(ds,n);
	xuatds(ds,n);
	int masach;
	printf("\nMoi nhap ma sach: ");		scanf("%d",&masach);
	char tensach[40];
	printf("\nMoi nhap ten sach: ");
	fflush(stdin); gets(tensach);
	xuatten(ds,n,tensach);
	printf("\nSach dat nhat la:");
	sachdatnhat(ds,n);
}
