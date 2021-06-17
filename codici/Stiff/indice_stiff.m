function [T,GA,AP,AT]=indice_stiff(G,lun)
% Data la matrice di adiacenza  e il passo di discretizzazione restituisce il grafico del rapporto tra
% autovalore di modulo massimo e autovalore di modulo minimo del jacobiano
% del sistema chiuso alle triple
%  T  : valori  di tau
%  GA : valori di gamma
%  AP : rapporto per modello chiuso alle coppie
%  AT : rapporto per modello chiuso alle triple
% Per creare le condizioni iniziali si usa il programma     CI_Stiff.cpp
% Per creare il Jacobiano per le triple si usa il programma Jacobiano.cpp
% La funzione funnziona se risulta installato il compilatore g++

!g++ Jacobiano.cpp -o Jacobiano 
!g++ CI_Stiff.cpp -o CI_Stiff
N=size(G,1);
fprintf("Inserisci il seguente numero: %d\n",N);
!./CI_Stiff
CI_Stiff
syms tau gama real
JP=JacobianoCoppie(G,S,I,tau,gama);
JT=JacobianoTriple(G,S,I,SI,SS,tau,gama);
EP= eig(JP);
EP=unique(EP(EP~=0));
T = linspace(0.1,1,lun);
GA= linspace(0.1,1,lun);

AP=zeros(lun,lun);
 fprintf("Calcolo per il modello chiuso alle coppie\n") %li ho aggiunti senno sembrava che il programma fosse bloccato
for i=1:lun
    fprintf("%d di %d\n", i, lun); %li ho aggiunti senno sembrava che il programma fosse bloccato
     v= subs(EP,tau,T(i));
    for j=1:lun
 v= subs(v,  gama, GA(j));
 v=abs(v);
 AP(i,j) = max(v)/min(v);
    end
end

ET= eig(JT);
ET= unique(ET(ET~=0));

fprintf("Calcolo per il modello chiuso alle triple\n") %li ho aggiunti senno sembrava che il programma fosse bloccato
AT=zeros(lun,lun);
for i=1:lun
    fprintf("%d di %d\n", i, lun); %li ho aggiunti senno sembrava che il programma fosse bloccato
    v= subs(ET,tau,T(i));
    for j=1:lun
        v= subs(v,  gama, GA(j));
        v=abs(v);
        AT(i,j) = max(v)/min(v);
    end
end

[T,GA]=meshgrid(T,GA);

subplot(1,2,1);
surf(T,GA,AP);
title('Chiuso alle coppie');
xlabel('\tau')
ylabel('\gamma')

subplot(1,2,2);
surf(T,GA,AT);
title('Chiuso alle triple');
xlabel('\tau')
ylabel('\gamma')

