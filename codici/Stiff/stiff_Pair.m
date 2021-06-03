function s= stiff_Pair(G,X,Y, tau, gamma) 
N= size(G,1) ;
J(1:N, 1:N) =  -tau * diag(G*Y) ;
J(1:N, N+1:2*N)= -tau * X.* G; 
J(N+1:2*N,:) = J(1:N,:);
J(N+1:2*N, N+1:2*N) = - gamma * eye(N) ;
l= abs(eigs(J));
s=max(l(l~=0)) /min(l(l~=0));
end

