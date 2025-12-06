#include<stdio.h>
#include<math.h>

int nto(int n){
	if(n < 2) 
		return 1;
	if(n == 2 || n==3)
		return 1;
	for(int i=3;i<=sqrt(n);i+=2)
		if(n % i == 0)
			return 1;
	return 0;
}
int main(){
	int n=100,s=0;
	for(int i=2;i<=n;i++){
		if(nto(i))
			s+=i;
	}
	printf("Tong cac so nguyen to tu 1 den n la: %d",s);
}
