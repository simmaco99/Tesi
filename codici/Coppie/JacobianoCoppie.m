function J=JacobianoCoppie(G,t,y,tau,gamma)
% J=JacobianoCoppie(G,t,y,tau,gamma) restituisce il jacobiano del modello chiuso alle coppie dove 
% G matrice di adiacenza del network
% t tempo (serve per usare le funzioni ode)
% y punto in cui si calcola il jacobiano (sani e infetti alternati in ordine crescente dei vertici)
% tau tasso di infezione
% gamma tasso di rimozione

N=size(G,1);
X=y(1:2:2*N);
Y=y(2:2:2*N);
v=diag(G*Y);
A=X.*G;
J=[-tau * v,-tau * A; -tau * v,-tau * A - gamma * speye(N) ];
end