function [J,equation,variable]=JacobianoTriple_sym(G,tau,gama) 
    %     Se non hai ancora compilato il programma c++
    %     !g++ Jacobiano.cpp -o Jacobiano 
    
    N=size(G,1);
    SS=zeros(N,N);
   np=sum(G,'all');
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
%     SaSa= reshape(SaSa', N*N,1);
%     ss=reshape(SS',N*N,1);
%     B=reshape(B',N.^2,1);
%    
%     
    %eliminiamo le variabili inutili
    si=si(B~=0);
    SI=SI(B~=0);
%     bool=ss~=0;
%     ss=ss(bool);
%     SaSa=SaSa(bool);
% 
b=(G~=0)& (G==triu(G)); 
SaSa=SaSa(b==1);
SS=SS(b==1);


    %Andiamo a sostituire le variabili simboliche introdotte con i valori inseriti dall'utente
    equation = zeros(2*N+np+np/2,1,'sym');
    equation(1:2:2*N) = Sani;
    equation(2:2:2*N) = Infetti;
    equation(2*N+1:2*N +np)=SI;
    equation(2*N+np+1:end)=SaSa;
   
    
    variable = zeros(2*N+np+np/2,1,'sym');
    variable(1:2:2*N) = S;
    variable(2:2:2*N) = I;
    variable(2*N+1:2*N +np) = si;
    variable(2*N+np+1:end) = SS;


    J=jacobian(equation,variable);
    
    % J=subs(J,variable, valori);
   % - (3*S1I3*S1S2)/(10*S1) - (3*S2I3*S1S2)/(10*S2)
end

     
     