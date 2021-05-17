%% Individuazione dei vertici di taglio

clear; clc; close all;

% Grafo dell'esempio in Figura 2.4
G = graph();
G = G.addedge(1,2);
G = G.addedge(2,3);
G = G.addedge(3,1);
G = G.addedge(3,4);
G = G.addedge(4,5);
G = G.addedge(5,6);
G = G.addedge(6,3);
G = G.addedge(6,4);
G = G.addedge(6,7);
G = G.addedge(7,8);
G = G.addedge(8,9);
G = G.addedge(9,6);
G = G.addedge(9,10);
G = G.addedge(10,11);
G = G.addedge(11,9);
G = G.addedge(5,12);
G = G.addedge(5,13);
G = G.addedge(13,14);
G = G.addedge(14,15);
G = G.addedge(15,16);
G = G.addedge(16,13);
G = G.addedge(13,15);
G = G.addedge(14,16);

% Posizioni per avere il grafo come nella figura
XData = [0.5, 1.5, 1, 2, 2, 1, 0, 0, 1, 0.5, 1.5, 2, 3, 4, 4, 3];
YData = [0, 0, -1, -1, -2, -2, -2, -3, -3, -4, -4, -3, -2, -2, -3, -3];

% Il grafo:
figure(1)
subplot(3,3,[8:9])
plot(G,'XData',XData,'YData',YData);

% Individuazione dei Cut-Vertex
bincell = biconncomp(G, 'OutputForm', 'cell');
n = length(bincell);
for ii = 1:n
    subplot(3,3,ii)
    plot(subgraph(G, bincell{ii}), 'NodeLabel', bincell{ii});
end
