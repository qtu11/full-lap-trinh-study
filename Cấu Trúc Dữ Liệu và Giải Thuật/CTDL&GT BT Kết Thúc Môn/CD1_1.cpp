//Ho tên:TranDucTai		LuongXuanNhat
//MSSV : 2090606906		2011064280
// Chude1_Cau1
#include<stdio.h>
#include<string.h>
typedef struct SV{
	char MSSV[11]; 
	char Hoten[41];
	float diemtb;
}SinhVien;
typedef struct node{
	SinhVien info;
	struct node *next;
}Node;
typedef Node* pHead;
int Isempty(pHead p)
{
	return (p == NULL);
}
void Initlist(pHead &p)
{
	p = NULL;
}
void Nhap1sv (SinhVien &sv)
{
	fflush(stdin);
	printf("\nNhap ma so sinh vien:");
	gets(sv.MSSV);
	fflush(stdin);
	printf("Nhap ho ten: ");
	gets(sv.Hoten);
	printf("Nhap diem trung binh: ");
	scanf("%f",&sv.diemtb);
}	
void xuat1sv(SinhVien sv)
{
	printf("\n  %-17s %-30s %.2f",sv.MSSV,sv.Hoten,sv.diemtb);
}
Node* CreateNode (SinhVien sv)
{
	Node* newNode = new Node;
	newNode->info = sv;
	newNode->next = NULL;
	return newNode;	
}
void InsertFirst (pHead &p,SinhVien sv)
{
	Node* newNode = CreateNode(sv);
	if(Isempty(p))	p= newNode;
	else{
		newNode->next= p;
		p=newNode;
	}
}
void input(int &n,pHead &p,SinhVien sv) 
{
	int i;
	printf("\nNhap so luong sinh vien: ");
	scanf("%d",&n);
	for (i=0;i<n;i++)
	{
		printf("\nNhap thong tin sinh vien thu %d: ",i+1);
		Nhap1sv(sv);
		InsertFirst(p,sv);
	}
}
void xuatsv(pHead p)
{
	Node* q = p;
	printf("\n\t\t *** DANH SACH SINH VIEN ***\n");
	printf("%-20s %-30s %-10s","Ma so sinh vien","Ho va ten","Diem trung binh");
	while (q != NULL)
	{
		xuat1sv(q->info);
		q=q->next;
	}
}
void xuatDTBhon5(pHead p){
	Node* q=p;
	printf("\n\nNhung sinh vien co diem trung binh > 5:");
	while(q != NULL){
		if(q->info.diemtb > 5.0)	
			xuat1sv(q->info);
		q=q->next;
	}
}
void Timsv(pHead p)
{
	char tensv[40];
	printf("\n\nNhap ten sinh vien can tim: ");
	fflush(stdin);
	gets(tensv);
	Node* q= p;	
	while(q != NULL){
		if(strcmp (q->info.Hoten , tensv)== 0)	
			xuat1sv(q->info);
		q=q->next;
	}
}
int main()
{
	Node* p;
	Initlist(p);
	int i,n;
	SinhVien sv;
	input (n,p,sv);
	xuatsv(p);
	xuatDTBhon5(p);
	Timsv(p);
	return 0;
}


