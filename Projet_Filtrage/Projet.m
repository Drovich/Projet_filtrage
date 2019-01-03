clear all;
close all;
clc;

%% PARTIE 1


EGG= load('dataEEG.mat');

%% Constante
Mb=2048;
Nb=64;
fech=1*10^3;
Lb = floor(Mb/Nb);


%% Initialisation

b=randn(1,Mb);
binit=zeros(1,Mb);

y=cell2mat(EGG.dataEEG(1,1,1))';
for i=1:5
%     y=randn(1,1000);
    y=cell2mat(EGG.dataEEG(1,2,i))';

    % t=[1:1000];
    % y=[1:1000]+10+0.1*randn(1,1000);
    % [alpha beta] = moindre_carre(y,t)
    [J,alpha_dfa(i),beta_dfa,yinit,Al,lF_dfa] = DFA_function(y);
    % 
    [JDMA,alpha_dma(i),beta_dma,yinit,yinit_dma,lF_dma,ltF] = DMA_functionv2(y);
%     i

% % [JDMA,alphaDMA,betaDMA,yinitDFA,yinitDMA] = DMA_functionv2(y,Al);

end
for i=6:10
%     y=randn(1,1000);
    y=cell2mat(EGG.dataEEG(1,1,i-5))';

    % t=[1:1000];
    % y=[1:1000]+10+0.1*randn(1,1000);
    % [alpha beta] = moindre_carre(y,t)
    [J,alpha_dfa(i),beta_dfa,yinit,Al,lF_dfa] = DFA_function(y);
    % 
    [JDMA,alpha_dma(i),beta_dma,yinit,yinit_dma,lF_dma,ltF] = DMA_functionv2(y);
%     i

% % [JDMA,alphaDMA,betaDMA,yinitDFA,yinitDMA] = DMA_functionv2(y,Al);

end
alphaDFA=mean(alpha_dfa);
betaDFA=mean(beta_dfa);
xminimDFA= alphaDFA*ltF + betaDFA;

alphaDMA=mean(alpha_dma);
betaDMA=mean(beta_dma);
xminimDMA = alphaDMA*ltF + betaDMA;

figure
plot(yinit);
hold on
plot(yinit_dma);

hold off
% figure
% plot(yinittb);
% hold on
% plot(yinit);
% plot(yinitt);
% hold off

figure
plot(ltF,lF_dfa);
xlabel('log(N)');
ylabel('log(F_{dma}(N))');
title('Représentation de la puissance du résidu dans la plan log(N)/log(F(N))');
hold on
plot(ltF,(xminimDFA));
hold off

figure
plot(ltF,lF_dma);
xlabel('log(N)');
ylabel('log(F_{dfa}(N))');
title('Représentation de la puissance du résidu dans la plan log(N)/log(F(N))');
hold on
plot(ltF,(xminimDMA));


