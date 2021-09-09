% Questo script permette di creare tutti i file per il grafo lollipop
% Le condizioni iniziali sono  1 certamente infetto e 2,3,4 certamente sani
% Per la numerazione delle equazini  : pattern_sir.txt (modello esatto) e pattern_cut.txt (modello cut-vertex)

clear;clc; close all;

%PARAMETRI
AbsTol=1e-12;
opts= odeset( 'AbsTol',AbsTol,'RelTol', 1e-12);
tau =0.3;
gamma= 0.1;

G=[ 0 1 1 0 ; 1 0 1 0 ; 1 1 0 1 ; 0 0 1 0  ];
N=size(G,1);
Gamma = diag(gamma*ones(N,1));

%CONDIZIONI INIZIALI

CutPair=zeros(2*N,1);
CutPair(1:2:2*N) = 1;
CutPair(2*4-1) = 0;
CutPair(2*4)= 1;

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

Esatto= y0e(CutPair);


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

CutVertex= y0c(CutPair);

%queste vengono create dalla funzione Condizioni_Iniziali_Triple.cpp
S=[1;1;1;0];
I=[0;0;0;1];
coppie=[0 S(1)*I(2) S(1)*I(3) S(1)*I(4) ;S(2)*I(1) 0 S(2)*I(3) S(2)*I(4) ;S(3)*I(1) S(3)*I(2) 0 S(3)*I(4) ;S(4)*I(1) S(4)*I(2) S(4)*I(3) 0 ;]';
SS=[0 S(1)*S(2) S(1)*S(3) S(1)*S(4) ;S(1)*S(2) 0 S(2)*S(3) S(2)*S(4) ;S(1)*S(3) S(2)*S(3) 0 S(3)*S(4) ;S(1)*S(4) S(2)*S(4) S(3)*S(4) 0 ;];

b=(G~=0)& (G==triu(G)); 
SS=SS(b==1);
CutTriple= zeros(2*N,1);
CutTriple(2:2:2*N) = I ; 
CutTriple(1:2:2*N) = S ; 
CutTriple=[CutTriple;coppie(G~=0); SS ];

clear S I coppie b SS  y0e y0c

[T,Y]=ode45(@(t1,y1) Lollipop_sir(t1,y1,tau,gamma),[0 60], Esatto,opts);
[T,Yc]=ode45(@(t1,y1) closePair(G,t1,y1,tau, Gamma),  T, CutPair,opts);
[T,Yv]=ode45(@(t1,y1) Lollipop_cutvertex(t1,y1,tau,gamma),T, CutVertex,opts);
[TY,Yt]=ode45(@(t,y) closeTriple(G,t,y,tau,gamma),T, CutTriple,opts);


%Grafici per lo stato del modello cut-vertex 
for i=1:4
    cleanfigure;
    plot( T, Yv(:,2*i-1),T,Yv(:,2*i),T,1-Yv(:,2*i-1)-Yv(:,2*i), 'LineWidth',2);
    legend({'Sani', 'Infetti','Rimossi'},'FontSize',14);
    xlabel('T');
    str=sprintf('Lollipop_Nodo%d.tex', i);
    matlab2tikz('showInfo', false,str);
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
    matlab2tikz('showInfo', false,str);

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
    matlab2tikz('showInfo', false,str);
end


%Modello esatto chiuso alle coppie e alle triple 
for i=1:8
%     cleanfigure
    plot(T,Y(:,i),T,Yc(:,i),T,Yt(:,i),'LineWidth',2);
    legend({'Esatto','Chiuso alle coppie','Chiuso alle triple'}, 'FontSize',14);
    xlabel('T')
    if (mod(i,2)==1 ) 
        s='S';
    else
        s='I';
    end
    str=sprintf('Lollipop_Modelli_%s%d.tex', s,round(i/2));
    matlab2tikz('showInfo', false,str);
end

