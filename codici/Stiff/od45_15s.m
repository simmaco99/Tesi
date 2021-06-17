
%Questo script permetti di salvare tutti i grafici del  grafico o-o-o
clear;clc;close all;

%PARAMETRI
AbsTol=1e-12;
opts= odeset( 'AbsTol',AbsTol,'RelTol', 1e-10);

% tau =0.3;
gamma=0.1;

G=[ 0 1 0 ; 1 0 1 ; 0 1 0 ];
Gamma = gamma*ones(3,1);

%Condizioni iniziali 
%Modello esatto 
CutPair=[ 0; 1; 1;0;1 ;0]; 
lun=50;
tau= linspace(0.1,1,lun);


%condizioni chiuso alle triple
S=0.5*ones(3,1);
I=0.5*ones(3,1);
coppie=[
0 S(1)*I(2) S(1)*I(3) 
S(2)*I(1) 0 S(2)*I(3) 
S(3)*I(1) S(3)*I(2) 0 
]';
SS=[
0 S(1)*S(2) S(1)*S(3) 
S(1)*S(2) 0 S(2)*S(3) 
S(1)*S(3) S(2)*S(3) 0 
];
SS=SS(G~=0);
SS=SS(1:2:end);
co=[ S; I;coppie(G~=0); SS ];
Pair=zeros(lun,2);
Tri=Pair;

 for i =1:lun
     disp(i)
     [t,~]=ode45(@(t,y) closePair(G,t,y,tau(i) ,Gamma),[0 10] ,CutPair,opts); %chiusura coppie
     Pair(i,1)=length(t);
    [t,~]=ode15s(@(t,y) closePair(G,t,y,tau(i) ,Gamma),[0 60] ,CutPair,opts); %chiusura coppie
     Pair(i,2)=length(t);
     [t,~]=ode45(@(t,y) closeTriple(G,t,y,tau(i) ,gamma),[0 60] ,co,opts); %chiusura coppie
     Tri(i,1)=length(t);
     [t,~] = ode15s(@(t,y) closeTriple(G,t,y,tau(i),gamma),[0 60 ], co , opts);
   Tri(i,2)=length(t);
end

subplot(1,2,1)
plot(tau,Pair(:,1), tau,Pair(:,2))
legend('ode45', 'ode15s')
xasis('\tau');
yasis('lenght');
title('Modello chiuso alle coppie');

subplot(1,2,2)
plot(tau,Tri(:,1), tau,Tri(:,2))
legend('ode45','ode15s')
xlabel('\tau');
ylabel('lenght');
title('Modello chiuso alle triple');




