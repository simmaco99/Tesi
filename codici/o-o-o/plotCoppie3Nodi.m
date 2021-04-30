%Chiusura a livello delle singole vs modello esatto su o-o-o
% Condizioni inziali I_1 S_2 S_3 

c=[1;0;0;0;0;1;0;0;1;0;1;1;0]; %CI modello esatto
cc=[ 0; 1; 1;0;1 ;0]; %CI chiusura nodi
LineWidth=2;
FontSize=12;

tau =0.5;
gamma=1;
[t,y]=ode45(@(t,y) sir3nodi(t,y,.5,1),[ 0 5], c); %soluzione esatta
[tc,yc]=ode45(@(t,y) Coppie3nodi(t,y,.5,1), [0,5],cc); %chiusura coppie
close all;

figure(1)
hold on

S1=plot(t,y(:,13),'b--');
I1=plot(t,y(:,12),'b-.');
X1= plot(tc, yc(:,1), 'r--');
Y1= plot(tc, yc(:,2), 'r-.');
S1.LineWidth=LineWidth;
I1.LineWidth=LineWidth;
X1.LineWidth=LineWidth;
Y1.LineWidth=LineWidth;

L1=legend([S1 I1 X1 Y1], '\langle S_1\rangle(t)','\langle I_1\rangle(t)', '\langle X_1\rangle(t)', '\langle Y_1\rangle(t)','Interpetrer','latex');
L1.FontSize=FontSize;
matlab2tikz('Coppie_Nodo1.tex');  


figure(2)
hold on;
S2=plot(t,y(:,11),'b--');
I2=plot(t,y(:,10),'b-.');
X2= plot(tc, yc(:,3), 'r--');
Y2= plot(tc, yc(:,4), 'r-.');

S2.LineWidth=LineWidth;
I2.LineWidth=LineWidth;
X2.LineWidth=LineWidth;
Y2.LineWidth=LineWidth;
L2=legend([S2 I2 X2 Y2], '\langle S_2 \rangle(t)','\langle I_2\rangle(t)', '\langle X_2\rangle(t)', '\langle Y_2\rangle(t)','Interpetrer','latex');
L1.FontSize=FontSize;
matlab2tikz('Coppie_Nodo2.tex');  


figure(3)
hold on;
S3=plot(t,y(:,9),'b--');
I3=plot(t,y(:,8),'b-.');
X3= plot(tc, yc(:,5), 'r--');
Y3= plot(tc, yc(:,6), 'r-.');

S3.LineWidth=LineWidth;
I3.LineWidth=LineWidth;
X3.LineWidth=LineWidth;
Y3.LineWidth=LineWidth;

L3=legend([S3 I3 X3 Y3], '\langle S_3\rangle(t)','\langle I_3\rangle(t)', '\langle X_3\rangle(t)', '\langle Y_3\rangle(t)','Interpetrer','latex');
L3.FontSize=FontSize;
matlab2tikz('Coppie_Nodo3.tex');  %il sorgente per latex



