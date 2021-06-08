#include<fstream>
#include<iostream>
using namespace std;

int main()
{
	int N;
	cout<<"Inserisci la dimensione della rete: ";
	cin>>N;
	int a,i,j;
	ofstream fout("Condizioni.m");
	fout<<"syms ";
	for( i=1;i<=N;i++)
		fout<<"S"<<i<<" I"<<i<<" ";
	for( i=1;i<=N;i++)
		for( j=1;j<=N; j++)
			if(i!=j)
				fout<<"S"<<i<<"I"<<j<<" ";
	for( i=1;i<=N;i++)
		for(int j=i+1;j<=N;j++)	
			fout<<"S"<<i<<"S"<<j<<" ";
	fout<<"real;\n";
	
	fout<<"S=[";
	for(i=1;i<=N;i++)
		if(i!=N)		fout<<"S"<<i<<";";
		else			fout<<"S"<<i<<"];\n";
	
	fout<<"I=[";
	for(i=1;i<=N;i++)
		if(i!=N)		fout<<"I"<<i<<";";
		else			fout<<"I"<<i<<"];\n";	
		
	fout<<"coppie=[\n";
	for(i=1;i<=N;i++){
 		for(j=1;j<=N;j++){
			if(i==j)
				fout<<"0 ";
			else
				fout<<"S"<<i<<"I"<<j<<" ";
				}
		fout<<"\n";
		}
	fout<<"];\n";
	
	fout<<"SS=[\n";
	for(i=1;i<=N;i++){
		for(j=1;j<=N;j++){
			if (i==j)fout<<"0 ";
			if (i<j) fout<<"S"<<i<<"S"<<j<<" ";
			if (i>j) fout<<"S"<<j<<"S"<<i<<" ";
		}
		fout<<"\n";
		}
	fout<<"];\n";
	}
