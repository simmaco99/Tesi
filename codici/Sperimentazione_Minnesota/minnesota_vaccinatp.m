%vaccinazione minnesota

i=1;
tau=0.3;
gamma =0.1;
AbsTol = 1e-12;

load minnesota
G = Problem.A;
N= size(G,1);

CutPairE=zeros(2*N,1);
CutPairE(1:2:2*N)= 1;
CutPairE(2*i-1) = 0 ;
CutPairE(2*i) = 1;


CutPair10=zeros(2*N,1);
CutPair10(1:2:2*N)= 0.9;
CutPair10(2*i-1) = 0 ;
CutPair10(2*i) = 0.9;

CutPair05=zeros(2*N,1);
CutPair05(1:2:2*N)= 0.95;
CutPair05(2*i-1) = 0 ;
CutPair05(2*i) = 0.95;


CutPair20=zeros(2*N,1);
CutPair20(1:2:2*N)= 0.8;
CutPair20(2*i-1) = 0 ;
CutPair20(2*i) = 0.8;


AbsTol=1e-12;
Gamma= spdiags(gamma*ones(N,1),0,N,N);
opts2= odeset( 'AbsTol',AbsTol,'RelTol', 1e-12,'Jacobian',@(t,y) JacobianoCoppie(G,t,y,tau,gamma));

[tE,yE]=ode15s(@(t,y)closePair(G,t,y,tau,Gamma), [0 160],CutPairE,opts2);
[t10,y10]=ode15s(@(t,y)closePair(G,t,y,tau,Gamma), [0 160],CutPair10,opts2);
[t05,y05]=ode15s(@(t,y)closePair(G,t,y,tau,Gamma), [0 160],CutPair05,opts2);
[t20,y20]=ode15s(@(t,y)closePair(G,t,y,tau,Gamma), [0 160],CutPair20,opts2);

IE = yE(:,2:2:2*N) ;
IE= sum(IE,2)/N;

I10 = y10(:,2:2:2*N) ;
I10= sum(I10,2)/N;

I05 = y05(:,2:2:2*N) ;
I05= sum(I05,2)/N;

I20 = y20(:,2:2:2*N) ;
I20= sum(I20,2)/N;


plot(tE,IE,t05,I05,t10,I10,t20,I20,'LineWidth',2)
legend('0%','5%','10%','20%','FontSize',14)