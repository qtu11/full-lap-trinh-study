#include<iostream>
#include<stack>

using namespace std;

int main(){
    string s;// khai báo s kieu chuoi
    stack<char> st;// khai bao ngan xep kieu char ten st;
    getline(cin,s);// nhap chuoi
    for(int i=0;i < s.length();i++){
        st.push(s[i]);
    }
    while(!st.empty()){
        cout << st.top();
        st.pop();
    }
    return 0;
}
