function [S,I,R]= sir_semplice(N,S0,I0, beta, alpha,T,dT)
%dT intervallo temporale, dunque vengono calcolati T*dT aggiornamenti
close all;
tempi = 1: T*dT;
S(1) = S0;
I(1) = I0;
for i=tempi
    S(i+1) = S(i)-  beta* S(i) * I(i);
    I(i+1) =I(i)+ beta *S(i) * I(i) - alpha * I(i);
    R(i+1) = N- S(i+1) - I(i+1) ; 
end
hold on;
SS= plot(tempi,S(1:end-1));
II= plot(tempi, I(1:end-1));
RR= plot(tempi,R(1:end-1));
legend([SS II RR], "S", "I","R");
end
