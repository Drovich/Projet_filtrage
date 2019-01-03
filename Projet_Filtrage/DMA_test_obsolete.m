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
% y=randn(1,1000);
N=64;
M=length(y);
t = (1:1:M)/fech;
yinit=zeros(1,M);
L = floor(M/N);

%% Représentation temporelle et temps fréquence



figure
subplot(2,1,1)
plot(t,y);
xlabel('Temps (s)');
ylabel('y(t)');
title('Représentation temporelle de y(t) (bruit blanc)');
subplot(2,1,2)
spectrogram(y,2,0,512,fech,'yaxis');
% [s,f,t,p] = spectrogram(y,2048,64,128,Fs);
% plot(t,f);
% xlim[0 :
% xlabel('Temps (s)');
% ylabel('Fréquence (Hz)');
% title('Représentation temps fréquence de y (bruit blanc)');
%
%% Extraction du profil

for m = 1:M
    yinit(1,m) = sum(y(1,1:m) - mean(y));
end
N=200;
L=floor(M/N);
temp=zeros(1,N);
Al=zeros(2,L);
n=[1:N];
Sigma=zeros(2,1);
J = zeros(1,L);
x = zeros(N,L);

%     F=0;
% %     % On résout l'équation matricielle MS*Al = Sigma, en inversant la matrice
% %     % MS, on obtient Al qui contient al,0 et al,1
% %
% figure
% plot(t,yinit);
% xlabel('Temps (s)');
% ylabel('yint(t)');
% title('Représentation temporelle du profil de y(t) yint(t)');
% hold on
% for l = 1:L
%     nbeta=n+N*(l-1);
%     
%     yinitl = yinit(1,(l-1)*N+1:l*N);
%     
%     [Al(1,l) Al(2,l)] = moindre_carre(yinitl,nbeta);
%     
%     x(:,l) = (Al(1,l)*nbeta + Al(2,l));
%     
%     x(:,l) = (Al(1,l)*nbeta + Al(2,l));
%     plot(nbeta/fech,x(:,l));
%     xlabel('Temps (s)');
%     ylabel('yinit(t)');
%     title('Représentation temporelle de yint(t) avec les tendances locales');
%     plot([N*l N*l ]/fech,[-1.5 2.5]*10^-3,'r')
% end


%% Décomposition du profil en L segment de taille N
NB = M/4;
F=zeros(1,floor(NB));
FDFA=zeros(1,floor(NB));

for k=1:floor(NB)
    N=k+2;
    %% Utilisation de la méthode des moindres carrés pour minimiser le critÃ¨re Jdfa
    % on applique cette méthode Ã  chaque valeur de l appartenant Ã  [1,L]
    % on se retrouve alors avec un tableau contenant le couple de minimum
    %(a1,l ; a0,l)
    
    L=floor(M/N);
    temp=zeros(1,N);
    Al=zeros(2,L);
    n=[1:N];
    Sigma=zeros(2,1);
    J = zeros(1,L);
    JDFA = zeros(1,L);

    x = zeros(N,L);
    
    b=ones(1,N)/N;
    a=1;
    
    yinittest = filter(b,a,yinit);
    yinittb = conv(b,yinit);
    yinitt = yinittb(floor((N)/2)+1:length(yinittb)-floor((N)/2)+1);
%     yinitt = yinittest;
    % On résout l'équation matricielle MSAl = Sigma, en inversant la matrice
    % MS, on obtient Al qui contient al,0 et al,1
    for l = 1:L
        nbeta=n+N*(l-1);
        yinitl = yinit(1,(l-1)*N+1:l*N);
        
        
        [Al(1,l) Al(2,l)] = moindre_carre(yinitl,nbeta);
        
        x(:,l) = (Al(1,l)*nbeta.' + Al(2,l));
        
        yinittl = yinitt(1,(l-1)*N+1:l*N);
        %% tendance locale que l'on soustrait au profil filtrer pour trouver le résidu
        J(1,l) = sum( (yinittl - x(:,l).').^2 );
        JDFA(1,l) = sum( (yinitl - x(:,l).').^2 );

    end
    FDFA(1,k)=sum(JDFA(1,:));
    FDFA(1,k)=(1/(N*L)*FDFA(1,k)).^0.5;

    
    %% On calcule le résidu
    F(1,k)=sum(J(1,:));
    F(1,k)=(1/(N*L)*F(1,k)).^0.5;
    
end
tF=(1:length(F));
ltF=log10(tF);
lF=log10(F);

tFDFA=(1:length(FDFA));
ltFDFA=log10(tFDFA);
lFDFA=log10(FDFA);

[alpha beta] = moindre_carre(lF,ltF);
[alphaDFA betaDFA] = moindre_carre(lFDFA,ltFDFA);

xminim = alpha*ltF + beta;
xminimDFA = alphaDFA*ltF + betaDFA;

figure
plot(yinitt);
hold on
plot(yinit);
plot(yinittest);

hold off
% figure
% plot(yinittb);
% hold on
% plot(yinit);
% plot(yinitt);
% hold off

figure
plot(ltF,lF);
xlabel('log(N)');
ylabel('log(F(N))');
title('Représentation de la puissance du résidu dans la plan log(N)/log(F(N))');
hold on
plot(ltF,(xminim));
plot(ltF,(xminimDFA));
hold off


