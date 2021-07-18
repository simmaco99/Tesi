function f=closeTriple(G,t,y,tau, gamma)
% f=closeTriple(G,t,y,tau, gamma) restituisce la funzione che risolve il modello chiso alle triple
% G matrice di adiacenza del network
% t tempo (serve per usare le funzioni ode)
% y soluzione (sani e infetti alternati 
%			   S_i I_j (ordinate in modo lessicografico di (i,j) 
%			   S_i S_j (ordinate in modo lessicografico di (i,j))
%			  )	% tau tasso di infezione 
% gamma tasso di rimozione
% Attenzione. Le condizioni iniziali vengono generate dal programma Condizioni_Iniziali_triple.cpp
 
 N=size(G,2) ; 
 np= sum(G~=0,'all') ; %numero di coppie ordinate
 f=zeros(2*N +np+np/2,1);
 
 %spezza y nelle varie matrici 
 S =y(1:2:2*N);
 I=y(2:2:2*N);
 coppie = zeros(N,N);
 SS=coppie;
 coppie(G~=0) = y(2*N+1:2*N+np);
 coppie=coppie';
 b=(G~=0)& (G==triu(G)); %1 sovra la diagonale
 SS(b==1)=y(2*N+np+1:end);
 SS= SS+ SS';

B= G.*coppie;
somma = sum(B,2) - B;
Sani = -tau * diag(somma);
Infetti = -Sani - gamma *I ;

%le variabili da s a p mi permettono di calcloare SI e SaSa senza dividere per 0 
s=S* ones(1,N);
st=s';
z=st ;
z( SS==0 | somma' ==0)=1; %tanto inutile
q=s;
q(coppie==0| somma ==0 )=1; %tanto inutile
p=s;
p(SS==0 | somma==0)=1; %tanto inutile

SI = tau * SS./z .* somma' - tau * coppie./q .* somma - (tau + gamma)*coppie;
SaSa= - tau * SS./z .* somma' - tau * SS./p .* somma;
SaSa=SaSa-diag(SaSa);

%sistemiamo l'ordine dell'equazioni
SI=reshape(SI',N.^2,1);
GG= reshape(G', N.^2,1);


f(1:2:2*N) = Sani;
f(2:2:2*N) = Infetti;
f(2*N+1:2*N +np)=SI(GG~=0);
f(2*N+ np+1:end) = SaSa(b==1);
   

end
 
 
