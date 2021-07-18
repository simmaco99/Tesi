function f=Lollipop_sir(t,y,tau,gamma)
% f=Lollipop_cutvertex(G,t,y,tau, gamma) restituisce la funzione che risolve il modello esatto per la rete lollipop
% t tempo (serve per usare le funzioni ode)
% y soluzione (per l'ordine si guarda il file Lollipop_sir.txt)
% tau tasso di infezione 
% gamma tasso di recupero

f=zeros(35,1);
f(1)=-tau*(y(10)+y(9));
f(5)=-tau*(y(13)+y(14)+y(15));
f(2)=tau*(y(9)+y(10))-gamma*y(2);
f(6)=tau*(y(13)+y(14)+y(15))-gamma*y(6);
f(3)=-tau*(y(11)+y(12));
f(7)=-tau*y(16);
f(4)=tau*(y(11)+y(12))-gamma*y(4);
f(8)=tau*y(16)-gamma*y(8);
f(9)=tau*y(17)-(tau+gamma)*y(9)-tau*y(18);
f(10)=tau*(y(19)+y(28))-(tau+gamma)*y(10)-tau*y(18);
f(11)=tau*y(17)-(tau+gamma)*y(11)-tau*y(20);
f(12)=tau*(y(21)+y(25))-(tau+gamma)*y(12)-tau*y(20);
f(13)=-tau*(y(22)+y(23))-(tau+gamma)*y(13)+tau*y(19);
f(14)=-tau*(y(22)+y(26))-(tau+gamma)*y(14)+tau*y(21);
f(15)=-tau*(y(23)+y(26))-(tau+gamma)*y(15);
f(16)=tau*(y(24)+y(27))-(tau+gamma)*y(16);
f(17)=tau*y(35)-(2*tau+gamma)*y(17);
f(18)=tau*(y(17)+y(30))-2*(tau+gamma)*y(18)+tau*y(19);
f(19)=-tau*y(30)-(2*tau+gamma)*y(19);
f(20)=tau*y(17)-2*(tau+gamma)*y(20)+tau*y(21)+tau*y(31);
f(21)=-tau*y(31)-(2*tau+gamma)*y(21);
f(22)=tau*(y(19)+y(21)-y(29))-2*(tau+gamma)*y(22);
f(23)=-2*(tau+gamma)*y(23)+tau*y(30)-tau*y(29);
f(24)=-(tau+gamma)*y(24)+tau*y(34)-tau*y(32);
f(25)=-(tau+gamma)*y(25)-2*tau*y(31);
f(26)=-2*(tau+gamma)*y(26)+tau*y(31)-tau*y(29);
f(27)=-(tau+gamma)*y(27)+tau*y(33)-tau*y(32);
f(28)=-2*tau*y(30)-(tau+gamma)*y(28);
f(29)=-3*(tau+gamma)*y(29)+tau*(y(30)+y(31));
f(30)=-(3*tau+2*gamma)*	y(30);
f(31)=-(3*tau+2*gamma)*y(31);
f(32)=tau*(y(34)+y(33))-2*(tau+gamma)*y(32);
f(33)=-(2*tau+gamma)*y(33);
f(34)=-(2*tau+gamma)*y(34);
f(35)=-(tau+gamma)*y(35);
end