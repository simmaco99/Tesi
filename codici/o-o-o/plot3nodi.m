%per plottare i 4 grafici del modello o-o-o 
tau =0.5;
gamma=1;
c= zeros(13,1);
c([2 3 5 8 13])=1;
LineWidth=2;
FontSize=12;

[t,y]=ode45(@(t,y) sir3nodi(t,y,.5,1),[ 0 5], c);
cleanfigure;

figure();
hold on;
xlabel('t');
S1=plot(t,y(:,13),'b--');
I1=plot(t,y(:,12),'g-.');

r1= 1- sum(y(:,[12 13]),2);
R1= plot(t,r1,'r'); 
S1.LineWidth=LineWidth;
I1.LineWidth=LineWidth;
R1.LineWidth=LineWidth;

L1=legend([S1 I1 R1], '\langle S_1\rangle(t)','\langle I_1\rangle(t)', '\langle R_1\rangle(t)', 'Interpetrer','latex');
L1.FontSize=FontSize;
matlab2tikz('Nodo1.tex');  %il sorgente per latex

cleanfigure;
figure();
hold on;
xlabel('t');
S2=plot(t,y(:,11),'b--');
I2=plot(t,y(:,10),'g-.');
r2= 1- sum(y(:,[11 10]),2);
R2= plot(t,r2,'r'); 
S2.LineWidth=LineWidth;
I2.LineWidth=LineWidth;
R2.LineWidth=LineWidth;
L2=legend([S2 I2 R2], '\langle S_2\rangle(t)','\langle I_2\rangle(t)', '\langle R_2\rangle(t)', 'Interpetrer','latex');
L2.FontSize=FontSize;
matlab2tikz('Nodo2.tex'); % il sorgente per latex

cleanfigure;
figure();
hold on;
title('Nodo 3');
xlabel('t');
S3=plot(t,y(:,9),'b--');
I3=plot(t,y(:,8),'g-.');
r3= 1- sum(y(:,[9 8]),2);
R3= plot(t,r3,'r'); 
S3.LineWidth=LineWidth;
I3.LineWidth=LineWidth;
R3.LineWidth=LineWidth;
L3=legend([S3 I3 R3], '\langle S_3\rangle(t)','\langle I_3\rangle(t)', '\langle R_3\rangle(t)', 'Interpetrer','latex');
L3.FontSize=FontSize;
matlab2tikz('Nodo3.tex');  %il sorgente per latex

cleanfigure;
figure();
hold on 
TotI=y(:,12)+ y(:,10)+y(:,8);
TotS=y(:,13)+ y(:,11)+y(:,9);
P=plot(t,TotI./(TotI+TotS));
P.LineWidth=LineWidth;
matlab2tikz('Prevalenza.tex');  %il sorgente per latex
