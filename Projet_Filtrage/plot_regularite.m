function [] = plot_regularite(alpha,beta,lF,ltF)
xminimDMA = alpha*ltF + beta;
plot(ltF,lF);
xlabel('log(N)');
ylabel('log(F(N))');
title('Représentation de la puissance du résidu dans la plan log(N)/log(F(N))');
hold on
plot(ltF,(xminimDMA));
hold off
