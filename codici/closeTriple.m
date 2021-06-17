function f=closeTriple(G,t,y,tau, gamma)
% Data la matrice di Adiacenza delle rete crea la funzione che serve per
% risolvere l'ode chiuso alle triple
% per le condizioni inziali si puo usare la funzione scritta in c++
% Condizioni_Iniziali_triple.cpp

N=size(G,2) ; 
np= sum(G~=0,'all') ; %numero di coppie ordinate
f=zeros(2*N +np+np/2,1);
S =y(1:2:2*N);
I=y(2:2:2*N);
SI = zeros(N,N);
SI(G~=0) = y(2*N+1:2*N+np);
z= y(2*N+np+1:end);
a(2:2:np)= z;
a(1:2:np) = z;
SS=zeros(N,N);
SS(G~=0) = a;

B= G.*SI;
somma = sum(B,2) - B;
f(1:2:2*N)  = -tau * diag(somma);
f(2:2:2*N) = -f(1:2:2*N) - gamma *I ;

coppie = tau * SS./S' .* somma' - tau * SI./S .* somma - (tau + gamma)*SI;
coppie=reshape(coppie',N.^2,1);

f( 2*N+1:2*N+np)= coppie(G~=0);

SaSa= - tau * SS./S'.* somma' - tau * SS./S .* somma;
 SaSa=SaSa-diag(SaSa);
f(2*N+np+1:2*N+np+np/2)= SaSa(triu(G)~=0);
end
 
 
