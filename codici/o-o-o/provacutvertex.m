%Confronto tra il modello esatto e il modello asuumendo la chiusura con i cut-verzioni iniziali 1 infetto gli altri sani  sptto ipotesi di indipenenza
%statica delle condizioni inziali 
clear;clc;close;
AbsTol=1e-9;
opts= odeset( 'AbsTol',AbsTol,'RelTol', 1e-7);

tau =0.3;
gamma=0.1;
LineWidth=2;
FontSize=12;
esatto= zeros(13,1);
esatto([2 3 5 8 13])=1;
cut=zeros(12,1);
cut([2 3 5 8 12])=1;


[t,y]=ode45(@(t1,y1) sir3nodi(t1,y1,tau,gamma),[0 60], esatto,opts);
[t,yc]=ode45(@(t,y)  sir3nodi_cutvertex(t,y,tau,gamma),t, cut,opts);

figure()
subplot(1,3,1);
plot(t,y(:,1),t,y(:,2 ),t,1-y(:,1)-y(:,2),'LineWidth',2);
legend({'Suscettibili', 'Infetti','Rimossi'},'FontSize',14);
xlabel('T')
title('Nodo 1');
subplot(1,3,2);
plot(t,y(:,3),t,y(:,4 ),t,1-y(:,3)-y(:,4),'LineWidth',2);
legend({'Suscettibili', 'Infetti','Rimossi'},'FontSize',14);
xlabel('T')
title('Nodo 2');
subplot(1,3,3);
plot(t,y(:,5),t,y(:,6 ),t,1-y(:,5)-y(:,6),'LineWidth',2);
legend({'Suscettibili', 'Infetti','Rimossi'},'FontSize',14);
xlabel('T')
title('Nodo 3');
sgtitle('Modello completo') 

figure()
subplot(1,3,1);
plot(t,yc(:,1),t,yc(:,2 ),t,1-yc(:,1)-yc(:,2),'LineWidth',2);
legend({'Suscettibili', 'Infetti','Rimossi'},'FontSize',14);
xlabel('T')
title('Nodo 1');
subplot(1,3,2);
plot(t,yc(:,3),t,yc(:,4 ),t,1-yc(:,3)-yc(:,4),'LineWidth',2);
legend({'Suscettibili', 'Infetti','Rimossi'},'FontSize',14);
xlabel('T')
title('Nodo 2');
subplot(1,3,3);
plot(t,yc(:,5),t,yc(:,6 ),t,1-yc(:,5)-yc(:,6),'LineWidth',2);
legend({'Suscettibili', 'Infetti','Rimossi'},'FontSize',14);
xlabel('T')
title('Nodo 3');
sgtitle('Modello con cut-vertex') 


err=abs(y(:,1:6)-yc(:,1:6));
figure()
subplot(1,3,1);
plot(t,err(:,1),t,err(:,2),'LineWidth',2);
legend({'Suscettibili','Infetti'},'FontSize',14);
xlabel('T');
ylabel('Errore assoluto');
title('Nodo 1')
subplot(1,3,2);
plot(t,err(:,3),t,err(:,4),'LineWidth',2);
legend({'Suscettibili','Infetti'},'FontSize',14);
xlabel('T');
ylabel('Errore assoluto');
title('Nodo 2')
subplot(1,3,3);
plot(t,err(:,5),t,err(:,6),'LineWidth',2);
legend({'Suscettibili','Infetti'},'FontSize',14);
xlabel('T');
ylabel('Errore assoluto');
title('Nodo 3')