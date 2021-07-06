function J=JacobianoCoppie(G,t,y,tau,gamma)
%X sani 
%Y infetti ordinati in senso crescente dei vertici 
N=size(G,1);
X=y(1:2:2*N);
Y=y(2:2:2*N);
v=diag(G*Y);
A=X.*G;
J=[-tau * v,-tau * A; -tau * v,-tau * A - gamma * speye(N) ];
end