#include<fstream>
#include<iostream>
using namespace std;
	ofstream fout("Condizioni_Iniziali_Triple.m");
	
void StampaVett(int v[], int N, int inv)
{ for(int i=0;i<N; i++)
	{fout<<(v[i]-inv)*(v[i]-inv);
		if(i<N-1) fout<<";";
	}
}


int main()
{
	int N,i,j;
	char a;
	cout<<"Inserisci la dimensione della rete: ";
	cin>>N;
	cout<<"Per ogni nodo inserire S per infetto o I per sano "<<endl;
	int v[N];
	for ( i=0;i<N;i++)
		{	char_non_valido:
				{
				cout<<"Nodo "<<i+1<<":";
				cin>>a;
				if (a=='S' || a=='s')	v[i]=1;
				else{
					if (a=='I'|| a =='i') v[i]=0;
					else
						goto char_non_valido;
					}
				}
		}
	

 	
 	fout<<"S=[";
 	StampaVett(v,N,0);
 	fout<<"];\nI=[";
 	StampaVett(v,N,1);
  	fout<<"];\nco=[";
	for(i=0;i<N;i++){
		fout<<v[i]<<";";
		if(v[i]==1) fout<<0;
		if (v[i]==0) fout<<1;		
		if (i<N-1) fout<<";";
		}
		
	fout<<"];\ncoppie=[\n";
	for(i=1;i<=N;i++){
 		for(j=1;j<=N;j++){
			if(i==j) fout<<"0 ";
			else fout<<"S("<<i<<")*I("<<j<<") ";
			}
		fout<<"\n";
		}
	fout<<"];\n";
	
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
	
	fout<<"SS=SS(G~=0);"<<endl<<"SS=SS(1:2:end);"<<endl<<"co=[  co;coppie(G~=0); SS ];";
	
}

