%script per realizzare i grafici della peste di Plague

%dati reali
S=[ 235;201;153.5;121;108;97;83];
I=[14.5;22;29;20;8;8;0];
;
[SS,II,Ri,t]=sir2_semplice(261,254,7,0.0178,2.73,linspace(0,5,1000));

hold on;
R=plot(S,I,'*');
S=plot(SS,II);
legend([R,S], 'Realt\`a', 'Sperimentazione','Interpreter','latex');
xlabel('S');
ylabel('I')
matlab2tikz('SI.tex');

close all;

figure()
hold on;
Sa=plot(t,SS,'--');
In=plot(t,II,'-.');
Rim=plot(t,Ri)
legend([Sa, In, Rim], 'Sani','Infetti','Rimossi');
xlabel('t');
matlab2tikz('SIR_Grafico.tex');