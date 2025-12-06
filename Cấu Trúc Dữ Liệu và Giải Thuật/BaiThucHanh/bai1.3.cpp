#include<stdio.h>

typedef struct phanso
{
	int tu;
	int mau;
} ps;

// a
void nhapsoluong(int &n){
	printf("Moi nhap so luong phan so: "); 	scanf("%d",&n);
}
void nhap(ps &x)
{
	printf("\nNhap tu so: ");	scanf("%d",&x.tu);
	do
	{
		printf("Nhap mau so: ");	scanf("%d",&x.mau);
		if(x.mau == 0)	printf("Nhap sai mau so! Yeu cau nhap lai.\n");
	}
	while(x.mau==0);
}
void nhapds(ps a[],int n){
	for(int i=0;i<n;i++)
	{
		printf("Nhap phan so thu %d: ",i+1);
		nhap(a[i]);
	}
}

// b
void xuat(ps x)
{
	printf("%d/%d\t",x.tu,x.mau);
}
void xuatds(ps a[],int n)
{
	for(int i=0;i<n;i++)
	{
		xuat(a[i]);
	}
}

// c
int ucln(int x,int y)
{
	while(x != y)
	{
		if(x>y)	x=x-y;
		else	y=y-x;
	}
	return x;
}
void pstg(ps a[],int n)
{
	int rutgon;
	for(int i=0;i<n;i++)
	{
		rutgon=ucln(a[i].tu,a[i].mau);
		a[i].tu/=rutgon;
		a[i].mau/=rutgon;
	}
}

// ps tong (ps a,ps b).... Hay hon
// d
ps tong(ps a[],int x,int y){
	ps b;
	b.tu = a[x].tu*a[y].mau + a[x].mau*a[y].tu;
	b.mau = a[x].mau*a[y].mau;
	return b;
}
ps hieu(ps a[],int x,int y){
	ps b;
	b.tu = a[x].tu*a[y].mau - a[x].mau*a[y].tu;
	b.mau = a[x].mau*a[y].mau;
	return b;
}
ps tich(ps a[],int x,int y){
	ps b;
	b.tu = a[x].tu*a[y].tu;
	b.mau = a[x].mau*a[y].mau;
	return b;
}
ps thuong(ps a[],int x,int y){
	ps b;
	b.tu = a[x].tu*a[y].mau;
	b.mau = a[x].mau*a[y].tu;
	return b;
}

// e
int sosanh(ps a[],int x,int y){
	if((float)a[x].tu/a[x].mau > (float)a[y].tu/a[y].mau)
		return 1;
	else{
		if((float)a[x].tu/a[x].mau == (float)a[y].tu/a[y].mau)
			return 0;
		else
			return -1;
	}
}
// f
ps tongps(ps a[],int n)
{
	ps sum=a[0];
	for(int i=1;i<n;i++)
	{
		sum.tu  = sum.tu*a[i].mau + sum.mau*a[i].tu;
		sum.mau = sum.mau*a[i].mau;
	} 
	return sum;
}

// g
ps max(ps a[],int n)
{
	if( n == 1 ) return a[0];
	ps Max=a[0];
	for(int i=1;i<n;i++)
	{
		if((float)Max.tu/Max.mau < (float)a[i].tu/a[i].mau)
			Max=a[i];
	}
	return Max;
}

// h
int demmax(ps a[],int n){
	int dem=0;	
	ps temp=max(a,n);
	for(int i=0;i<n;i++)
	{
		if((float)temp.tu/temp.mau == (float)a[i].tu/a[i].mau)
		{
			printf("\n %d\t",i);
			dem++;
		}
	}
	return dem;
}

// i
void sapxep(ps a[],int n){
   ps temp;
   for(int i=0; i<n-1; i++ )
   {
      for( int j=i+1;j<n;j++)
		{
			if( (float)a[i].tu/a[i].mau > (float)a[j].tu/a[j].mau )
	      {
	         temp = a[i];
	         a[i] = a[j];
	         a[j] = temp;
	      }
		}
	}
}
int main()
{
	int n,x,y;
	ps a[n];
	nhapsoluong(n);
	nhapds(a,n);
	
	printf("\n\tDanh sach phan so\n");
	xuatds(a,n);
	
	printf("\nPhan so da duoc rut gon toi gian\n");
	pstg(a,n);
	xuatds(a,n);
	
	sapxep(a,n);
	printf("\nPhan so duoc sap xep tang dan\n"); xuatds(a,n);
	
	do{
		printf("\nMoi chon vi tri cua 2 phan so muon tinh cong, tru, nhan, chia va so sanh: ");
		scanf("%d %d",&x,&y);
	} while(x < 0 && y < 0 || x >=n && y >= n);
	ps t=tong(a,x,y),h=hieu(a,x,y),nn=tich(a,x,y),cc=thuong(a,x,y);
	printf("\n Tong cua 2 phan so la: %d/%d",tong(a,x,y).tu,tong(a,x,y).mau);
	printf("\n Hieu cua 2 phan so la: %d/%d",h.tu,h.mau);
	printf("\n Tich cua 2 phan so la: %d/%d",nn.tu,nn.mau);
	printf("\n Thuong cua 2 phan so la: %d/%d\n",cc.tu,cc.mau);

	if(sosanh(a,x,y) == 1)
		printf("\n Phan so %d/%d > %d/%d\n",a[x].tu,a[x].mau,a[y].tu,a[y].mau);
	else{
		if(sosanh(a,x,y) == 0)
			printf("\n Phan so %d/%d = %d/%d\n",a[x].tu,a[x].mau,a[y].tu,a[y].mau);
		else
			printf("\n Phan so %d/%d < %d/%d\n",a[x].tu,a[x].mau,a[y].tu,a[y].mau);	
	}

	ps tt = tongps(a,n);
//	printf("\n"); xuatds(a,n);
	printf("\nTong cac phan so trong day la: %f",(float)tt.tu/tt.mau);   // ???
//	printf("\n"); xuatds(a,n);
 
	ps m=max(a,n);
	printf("\nSo lon nhat trong day phan so la:%d/%d",m.tu,m.mau);
	
	printf("\nSo lon nhat co %d so\n",demmax(a,n));

	return 0;
}
