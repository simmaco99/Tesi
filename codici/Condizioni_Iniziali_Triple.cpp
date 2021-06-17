#include<fstream>
#include<iostream>
using namespace std;
	ofstream fout("Condizioni_Iniziali_Triple.m");

int main()
{
	int N,i,j;
	char a;
	cout<<"Inserisci la dimensione della rete: ";
	cin>>N;
    fout<<"S=0.5*ones("<<N<<",1);"<<endl;
     fout<<"I=0.5*ones("<<N<<",1);"<<endl;
		
    fout<<"coppie=[\n";
	for(i=1;i<=N;i++){
 		for(j=1;j<=N;j++){
			if(i==j) fout<<"0 ";
			else fout<<"S("<<i<<")*I("<<j<<") ";
			}
		fout<<"\n";
		}
	fout<<"]';\n";
	
	fout<<"SS=[\n";
	for(i=1;i<=N;i++){
		for(j=1;j<=N;j++){
			if (i==j)fout<<"0 ";
			if (i<j) fout<<"S("<<i<<")*S("<<j<<") ";
			if (i>j) fout<<"S("<<j<<")*S("<<i<<") ";
		}
		fout<<"\n";
		}
	fout<<"];\n";
    fout<<"SS=SS(G~=0);"<<endl<<"SS=SS(1:2:end);"<<endl<<"co=[  S ; I;coppie(G~=0); SS ];";
	
}

