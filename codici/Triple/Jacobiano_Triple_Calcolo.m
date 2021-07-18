function J=JacobianoTriple_Calcolo(Js,variable,t,y) 
% J=JacobianoTriple_Calcolo(Js,variable,y)  calcola il jacobiano del modello chiuso alle triple
% [Js, variable] sono gli elementi restituiti da Jacobiano_ dato il jacoiano simbolico (creato con Jacobbiano_Triple_sym)
% t tempo (serve per la funzione ode)
% y punto in cui vogliamo calcolare il Jacobiano ( sani e infetti alternati 
%												   coppie S_i I_j esistenti ordinatre in modo lessicografico rispetto (i,j)
% 												   coppie S_i S_j esistenti ordinatre in modo lessicografico rispetto (i,j)
%												)
%
% viene creata una nuova funzione e non calcolato direttamente da Jacobiano_Triple_sym per fare in modo che il calcolo simbolico venga fatto una sola volta. Mentre la sostituzione variabili valori ogni volta

J=subs(Js,variable, y); 
end
