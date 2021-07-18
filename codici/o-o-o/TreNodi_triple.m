function f=TreNodi_triple(t,y,tau, gamma)
% f=3nodi_triple(G,t,y,tau, gamma) restituisce la funzione che risolve il modello chiuso alle triple  per la rete con o-o-o
% t tempo (serve per usare le funzioni ode)
% y soluzione
% tau tasso di infezione 
% gamma tasso di recupero
f=zeros(12,1,'sym');
f(1) = - tau * y(7) ; 
f(2)=tau *y(7)-gamma*y(2);
f(3)=-tau *(y(8)+y(9));	
f(4)=tau *(y(8)+y(9))-gamma*y(4);
f(5)=-tau *y(10);
f(6)=tau *y(10)-gamma*y(6);
f(7)=tau *y(11)*y(9)/y(3)- (tau + gamma)*y(7);
f(8)=-tau *y(8)*y(9)/y(3)- (tau + gamma)*y(8);
f(9)=-tau *(y(8)*y(9))/y(3)- (tau + gamma)*y(9);
f(10)=tau *(y(8)*y(12))/y(3)-(tau + gamma)*y(10);
f(11)=-tau *(y(11)*y(9))/y(3);
f(12)=-tau *(y(8)*y(12))/y(3);
end