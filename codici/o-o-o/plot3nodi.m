% Questo script permette di creare tutti i file per il grafo o-o-o
% Le condizioni iniziali sono  1 certamente infetto e 2,3,4 certamente sani
% Per la numerazione delle equazini  : pattern3nodi.txt (modello esatto) e pattern3nodi_cutvertex.txt (modello cut-vertex)


clear;clc;close;
AbsTol=1e-9;
opts= odeset( 'AbsTol',AbsTol,'RelTol', 1e-7);

tau =0.3;
gamma=0.1;
esatto= zeros(13,1);
esatto([2 3 5 8 13])=1; %CI modello esatto 
cut=zeros(12,1);
cut([2 3 5 8 12])=1; %CI cut-vertex
cc=[ 0; 1; 1;0;1 ;0]; %CI chiusura nodi
[t,y]=ode45(@(t,y) sir3nodi(t,y,tau,gamma),[ 0 60], esatto);
[tc,yc]=ode45(@(t,y) closePair(G,t,y,tau ,Gamma), t,cc,opts); %chiusura coppie
[t,yv]=ode45(@(t,y)  sir3nodi_cutvertex(t,y,tau,gamma),t, cut,opts); %cut-vertex

%Grafici per lo stato del modello esatto 
for i=1:3
    cleanfigure;
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
cleanfigure;
hold on 
TotI=y(:,2)+ y(:,4)+y(:,6);
TotS=y(:,1)+ y(:,3)+y(:,5);
P=plot(t,TotI./(TotI+TotS),'LineWidth',2);
matlab2tikz('Prevalenza.tex');  %il sorgente per latex

%Confronto modello esatto e chiuso alle coppie
for i = 1:3
cleanfigure();
plot(t,y(:,2*i-1),t,yc(:,2*i-1),'LineWidth',2);
str1= sprintf('\\langle S_%d \\rangle(t)',i);
str2=sprintf('\\langle X_%d \\rangle (t)',i);
xlabel('T') 
legend({str1,str2}, 'FontSize',14);
file=sprintf('Coppie_Nodo_%d_Sano.tex',i);
matlab2tikz('showInfo', false,file);

cleanfigure;
plot(t,y(:,2*i),t,yc(:,2*i),'LineWidth',2);
str1= sprintf('\\langle I_%d \\rangle (t)',i);
str2=sprintf('\\langle Y_%d \\rangle (t)',i);
xlabel('T');
legend({str1,str2}, 'FontSize',14);
file=sprintf('Coppie_Nodo_%d_Infetto.tex',i);
matlab2tikz('showInfo', false,file);
end
 
%Confronto della prevalenza modello esatto e chiuso alle coppie
cleanfigure;
TotI=y(:,2)+ y(:,4)+y(:,6);
TotS=y(:,1)+ y(:,3)+y(:,5);
TotY= yc(:,2)+yc(:, 4)+ yc(:, 6);
TotX = yc(:,1)+ yc(:,3)+ yc(:,5);
plot(t,TotI./(TotI + TotS),t,TotY./(TotY+TotX),'LineWidth',2);
legend({'Esatto', 'Chiuso alle coppie'},'FontSize',14);
matlab2tikz('showInfo', false,'Coppie_Prevalenza.tex');

%Grafici per lo stato nel cut-vertex
for i=1:3
    cleanfigure;
    plot(t,yv(:,2*i-1),t,yv(:,2*i ),t,1-yv(:,2*i-1)-yv(:,2*i),'LineWidth',2);
    legend({'Suscettibili', 'Infetti','Rimossi'},'FontSize',14);
    xlabel('T')
    file=sprintf('Cut_Nodo%d',i);
    matlab2tikz('showInfo', false,file);
end

%Errore relativo tra modello esatto e cut-vertex
err=abs(y(:,1:6)-yv(:,1:6));

for i=1:3
cleanfigure;    
plot(t,err(:,2*i-1),t,err(:,2*i),'LineWidth',2);
legend({'Suscettibili','Infetti'},'FontSize',14);
xlabel('T');
ylabel('Errore assoluto');
file=sprintf('Lollipop_Errore%d',i);
matlab2tikz('showInfo', false,file);
end

