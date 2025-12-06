#include<stdio.h>
#include<stdlib.h>
void nhapN(int &n){
	printf("Nhap so phan tu: ");	scanf("%d",&n);
}
 void nhap(int *a,int n){
 	for(int i=0;i<n;i++){
 		printf("\nNhap phan tu thu %d: ",i+1);
 		scanf("%d",(a+i));
	 }
 }
 void xuat(int *a,int n){
 	for(int i=0;i<n;i++){
 		printf("%4d",*(a+i));
	 }
 }
 int tong(int *a,int n){
 	int s=0;
 	for(int i=0;i<n;i++){
 	s+=*(a+i);	
	 }
	return s;
 }
 float tbc(int *a,int n){
 	return (float)tong(a,n)/n;
 }
 void sort(int *x,int *y)
{
	int temp = *x;
	*x = *y;
	*y = temp;
}

void sapxep(int *a,int n)
{
	for(int i=0;i<n-1;i++)
		for(int j=i+1;j<n;j++)
			if(*(a+i) > *(a+j))
				sort(&a[i],&a[j]);
}
int timX(int *a,int n,int x){
	for(int i=0;i<n;i++){
		if(*(a+i) == x)
			return i;
	}
	return -1;
}
 int main(){
 	int *a,n;
 	int b,dung=0;
 	while(1)
 	{
 		printf("\n\t\t*** MENU ***\n");
 		printf("\t1. NHAP SO PHAN TU\n");
 		printf("\t2. NHAP MANG\n");
 		printf("\t3. TINH TONG\n");
 		printf("\t4. TINH TRUNG BINH CONG\n");
 		printf("\t5. SAP XEP MANG TANG DAN\n");
 		printf("\t6. TIM GIA TRI X\n");
 		printf("\t0. THOAT CHUONG TRINH\n");
 		do{
 			printf("\nMoi chon chuc nang: ");
 			scanf("%d",&b);
		 }while(b != 1 && b != 2 && b != 3 && b != 4 && b!=5 && b!= 6 && b!=0);
		switch(b){
			case 1:
				nhapN(n);
 				a = (int*)malloc(n*sizeof(int)) ;
 				dung=1;
 				break;
 			case 2:
 				if(dung == 0){
 					printf("Chua nhap du lieu\n");
 					break;
				 }
 				nhap(a,n);
 				dung=2;
 				break;
 			case 3:
 				if(dung !=2){
 					printf("Chua nhap du lieu\n");
 					break;
				 }
				printf("\nTong: %d ",tong(a,n));
				break;
			case 4:
				if(dung !=2){
 					printf("Chua nhap du lieu\n");
 					break;
				 }
				printf("\nTrung binh cong: %.2f",	tbc(a,n));
				break;
			case 5:
				if(dung !=2){
 					printf("Chua nhap du lieu\n");
 					break;
				 }
				 	printf("\nMang da duoc sap xep\n");
 					sapxep(a,n);
 					xuat(a,n);
 					break;
 			case 6:
 				if(dung !=2){
 					printf("Chua nhap du lieu\n");
 					break;
				 }
				int x; 
				printf("\nMoi nhap gia tri can tim: "); 	scanf("%d",&x);
			 	if(timX(a,n,x) != -1)
			 		printf("\nVi tri x la: %d",timX(a,n,x));
			 	else
			 		printf("\nKhong tim thay gia tri");
			 		break;
			case 0:
				printf("\nBan da thoat chuong trinh !");
				return 0;
		}
	 }
// 	nhapN(n);
// 	a = (int*)malloc(n*sizeof(int)) ;
// 	nhap(a,n);
// 	printf("\nTong: %d va Trung binh cong: %.2f",tong(a,n),	tbc(a,n));
// 	printf("\nMang da duoc sap xep\n");
// 	sapxep(a,n);
// 	xuat(a,n);
// 	printf("\nMoi ban nhap gia tri tim kiem: ");
//	int x; scanf("%d",&x);
// 	if(timX(a,n,x) != -1)
// 		printf("\nVi tri x la: %d",timX(a,n,x));
// 	else
// 		printf("\nKhong tim thay gia tri");
 }
