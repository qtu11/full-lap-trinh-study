#include<stdio.h>

typedef struct SinhVien
{
    char masv[10];
    char hoten[40];
    float dtb;
}sv;

struct Node
{
    sv data;
    Node* next;
};

void nhap1sv(sv &x )
{
    fflush(stdin);
    printf("\nMa Sinh Vien: ");
    gets(x.masv);
    printf("\nHo va ten: ");
    gets(x.hoten);
    printf("\nDiem trung binh: ");
    scanf("%f",&x.dtb);
}

void xuat1sv(sv x)
{
    printf("\nMa SV: ",x.masv);
    printf("\nHo va ten: ",x.hoten);
    printf("\nDiem trung binh: ",x.dtb);
}

void init(Node* &phead)
{
    phead==NULL;
}

int isempty(Node* phead)
{
    return phead==NULL;
}

Node* createnode(sv x)
{
    Node* p= new Node;
    p->data = x;
    p->next=NULL;
    return p;
}

void insertfirst(Node* &phead,sv x)
{
    Node* p = createnode(x);
    if(phead == NULL)
        phead=p;
    else 
    {
        p->next=phead;
        phead=p;
    }
}

void inputlist(Node* &phead,int n)
{
    printf("\nNhap so luong sinh vien: ");
    scanf("%d",&n);
    for(int i=0;i<n;i++)
    {
        sv x;
        printf("Nhap thong tin sv can them: ");
        nhap1sv(x);
        insertfirst(phead,x);
    }
}

void outputlist(Node* phead)
{
	Node* p=phead;
	if(p==NULL)
		printf("Danh sach dang rong!");
	else
	{
		printf("\n---------------");
		while(p!=NULL)
		{
			xuat1sv(p->data);
			p=p->next;
		}
	}
    
}

int main()
{
    Node* phead;
    sv x;
    int n;
    inputlist(phead,n);
    outputlist(phead);
    return 0;
}
