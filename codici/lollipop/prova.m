%condizioni iniziali 1 infetto gli altri sani  sptto ipotesi di indipenenza
%statica delle condizioni inziali 
LineWidth=2;
FontSize=12;


cutvertex = zeros(26,1);
cutvertex([2 3 5 7 11 13 18 19 23])=1;

tau =0.5;
gamma=1;
Gamma= ones(4,1);

[t,y]=ode45(@(t,y) LollipopCut_Vertex1(t,y,tau,gamma),[ 0 5], cutvertex);

esatto=zeros(35,1);
esatto([2 3 5 7 11 13 14 21 32 35])=1;
[t1,y1]=ode45(@(t1,y1) LollipopEsatto(t1,y1,tau,gamma),[ 0 5], esatto);

G= [ 0 1 1 0 ; 1 0 1 0 ; 1 1 0 1; 0 0 1 0 ];

coppie=zeros(8,1);
coppie([2 3 4 5 7 ])=1;
[t2,y2]=ode45(@(t2,y2) closePair(G,t2,y2,tau,[ 1 1 1 1 ] ),[0 5], coppie);


title('Nodo1');
hold on
Cut1=plot(t,y(:,1 ),'r');

E1=plot(t1,y1(:,1),'b');
Pair1= plot(t2,y2(:,1 ), 'black');
legend('con cut-vertex', 'senza cutvertex','chiuso alle coppie')


figure()
title('Nodo2');
hold on
Cut2=plot(t,y(:,3),'r');
E2=plot(t1,y1(:,3 ),'b');
Pair2= plot(t2,y2(:,3), 'black');
legend('con cut-vertex', 'senza cutvertex','chiuso alle coppie')

figure()
title('Nodo3');
hold on
Cut3=plot(t,y(:,5),'r');
E3=plot(t1,y1(:,5),'b');
Pair3= plot(t2,y2(:,5 ), 'black');
legend('con cut-vertex', 'senza cutvertex','chiuso alle coppie')

