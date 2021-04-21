function f=sir3nodi(t,y, tau, gamma) 
%f contiene le equazioni per risolvere sir sul grafo o-o-o
%vedi pagina 69 di kiss, y e dal basso verso l'alto ovvero y(1) = I1S2S3
c =tau + gamma;
f= zeros(13,1);
v= [ 1;2];
f(1:2) = - c * v .* y( v) ; 
f(3) = -c*y(3);
f(4:7)= tau * [ 1; -1 ; -1 ; 1] .* y ( [ 1 2 2 3 ] )- c * y(4:7);
f([9 13]) = -tau * y([4 7]) ;
f([8 12]) = -f(9) - gamma*y([8 12]);
f(11) = - tau*(y(6) + y( 5) ); 
f(10) = -f(11) - gamma*y(10);
end

