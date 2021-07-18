function f=Lollipop_cutvertex(t,y,tau,gamma)
% f=Lollipop_cutvertex(G,t,y,tau, gamma) restituisce la funzione che risolve il modello utilizzando il cut-vertex per la rete lollipop
% t tempo (serve per usare le funzioni ode)
% y soluzione (per l'ordine si guarda il file Lollipop_cutvertex.txt)
% tau tasso di infezione 
% gamma tasso di recupero

f=zeros(26,1);
f(1)=-tau*(y(10)+y(9));
f(2)=tau*(y(9)+y(10))-gamma*y(2);
f(3)=-tau*(y(11)+y(12));
f(4)=tau*(y(11)+y(12))-gamma*y(4);
f(5)=-tau*(y(13)+y(14)+y(15));
f(6)=tau*(y(13)+y(14)+y(15))-gamma*y(6);
f(7)=-tau*y(16);
f(8)=tau*y(16)-gamma*y(8);
f(9)=tau*y(20)-(tau+gamma)*y(9)-tau*y(21);
f(10)=tau*(y(22)+y(17)*y(15)/y(5))-(tau+gamma)*y(10)-tau*y(21);
f(11)=tau*y(20)-(tau+gamma)*y(11)-tau*y(23);
f(12)=tau*(y(24)+y(18)*y(15)/y(5))-(tau+gamma)*y(12)-tau*y(23);
f(13)=-tau*(y(25)+y(13)*y(15)/y(5))-(tau+gamma)*y(13)+tau*y(22);
f(14)=-tau*(y(25)+y(14)*y(15)/y(5))-(tau+gamma)*y(14)+tau*y(24);
f(15)=-tau*(y(13)*y(15)/y(5)+y(14)*y(15)/y(5))-(tau+gamma)*y(15);
f(16)=tau*(y(13)*y(19)/y(5)+y(14)*y(19)/y(5))-(tau+gamma)*y(16);
f(17)=-tau*y(17)*y(15)/y(5)-2*tau*y(22);
f(18)=-tau*y(18)*y(15)/y(5)-2*tau*y(24);
f(19)=-tau*y(13)*y(19)/y(5)-tau*y(14)*y(19)/y(5);
f(20)=tau*y(26)*y(15)/y(5)-(2*tau+gamma)*y(20);
f(21)=tau*(y(20)+y(22)*y(15)/y(5))-2*(tau+gamma)*y(21)+tau*y(22);
f(22)=-tau*y(22)*y(15)/y(5)-(2*tau+gamma)*y(22);
f(23)=tau*y(20)-2*(tau+gamma)*y(23)+tau*y(24)+tau*y(24)*y(15)/y(5);
f(24)=-tau*y(24)*y(15)/y(5)-(2*tau+gamma)*y(24);
f(25)=tau*(y(22)+y(24)-y(25)*y(15)/y(5))-2*(tau+gamma)*y(25);
f(26)=-tau*y(26)*y(15)/y(5);

end