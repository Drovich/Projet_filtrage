function [] = plot_regularite(alpha,beta,lF,ltF)
xminimDMA = alpha*ltF + beta;
plot(ltF,lF);
xlabel('log(N)');
ylabel('log(F(N))');
title('Repr�sentation de la puissance du r�sidu dans la plan log(N)/log(F(N))');
hold on
plot(ltF,(xminimDMA));
hold off
