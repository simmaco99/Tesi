lun=100;
tau = linspace(0.1,1,lun);
gamma= linspace(0.1,1,lun);
G= [ 0 1 0 ; 1 0 1 ; 0 1 0 ];
X= [ 0 1 1 ]' ; 
Y=[ 1 0 0 ]' ;

A=zeros(lun,lun);
for i = 1:lun
    for j=1:lun
        A(i,j) = stiff_Pair(G,X,Y, tau(i), gamma(j));
    end
end

[tau,gamma]=meshgrid(tau,gamma);
surf(tau,gamma,A);



