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

% y=cell2mat(EGG.dataEEG(1,1,1))';
for i=1:10
    y=randn(1,1000);

    % t=[1:1000];
    % y=[1:1000]+10+0.1*randn(1,1000);
    % [alpha beta] = moindre_carre(y,t)
    [J,alpha(i),beta,yinit,Al] = DFA_function(y);
    % 
    [JDMA,alphaDMA(i),betaDMA,yinitDFA,yinitDMA] = DMA_function(y);
    i
% 
% % [JDMA,alphaDMA,betaDMA,yinitDFA,yinitDMA] = DMA_functionv2(y,Al);
% 
% 
end
alphaF=mean(alpha);
alphaDMAF=mean(alphaDMA);

