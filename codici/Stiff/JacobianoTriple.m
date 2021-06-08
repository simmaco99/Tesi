function [J,variable,valori]=JacobianoTriple(G,X,Y,XY,XX,tau,gama) 
    % X sani (colonne) 
    % Y infetti 
    % XY coppie sani ed infetti ordinati prima sani e poi infetti 
    % XX coppie sani sani 

    %     Se non hai ancora compilato il programma c++
    %     !g++ CreaCondizioni.cpp -o CreaCondizioni
    
    N=size(G,1);
    fprintf("Inserisci il seguente numero: %d\n",N);
    SS=zeros(N,N);
    !./CreaCondizioni
    Condizioni
    B= G.*coppie;
    somma = sum(B,2) - B;
    Sani = -tau * diag(somma);
    Infetti = -Sani - gama *I ;
    SI = tau * SS./S' .* somma' - tau * coppie./S .* somma - (tau + gama)*coppie;
    SaSa= - tau * SS./S' .* somma' - tau * SS./S .* somma;
    SaSa=SaSa-diag(SaSa);
   

    %da qui in poi serve solo per sistemare l'ordine delle equazioni
    SaSa=triu(SaSa);
    SS=SS.*G;
    SS=triu(SS);
    
    SI=reshape(SI',N.^2,1);
    si=reshape(coppie',N.^2,1);
    SaSa= reshape(SaSa', N*N,1);
    ss=reshape(SS',N*N,1);
    B=reshape(B',N.^2,1);
   
    
    %eliminiamo le variabili inutili
    si=si(B~=0);
    SI=SI(B~=0);
    bool=ss~=0;
    ss=ss(bool);
    SaSa=SaSa(bool);
    
    %Andiamo a sostituire le variabili simboliche introdotte con i valori inseriti dall'utente
    
    equation=[Sani;Infetti; SI; SaSa];
    variable=[S;I; si;ss];  
    valori =[ X;Y; XY(B~=0);XX(bool)];
    J=jacobian(equation,variable);
      J=subs(J,variable, valori);
    
end

   
     
     