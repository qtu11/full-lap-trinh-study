#include<iostream>
#include<string>
#include<stack>

using namespace std;

int main(){
	string s;
	stack<char> st;
	cout<< "Moi nhap bieu thuc: " ;
	getline(cin,s);
	for(int i=0;i<s.length();i++){
		if(s[i] == ')' && st.empty() )	return 1;
		else{
			if(s[i] == '(' )
				st.push(s[i]);
			if(s[i] == ')' && st.top() == '(' )
				st.pop();
		}
	}
	if(st.empty())	cout << "Bieu thuc dung";
	else	cout << "Bieu thuc sai";
	return 0;
}
