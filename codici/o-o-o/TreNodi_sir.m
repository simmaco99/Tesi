function f=3nodi_sir(t,y, tau, gamma) 
% f=TreNodi_sir(G,t,y,tau, gamma) restituisce la funzione che risolve il modello esatto per la rete con o-o-o
% t tempo (serve per usare le funzioni ode)
% y soluzione (per l'ordine si guarda il file TreNodi_sir.txt)
% tau tasso di infezione 
% gamma tasso di recupero

f=zeros(13,1);
f(1)=-tau*y(7);
f(2)=tau*y(7)-gamma*y(2);
f(3)=-tau*(y(8)+y(9));	
f(4)=tau*(y(8)+y(9))-gamma*y(4);
f(5)=-tau*y(10);	
f(6)=tau*y(10)-gamma*y(6);
f(7)=tau*y(11)-(tau+gamma)*y(7);
f(8)=-tau*y(12)-(tau+gamma)*y(8);
f(9)=-tau*y(12)-(tau+gamma)*y(9);
f(10)=tau*y(13)-(tau+gamma)*y(10);
f(11)=-(tau+gamma)*y(11);
f(12)=-(2*tau+2*gamma)*y(12);
f(13)=-(tau+gamma)*y(13);
end


