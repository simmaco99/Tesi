%per plottare i 4 grafici del modello o-o-o 

tau =0.5;
gamma=1;
c= [1;0;0;0;0;1;0;0;1;0;1;1;0];
[t,y]=ode45(@(t,y) sir3nodi(t,y,.5,1),[ 0 5], c);
cleanfigure;
figure(1);
hold on;
title('Nodo 1');
xlabel('t');
S1=plot(t,y(:,13),'--');
I1=plot(t,y(:,12),'-.');
r1= 1- sum(y(:,[12 13]),2);
R1= plot(t,r1); 
legend([S1 I1 R1], '\langle S_1\rangle(t)','\langle I_1\rangle(t)', '\langle R_1\rangle(t)', 'Interpetrer','latex');
% matlab2tikz('Nodo1.tex');  il sorgente per latex

cleanfigure;
figure(2);
hold on;
title('Nodo 2');
xlabel('t');
S2=plot(t,y(:,11),'--');
I2=plot(t,y(:,10),'-.');
r2= 1- sum(y(:,[11 10]),2);
R2= plot(t,r2); 
legend([S2 I2 R2], '\langle S_2\rangle(t)','\langle I_2\rangle(t)', '\langle R_2\rangle(t)', 'Interpetrer','latex');
% matlab2tikz('Nodo2.tex');  il sorgente per latex

cleanfigure;
figure(3);
hold on;
title('Nodo 3');
xlabel('t');
S3=plot(t,y(:,9),'--');
I3=plot(t,y(:,8),'-.');
r3= 1- sum(y(:,[9 8]),2);
R3= plot(t,r3); 
legend([S3 I3 R3], '\langle S_3\rangle(t)','\langle I_3\rangle(t)', '\langle R_3\rangle(t)', 'Interpetrer','latex');
% matlab2tikz('Nodo3.tex');  il sorgente per latex
