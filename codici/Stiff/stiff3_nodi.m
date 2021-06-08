% Verifichiamo come le condizioni modificano il fatto che le equazioni per
% o-o-o sono o meno stiff

G= [ 0 1 0 ; 1 0 1 ; 0 1 0] ;
X= [ 0 ; 1 ; 1] ;
Y =[ 1 ; 0 ; 0 ];

XY=[ 0 0 0 1 0 0 1 0 0 ]';
XX=[ 0 0 0 0 0 1 0 0 0 ]';
syms tau gama real
JP=JacobianoCoppie(G,X,Y,tau,gama);
JT=JacobianoTriple(G,X,Y,XY,XX,tau,gama);


EP= eig(JP);
EP=unique(EP(EP~=0));


lun=50;
T = linspace(0.1,1,lun);
GA= linspace(0.1,1,lun);

% AP=zeros(lun,lun);
% for i=1:lun
%     disp(i)
%      v= subs(EP,tau,T(i));
%     for j=1:lun
%  v= subs(v,  gama, GA(j));
%  v=abs(v);
%  AP(i,j) = max(v)/min(v);
%     end
% end


ET= eig(JT);
ET= unique(ET(ET~=0));
AT=zeros(lun,lun);

for i=1:lun
    disp(i)
     v= subs(ET,tau,T(i));
    for j=1:lun
 v= subs(v,  gama, GA(j));
 v=abs(v);
 AT(i,j) = max(v)/min(v);
    end
end


[T,GA]=meshgrid(T,GA);
surf(T,GA,AT);


%
% ET=subs(ET,tau,T);
% ET=subs(ET,gama,G);

