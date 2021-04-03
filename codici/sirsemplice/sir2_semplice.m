function [S,I,R]= sir2_semplice(N,S0,I0, beta, alpha,T)
%serve la funzione sir
c=[S0; I0];
[t,y]=ode45(@(t,y) sir(t,y,alpha,beta), [0 T] , [ S0;I0]);

R= ones(size(t,1),1)*N -y(:,1)-y(:,2);
S=y(:,1);
I=y(:,2);

hold on ;
SS= plot(t,S);
II= plot(t, I);
RR= plot(t,R);
legend([SS II RR], "S", "I","R");
end
