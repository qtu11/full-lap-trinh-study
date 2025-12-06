#include <stdio.h>
#include <string.h>
#include <stdlib.h>



typedef struct node
{

struct node* next;
int info; 
}Node;
typedef Node* STACK;
STACK S;


void InitStack (STACK &S)
{
S = NULL;
}

//kiem tra rong
int isEmpty (STACK S)
{
return S==NULL;
}
int Push(STACK &S, int &x)
{
Node* p = new Node;
p->info = x;
p->next = S;
S = p;
return 1; 
}
//lay phan tu ra khoi stack
int Pop(STACK &S,int x) //insertfirst
{
  if(!isEmpty (S))
  return 0;
  Node*p =S;
x= p->info;
S=S->next;
delete p;
return 1; 
}









void xuat (STACK S)
{
int x;
while (!isEmpty (S))
{
Pop(S,x);
printf ("%d",x);
 //su dung pop de lay ra các phan tu trng hàm  
}
}





int main()
{
int n;int x;
InitStack(S);
printf ("nhap vao 1 so: ");
scanf ("%d",&n);
chuyendoi(S,n);
xuat(S);

printf ("\%d",7/2);


return 0;
}
