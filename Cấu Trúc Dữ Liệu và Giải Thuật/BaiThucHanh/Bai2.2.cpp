#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct SV{
	char masv[11];
	char hoten[41];
	float dtb;
};
struct Node
{
	SV value;
	struct Node* pnext; 
};
struct List{
	Node *phead;
};

// 	a
void init(List 	&l)
{
	l.phead = NULL;
};
int isEmpty(List l)
{
	return (l.phead == NULL);
}
Node* createNode(SV x)
{
	Node* p = new Node;
	p->value = x;
	p->pnext = NULL ;
	return p;
}
void insertfirst(List &l, SV x)
{
	Node *p = createNode(x);
	if(isEmpty(l)) l.phead= p;
	else 
	{
		p->pnext = l.phead;
		l.phead = p;
	}
}
// nhap sinh vien
void nhap1sv(SV &x)
{
	printf("Nhap ma so SV: ");
	scanf("%s",&x.masv);
	printf("Nhap ho va ten: ");
	fflush(stdin);	gets(x.hoten);
	printf("Nhap diem trung binh: ");
	scanf("%f",&x.dtb);
}
void input(List &l)
{
	SV x;
	int n;
	init(l);
	printf("Nhap so luong sinh vien :");
	scanf("%d",&n);
	for(int i= 0; i < n;i++)
	{
		printf("\nNhap thong tin sinh vien can them thu %d:\n",i+1);
		nhap1sv(x);
		insertfirst(l,x);  
	}
}

// b
void xuat1sv(SV x)
{
	printf("Ma so SV\t: %s \n",x.masv);
	printf("Ho va Ten\t:%s \n",x.hoten);
	printf("Diem TB\t\t: %.2f \n",x.dtb);
}
void showlist(List l)
{
	printf("--------DANH SACH SINH VIEN----------\n");
	Node *p;
    p = l.phead;
    while(p!=NULL)
    {
        xuat1sv(p->value);
        printf("\n\n");
        p=p->pnext;
    }
}

// c
// tim sinh vien co diem trung binh > 5
void findscore(List l)
{
    Node *p;
    p = l.phead;
    while (p != NULL)
    {       
        if(p->value.dtb > 5)  
        xuat1sv(p->value);
        printf("\n");
        p=p->pnext;
    }
}
Node* findcode(List l,char ma[])
{
	Node *p;
	p = l.phead;
	while(p!=NULL)
	{
		if(strcmp(ma,p->value.masv) == 0)
		{
			xuat1sv(p->value);
			printf("\n");
		}
		p = p -> pnext;
	}
}
int main()
{
	SV x;
	List l;
	input(l);
	printf("Danh sach\n");
	showlist(l);
	printf("Sinh vien co DTB > 5 la:\n");
	findscore(l);
	char ma[11];
	printf("\nNhap ma sinh vien muon tim :");
	scanf("%s",&ma);
	printf("Sinh vien co ma %s la :\n",ma);
	findcode(l,ma);
}
