function [ t, y ] = eulero_implicito2def( JP,f,df,  tspan, y0, dt,AbsTol, ...
                                       RelTol,itmax)

% la funzione calcola la soluzione dell'ode y'= f(t,y) in tspan con
% y(t0) = y0
% usando il metodo di eulero implicito con il metodo di Newton
% INPUT
%         f       handle della funzione
%         df      handle del jacobiano
%         tspan   vettore  [ t0 tf]
%         y0      condizioni iniziali
%         dt      inntervallo temporale
%         itmax   numero di iterazione del metodo di Newton (di
%         default a 50)
%

if nargin==8
    itmax = 50 ; % numero d'iteraziono d
end

t0 =tspan(1);
tf= tspan(end);
n = floor ((tf - t0 ) /dt );  %lunghezza del vettore dei tempi
m= length( y0) ;  %lunghezza vettore delle soluzioni
t= zeros(n,1) ;
y = zeros( m,2) ;
in = zeros(n,1);
t(1) = t0;
x= y0 ;
y(:,1) = y0;
a=1;
for i = 1: n
    t(i+1) = t(i) + dt;
    if (t(i+1)/1==floor(t(i+1)/1))
        ! echo "Eulero" |mail -s "1 unita temporali" dsimmaco@gmail.com
    end
    if (floor(i/2)==i/2)
        a=2;
    else
        a=1;
        
    x0=x;
    for j = 1: itmax  % Metodo di Newton
        if ( norm(f(t(i+1),x))< AbsTol)
            break
        end
               yp = y(:,a);
                xn = x - ( dt * df(t(i+1), x) -speye( m))\ (yp ...
                                                            - x + ...
                                                            dt * f( ...
                                                                t(i+1),x));
                if (norm(xn-x) /norm(x0)<RelTol)
                    break
                else
                    x=xn;
                end
    end
    if(a==1) 
        y(:,2) = x ;
    else
        y(:,1) = x;
    end
    ei= abs(eig(full(JP(x))));
    ei = ei(ei~=0);
    in(i) = max(ei)/min(ei);
end
y=y';
end
