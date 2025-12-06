#include<stdio.h>

int giaithua(int n){
    if(n==1)
        return 1;
    return(n*giaithua(n-1));
}
int main(){
	int n;
	printf("Nhap n giai thua: ");		scanf("%d",&n);
	printf("\n%d giai thua la: %d",n,giaithua(n));
}
