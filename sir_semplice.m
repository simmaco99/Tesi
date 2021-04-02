function [S,I,R]= sir_semplice(N,S0,I0, beta, alpha,T,dT)
%dT intervallo temporale, dunque vengono calcolati T*dT aggiornamenti
close all;
int=T/dT;
S=zeros(1,int);
I=zeros(1,int);
S(1) = S0;
I(1) = I0;

for t=1:int-1
    dS=   -beta* I(t)*S(t)*dT;
    dI= (beta*I(t) *S(t)- alpha*I(t))*dT;
    S(t+1) = S(t)+dS;
    I(t+1) =I(t)+ dI;
end

R= ones(1,int)*N -S-I;

hold on;
SS= plot(1:int,S(1:end));
II= plot(1:int, I(1:end));
RR= plot(1:int,R(1:end));
legend([SS II RR], "S", "I","R");
end
