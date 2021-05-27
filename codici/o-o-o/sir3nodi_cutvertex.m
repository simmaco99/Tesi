function f=sir3nodi_cutvertex(t,y, tau, gamma)
%per l'ordine delle variabile leggi pattern3nodi_cut_vertex.txt
f=zeros(12,1);
f(1)=-tau *y(7);
f(2)=tau *y(7)-gamma*y(2);
f(3)=-tau *(y(8)+y(9));	
f(4)=tau *(y(8)+y(9))-gamma*y(4);
f(5)=-tau *y(10);
f(6)=tau *y(10)-gamma*y(6);
f(7)=tau *(y(11)*y(9))/y(3)- (tau + gamma)*y(7);
f(8)=-tau *(y(8)*y(9))/y(3)- (tau + gamma)*y(8);
f(9)=-tau *(y(8)*y(9))/y(3)- (tau + gamma)*y(9);
f(10)=tau *(y(8)*y(12))/y(3)-(tau + gamma)*y(10);
f(11)=-tau *(y(11)*y(9))/y(3);
f(12)=-tau *(y(8)*y(12))/y(3);
end