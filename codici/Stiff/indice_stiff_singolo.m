function sp=indice_stiff_singolo(G,y,tau,gamma)
% Data la matrice di adiacenza restituisce il rapporto tra l autovalore di modulo massimo e quello di modulo minimo del jacobiano
% del sistema chiuso alle coppie dove y sono le condizioni (alternate sani e infetti)
%
JP=JacobianoCoppie(G,1,y,tau,gamma);
ei= abs(eig(full(JP)));
ei = ei(ei~=0) ;
sp=max(ei) /min(ei);

end
