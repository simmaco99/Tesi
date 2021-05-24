tau =0.5;
gamma=1;
LineWidth=2;
FontSize=12;

esatto= zeros(13,1);
esatto([2 3 5 8 13])=1;
[t,y]=ode45(@(t,y) sir3nodi(t,y,.5,1),[ 0 5], esatto);


cut=zeros(12,1);
cut([2 3 5 8 12])=1;
[t1,y1]=ode45(@(t1,y1) sir3nodi_cutvertex(t1,y1,.5,1),[ 0 5], cut);


figure()
title('Nodo 1');
hold on;
S1=plot(t,y(:,1),'r-');
I1=plot(t,y(:,2), 'r-.');
SC1=plot(t1,y1(:,1),'b-');
IC1=plot(t1,y1(:,2), 'b-.');
legend('sani esatti', 'infetti sani', 'sani cut-vertex', 'infetti cut-vertex');


figure()
title('Nodo 2');
hold on;
S2=plot(t,y(:,3),'r-');
I2=plot(t,y(:,4), 'r-.');
SC2=plot(t1,y1(:,3),'b-');
IC2=plot(t1,y1(:,4), 'b-.');
legend('sani esatti', 'infetti sani', 'sani cut-vertex', 'infetti cut-vertex');


figure()
title('Nodo 3');
hold on;
S3=plot(t,y(:,5),'r-');
I3=plot(t,y(:,6), 'r-.');
SC3=plot(t1,y1(:,5),'b-');
IC3=plot(t1,y1(:,6), 'b-.');
legend('sani esatti', 'infetti sani', 'sani cut-vertex', 'infetti cut-vertex');



