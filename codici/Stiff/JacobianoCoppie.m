function J=JacobianoCoppie(G,X,Y,tau,gama)
%X sani 
%Y infetti ordinati in senso crescente dei vertici 
N= size(G,1) ;
J(1:N, 1:N) =  -tau * diag(G*Y) ;
J(1:N, N+1:2*N)= -tau * X.* G; 
J(N+1:2*N,:) = J(1:N,:);
J(N+1:2*N, N+1:2*N) = - gama * eye(N) ;
end

