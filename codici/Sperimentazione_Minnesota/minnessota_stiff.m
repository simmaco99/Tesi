% i conti sono stati divisi su 4 laboratori con lo scopo di diminuire i tempi di attesa
lab =1; %selezionare su quale laboratorio 
load minnesota
G = Problem.A;
len = 100;
vtau = linspace((lab-1)/4,lab/4,len);
vgamma = 0.1:0.2:0.7;
N = size(G,1);
% il nodo i infetti 
i=1;
CutPair=zeros(2*N,1);
CutPair(1:2:2*N)= 1;
CutPair(2*i-1) = 0 ;
CutPair(2*i) = 1;

%il 0.1 di ogni nodi e rimosso


l= zeros(len,4);



ls=l;
sp= ls;

AbsTol=1e-12;

for i = 1: len 
    for j = 1: 4
        tau= vtau(i);
        gamma = vgamma(j) ;
        Gamma= spdiags(gamma*ones(N,1),0,N,N);
        opts2= odeset( 'AbsTol',AbsTol,'RelTol', 1e-12,'Jacobian',@(t,y) JacobianoCoppie(G,t,y,tau,gamma));
        [t,~]=ode45(@(t,y)closePair(G,t,y,tau,Gamma), [0 120],CutPair,opts2);
        [ts,~]=ode15s(@(t,y)closePair(G,t,y,tau,Gamma), [0 30],CutPair,opts2);
        l(i,j) = length(t);
        ls(i,j) = length(ts);
        sp(i,j) =indice_stiff_coppie(G,CutPair,tau,gamma);
    end
end

