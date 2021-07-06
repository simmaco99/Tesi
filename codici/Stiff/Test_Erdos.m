% facendo variare tau e gamma mi domando se il grafico casuale di Erdos sia
% stiff nello condizioni inziali  1 sicuramente infetto e gli altri
% sicuramente sani.:Si fa variare la dimensione 
% In GN.tex         si ha il grafico dell'indice di stiff in funzione di tau
% In GN_Lenght.tex  si ha il grafico della differenza di intervalli
% temporali 45-15s in funzione di tai 
% Nei file GN.mat si trova:
%         G   matrice
%         sp  indice di stiff in funzione di tau
%         l   intervalli temporali per ode45
%         ls  intervalli temporali per ode15s
        
close all; clc
lunT= 100; %divisione di tau 
len=100; %volte da ripetere la misurazione temporale 

tau = linspace(0.1,1, lunT);
gamma = 0.1:0.1:1;
AbsTol=1e-12;
opts= odeset( 'AbsTol',AbsTol,'RelTol', 1e-12);
sp = zeros(lunT,10);
l = zeros(lunT,10);
ls=l;

S=zeros(len,6);
NS=S;
SS=S;


for N=10:10:60
    %carichiamo i dati precedentemente generati con random_graph
    filename=sprintf("G%d.mat",N);
    load(filename)
  
    Gamma= spdiags(gamma*ones(N,1),0,N,N);
    opts2= odeset( 'AbsTol',AbsTol,'RelTol', 1e-12,'Jacobian',@(t,y) JacobianoCoppie(G,t,y,tau,gamma));
    
    %Le condizioni iniziali sono state prese con 1 infetto gli altri sani 
    CutPair=zeros(2*N,1);
    CutPair(3:2:2*N) = 1; 
    CutPair(2)=1;
    for i = 1:lunT
         for j=1:10
            Gamma= spdiags(gamma(j)*ones(N,1),0,N,N);
            sp(i,j)=indice_stiff_singolo(G,y,tau(i),gamma(j));
            [t, ~]=ode45(@(t,y) closePair(G,t,y,tau(i), Gamma), [0 10], CutPair, opts);
            [ts, ~]=ode15s(@(t,y) closePair(G,t,y,tau(i), Gamma), [0 10], CutPair, opts);
            l(i,j) = length(t);
            ls(i,j)= length(ts);
         end
    end
    
    
   for i =1:9
        subplot(3,3,i);
        plot(tau,sp(:,i),'LineWidth',2);
        t= sprintf("\\gamma= %.2f ", gamma(i));
        title(t, 'FontSize',12);
        xlabel('\tau');
   end
   sgtitle('Indice di stiff al variare di \tau e \gamma') 
   filetex=sprintf('G%d.tex', N);
   matlab2tikz(filetex);

   ll = l - ls;
   for i =1:9
        subplot(3,3,i);
        plot(tau,ll(:,i),'LineWidth',2);
        t= sprintf("\\gamma= %.2f ", gamma(i));
        title(t, 'FontSize',12);
        xlabel('\tau')
   end
    sgtitle('Numero di intervalli temporali usando le due funzioni');
    filetex=sprintf('G%d_Lenght.tex', N);
    matlab2tikz(filetex)

   j= N/10;
   for i=1:len
        a=tic;  d=ode15s(@(t,y) closePair(G,t,y,tau ,Gamma), [0 10],CutPair,opts);      S(i,j)=toc(a);% ode15s senza Jacobiano
        a=tic;  d=ode45(@(t,y)  closePair(G,t,y,tau ,Gamma), [0 10],CutPair,opts);       NS(i,j)=toc(a);% ode 45
        a=tic;  d=ode15s(@(t,y) closePair(G,t,y,tau ,Gamma), [0 10],CutPair,opts2);     SS(i,j)=toc(a);%ode 15s con Jacobiano 
   end
   
   f=@(t,y) closePair(G,t,y,tau, Gamma);
   df=@(t,y) JacobianoCoppie( G,t,y,tau,gamma);
 
   dt = min(diff(t));
   [te,ye]=eulero_implicito(f,df, [0 10], CutPair, dt);
   m=length(te);
 
   for i = 1:m 
        s= ye(i,:)';
        in(i,j) = indice_stiff_singolo(G,s,tau,gamma);
   end
end
  
 
for i= 1: 6
    subplot(3,2,i) 
    semilogy(1:len, SS(:,i),1:len, NS(:,i))
    legend('ode15s', 'ode45')
    t=sprintf("N=%d", 10*i);
    title(t, 'FontSize',12);
    ylabel('t')
end
matlab2tikz('15svs45.tex')

for i=1:6
     subplot(3,2,i)
     semilogy(te, in(:,i))
      t=sprintf("N=%d", 10*i);
        title(t, 'FontSize',12);
        xlabel('t')
        ylabel('indice stiff')
 end
matlab2tikz('stiff_soluzioni.tex')

