% Questo script permette di creare tutti i file per il grafo lollipop
% Le condizioni iniziali sono  1 certamente infetto e 2,3,4 certamente sani
% Per la numerazione delle equazini  : patternesatto.txt (modello esatto) e patterncut.txt (modello cut-vertex)

clear;clc; close all;

%PARAMETRI
AbsTol=1e-9;
opts= odeset( 'AbsTol',AbsTol,'RelTol', 1e-7);
tau =0.3;
gamma= 0.1;

G=[ 0 1 1 0 ; 1 0 1 0 ; 1 1 0 1 ; 0 0 1 0  ];
Gamma = gamma*ones(4,1);

%CONDIZIONI INIZIALI
y0e= @(y0) [y0(1);
y0(2);
y0(3);
y0(4);
y0(5);
y0(6);
y0(7);
y0(8);
y0(1)*y0(4);
y0(1)*y0(6);
y0(2)*y0(3);
y0(3)*y0(6);
y0(2)*y0(5);
y0(4)*y0(5);
y0(5)*y0(8);
y0(6)*y0(7);
y0(1)*y0(3)*y0(6);
y0(1)*y0(4)*y0(6);
y0(1)*y0(4)*y0(5);
y0(2)*y0(3)*y0(6);
y0(2)*y0(3)*y0(5);
y0(2)*y0(4)*y0(5);
y0(2)*y0(5)*y0(8);
y0(2)*y0(5)*y0(7);
y0(3)*y0(5)*y0(8);
y0(4)*y0(5)*y0(8);
y0(4)*y0(5)*y0(7);
y0(1)*y0(5)*y0(8);
y0(2)*y0(4)*y0(5)*y0(8);
y0(1)*y0(4)*y0(5)*y0(8);
y0(2)*y0(3)*y0(5)*y0(8);
y0(2)*y0(4)*y0(5)*y0(7);
y0(2)*y0(3)*y0(5)*y0(7);
y0(1)*y0(4)*y0(5)*y0(7);
y0(1)*y0(3)*y0(5)*y0(8)];

Esatto= y0e([ 0,1,1,0,1,0,1,0]);

y0c= @(y0)[
    y0(1);
    y0(2);
    y0(3);
    y0(4);
    y0(5);
    y0(6);
    y0(7);
    y0(8);
    y0(1)*y0(4);
    y0(1)*y0(6);
    y0(2)*y0(3);
    y0(3)*y0(6);
    y0(2)*y0(5);
    y0(4)*y0(5);
    y0(5)*y0(8);
    y0(6)*y0(7);
    y0(1)*y0(5);
    y0(3)*y0(5);
    y0(5)*y0(7);
    y0(1)*y0(3)*y0(6);
    y0(1)*y0(4)*y0(6);
    y0(1)*y0(4)*y0(5);
    y0(2)*y0(3)*y0(6);
    y0(2)*y0(3)*y0(5);
    y0(2)*y0(4)*y0(5);
    y0(1)*y0(3)*y0(5)];

Cut= y0c([ 0,1,1,0,1,0,1,0]);
CutPair=[ 0;1;1;0;1;0;1;0];


[T,Y]=ode45(@(t1,y1) LollipopEsatto(t1,y1,tau,gamma),[0 60], Esatto,opts);
[T,Yc]=ode45(@(t1,y1) closePair(G,t1,y1,tau, Gamma),  T, CutPair,opts);
[T,Yv]=ode45(@(t1,y1) LollipopCut_Vertex(t1,y1,tau,gamma),T, Cut,opts);

%Grafici per lo stato del modello cut-vertex 
for i=1:4
    cleanfigure;
    plot( T, Yv(:,2*i-1),T,Yv(:,2*i),T,1-Yv(:,2*i-1)-Yv(:,2*i), 'LineWidth',2);
    legend({'Sani', 'Infetti','Rimossi'},'FontSize',14);
    xlabel('T');
    str=sprintf('Lollipop_Nodo%d.tex', i);
    matlab2tikz(str);
end

%Errore assoluto tra modello esatto e cut-vertex
err2= abs(Y(:,1:8) - Yv(:,1:8));
for i=1:4
    cleanfigure;
    semilogy(T,err2(:,2*i-1),T,err2(:,2*i),'LineWidth',2);
    legend({'Sani','Infetti'}, 'FontSize',14);
    xlabel('T')
    ylabel('Errore assoluto');
    str=sprintf('Lollipop_Errore%d.tex', i);
    matlab2tikz(str);

end

%Errore assoluto tra modello esatto e chiuso alle coppie
err2= abs(Y(:,1:8) - Yc(:,1:8));
for i=1:4
    cleanfigure;
    semilogy(T,err2(:,2*i-1),T,err2(:,2*i),'LineWidth',2);
    legend({'Sani','Infetti'}, 'FontSize',14);
    xlabel('T')
    ylabel('Errore assoluto');
    str=sprintf('Pair_Lollipop_Errore%d.tex', i);
    matlab2tikz(str);
end



