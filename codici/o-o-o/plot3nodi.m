%Questo script permetti di salvare tutti i grafici del  grafico o-o-o
clear;clc;close all;

%PARAMETRI
AbsTol=1e-12;
opts= odeset( 'AbsTol',AbsTol,'RelTol', 1e-12);
tau =0.3;
gamma=0.1;

G=[ 0 1 0 ; 1 0 1 ; 0 1 0 ];
Gamma = gamma*ones(3,1);

%Condizioni iniziali 
%Modello esatto 
Esatto= zeros(13,1);
Esatto([2 3 5 8 13])=1; 
CutVertex=zeros(12,1);
CutVertex([2 3 5 8 12])=1;
CutPair=[ 0; 1; 1;0;1 ;0]; 


[t,y]=ode45(@(t,y) sir3nodi(t,y,tau,gamma),[ 0 60], Esatto);
[t,yc]=ode45(@(t,y) closePair(G,t,y,tau ,Gamma), t,CutPair,opts); %chiusura coppie
[t,yv]=ode45(@(t,y)  sir3nodi_cutvertex(t,y,tau,gamma),t, CutVertex,opts); %cut-vertex

%Grafici per lo stato del modello esatto 
for i=1:3
    figure();
    plot(t,y(:,2*i-1),t,y(:,2*i ),t,1-y(:,2*i-1)-y(:,2*i),'LineWidth',2);
    str1=sprintf('\\langle S_%d\\rangle(t)',i);
    str2=sprintf('\\langle I_%d\\rangle(t)',i);
    str3=sprintf('\\langle R_%d\\rangle(t)',i);
    legend({str1,str2, str3},'FontSize',14);
    xlabel('T')
    file= sprintf('Nodo%d.tex',i);
    matlab2tikz('showInfo', false,file);  %il sorgente per latex
end

%Grafico della prevalenza del modello esatto
figure();
hold on 
TotI=y(:,2)+ y(:,4)+y(:,6);
TotS=y(:,1)+ y(:,3)+y(:,5);
P=plot(t,TotI./(TotI+TotS),'LineWidth',2);
matlab2tikz('showInfo',false,'Prevalenza.tex');  %il sorgente per latex

%Confronto modello esatto e chiuso alle coppie
for i = 1:3
figure();
plot(t,y(:,2*i-1),t,yc(:,2*i-1),'LineWidth',2);
str1= sprintf('\\langle S_%d \\rangle(t)',i);
str2=sprintf('\\langle X_%d \\rangle (t)',i);
xlabel('T') 
legend({str1,str2}, 'FontSize',14);
file=sprintf('Coppie_Nodo_%d_Sano.tex',i);
matlab2tikz('showInfo', false,file);

figure();
plot(t,y(:,2*i),t,yc(:,2*i),'LineWidth',2);
str1= sprintf('\\langle I_%d \\rangle (t)',i);
str2=sprintf('\\langle Y_%d \\rangle (t)',i);
xlabel('T');
legend({str1,str2}, 'FontSize',14);
file=sprintf('Coppie_Nodo_%d_Infetto.tex',i);
matlab2tikz('showInfo', false,file);
end
 
%Confronto della prevalenza modello esatto e chiuso alle coppie
figure();
TotI=y(:,2)+ y(:,4)+y(:,6);
TotS=y(:,1)+ y(:,3)+y(:,5);
TotY= yc(:,2)+yc(:, 4)+ yc(:, 6);
TotX = yc(:,1)+ yc(:,3)+ yc(:,5);
plot(t,TotI./(TotI + TotS),t,TotY./(TotY+TotX),'LineWidth',2);
legend({'Esatto', 'Chiuso alle coppie'},'FontSize',14);
matlab2tikz('showInfo', false,'Coppie_Prevalenza.tex');

%Grafici per lo stato nel cut-vertex
for i=1:3
    figure();
    plot(t,yv(:,2*i-1),t,yv(:,2*i ),t,1-yv(:,2*i-1)-yv(:,2*i),'LineWidth',2);
    legend({'Suscettibili', 'Infetti','Rimossi'},'FontSize',14);
    xlabel('T')
    file=sprintf('Cut_Nodo%d.tex',i);
    matlab2tikz('showInfo', false,file);
end

%Errore assoluto tra modello esatto e cut-vertex
err=abs(y(:,1:6)-yv(:,1:6));
for i=1:3
figure();    
plot(t,err(:,2*i-1),t,err(:,2*i),'LineWidth',2);
legend({'Suscettibili','Infetti'},'FontSize',14);
xlabel('T');
ylabel('Errore assoluto');
file=sprintf('Errore%d.tex',i);
matlab2tikz('showInfo', false,file);
end

%Errore assoluto tra modello esatto e chiuso alle coppie
err2=abs(y(:,1:6)- yc(:,1:6));
for i =1:3
    figure()
    semilogy(t,err2(:,2*i-1),t,err2(:,2*i),'LineWidth',2);
    legend({'Suscettibili','Infetti'},'FontSize',14);
    xlabel('T');
    ylabel('Errore assoluto');
    file=sprintf('Pair_Errore%d.tex',i);
    matlab2tikz('showInfo', false,file);
end

for i=1:3
    subplot(3,2,2*i-1);
    plot(t,yv(:,2*i-1),t,y(:,2*i-1 ),'LineWidth',2);
    xlabel('T');
    subplot(3,2,2*i);
    plot(t,y(:,2*i), t,yv(:,2*i),'LineWidth',2);
    xlabel('T')
    
end

er= abs(yv(:,1:6) - y(:,1:6));

