function [ t, y ] = eulero_implicito2( f,df,  tspan, y0, dt,AbsTol,RelTol,itmax)

% la funzione calcola la soluzione dell'ode y'= f(t,y) in tspan con y(t0) = y0
% usando il metodo di eulero implicito con il metodo di Newton 
% INPUT
%         f       handle della funzione 
%         df      handle del jacobiano 
%         tspan   vettore  [ t0 tf]
%         y0      condizioni iniziali
%         dt      intervallo temporale 
%		  AbsTol  tolleranza assoluta 
%		  RelTol  tolleranza relativa 
%         itmax   numero di iterazione del metodo di Newton (di default a 50) 
%         
     
if nargin==7
    itmax = 50 ; % numero d'iteraziono d
end

t0 =tspan(1);
tf= tspan(end);
n = floor ((tf - t0 ) /dt );  %lunghezza del vettore dei tempi 
m= length( y0) ;  %lunghezza vettore delle soluzioni
t= zeros(n,1) ;
y = zeros( m,n) ;

t(1) = t0;
x= y0 ;
y(:,1) = y0;
disp n
for i = 1: n
    t(i+1) = t(i) + dt;
    x0=x;
    for j = 1: itmax  % Metodo di Newton
        if ( norm(f(t(i+1),x))< AbsTol)
            break
        end
        xn = x - ( dt * df(t(i+1), x) -speye( m))\ (y(:,i) - x + dt * f( t(i+1),x));
        if (norm(xn-x) /norm(x0)<RelTol)
            break
        else
            x=xn;
        end
    end
    
    y(:,i+1) = x ;
end
y=y';
end

    
