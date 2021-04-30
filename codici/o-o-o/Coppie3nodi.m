function f=PairClose3nodi(t,y, tau, gamma) 
%f contiene le equazioni per risolvere sir sul grafo o-o-o
%vedi pagina 69 di kiss, y e dal basso verso l'alto ovvero y(1) = I1S2S3

f= zeros(6,1);
f(1) = -tau*y(1) *y(4);
f(3) = - tau* y(3)*( y(2) + y(6));
f(5) = -tau * y(4) * y(5);
i=[2;4;6] ;
f(i) = -f(i-1) - gamma*y(i);


end

