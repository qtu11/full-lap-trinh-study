#include<stdio.h>

struct node{
	int info;
	struct node* next;
};
struct queue{
	node* phead; // Tro dau danh sach - Remove dien ra o phead
	node* ptail; // tro cuoi danh sach - Insert dien ra o ptal
};
// Khoi tao
void init(queue &q){
	q.phead = NULL;
	q.ptail = NULL;
}
// Kiem tra rong
int isempty(queue q){
	return (q.phead == NULL);
}
// Tao node
node* createNode(int x){
	node* p = new node;
	p->info = x;
	p->next = NULL;
	return p;
}
// Insert
void insert(queue &q,int x){
	node* p=createNode(x);
	if(isempty(q))
		q.phead = q.ptail = p;
	else{
		q.ptail->next=p;
		q.ptail = p;
	}
}
// Remove
int remove(queue &q,int &x){
	if(isempty(q))
		return 0;
	else{
		if(q.phead == q.ptail)
			init(q);
		else{
			node*p = q.phead;
			x=q.phead->info;
			q.phead=q.phead->next;
			delete p;
			return 1; }
	}
}

int main(){
	int n,x;
	queue q;
	node p;
	insert(q,5);
	insert(q,6);
	insert(q,4);

	
}
