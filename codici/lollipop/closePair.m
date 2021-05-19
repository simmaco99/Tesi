function f=closePair(G,t,y,tau, Gamma)
% Data la matrice di Adiacenza delle rete crea la funzione che serve per
% risolvere l'ode chiuso alle coppie
% G matrice di afiacenza
% tau fattore di contagio 
% Gamma vettore dei tassi di recupero gamma_1 , ... gamma_n

Gamma= diag(Gamma);

n=size(G,1);
% X sono le posizioni dispari 
% Y sono le posizioni pari 

f= zeros(2*n,1);
dispa=1:2:2*n;
pari = 2:2:2*n;
f(dispa) = -tau* G*y(pari).* y(dispa) ;
f(pari) = -f(dispa) - Gamma*y(pari) ;
end
