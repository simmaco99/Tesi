function f = sir(t,y,alpha, beta)
f=zeros(2,1);
f(1)=-beta*y(1)*y(2);
f(2)=beta*y(1)*y(2)- alpha*y(2);
end
