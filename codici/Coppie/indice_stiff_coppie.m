function sp=indice_stiff_coppie(G,y,tau,gamma)
% sp=indice_stiff_singolo(G,y,tau,gamma) restitituisce lo "stiffness ratio" dove
% G matrice di adiacenza del network
% y punto  in cui si calcola il jacobiano (sani e infetti alternati in ordine crescente dei vertici)
% tau tasso di infezione 
% gamma tasso di rimozione 

JP=JacobianoCoppie(G,1,y,tau,gamma);
ei= abs(eig(full(JP)));
ei = ei(ei~=0) ;
sp=max(ei) /min(ei);
end
