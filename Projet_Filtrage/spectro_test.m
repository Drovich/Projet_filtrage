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

% y=cell2mat(EGG.dataEEG(1,2,4))';
y=randn(1,1000);
N=64;
M=length(y);
t = (1:1:M)/fech;
yinit=zeros(1,M);
L = floor(M/N);

%% Représentation temporelle et temps fréquence
% 
% figure 
% subplot(2,1,1)
% plot(t,y);
% xlabel('Temps (s)');
% ylabel('y(t)');
% title('Représentation temporelle de y(t) (bruit blanc)');
% subplot(2,1,2)
% spectrogram(y,32,8,256,fech,'yaxis');
window = 32;
noverlap = 8;
nfft = 256;

spectro(y,window,noverlap,nfft,fech);

