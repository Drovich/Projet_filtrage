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

y=cell2mat(EGG.dataEEG(1,2,4))';
% y=randn(1,1000);
N=64;
M=length(y);
t = (1:1:M)/fech;
yinit=zeros(1,M);
L = floor(M/N);

%% Repr�sentation temporelle et temps fr�quence

figure 
subplot(2,1,1)
plot(t,y);
xlabel('Temps (s)');
ylabel('y(t)');
title('Repr�sentation temporelle de y(t) (bruit blanc)');
subplot(2,1,2)
spectrogram(y,2,0,512,fech,'yaxis');
% [s,f,t,p] = spectrogram(y,2048,64,128,Fs);
% plot(t,f);
% xlim[0 : 
% xlabel('Temps (s)');
% ylabel('Fr�quence (Hz)');
% title('Repr�sentation temps fr�quence de y (bruit blanc)');
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
%     % On r�sout l'�quation matricielle MS*Al = Sigma, en inversant la matrice
%     % MS, on obtient Al qui contient al,0 et al,1
     
figure 
plot(t,yinit);
xlabel('Temps (s)');
ylabel('yint(t)');
title('Repr�sentation temporelle du profil de y(t) yint(t)');
hold on
for l = 1:L
    nbeta=n+N*(l-1);
    
    yinitl = yinit(1,(l-1)*N+1:l*N);
    
    [Al(1,l) Al(2,l)] = moindre_carre(yinitl,nbeta);

    x(:,l) = (Al(1,l)*nbeta + Al(2,l));

    x(:,l) = (Al(1,l)*nbeta + Al(2,l));
    plot(nbeta/fech,x(:,l));
    xlabel('Temps (s)');
    ylabel('yinit(t)');
    title('Repr�sentation temporelle de yint(t) avec les tendances locales');
    plot([N*l N*l ]/fech,[-1.5 2.5]*10^-3,'r')
end


%% D�composition du profil en L segment de taille N
 F=zeros(1,floor(M/3));
for k=1:floor(M/3)
    N=k+2;
    %% Utilisation de la m�thode des moindres carr�s pour minimiser le critère Jdfa
    % on applique cette m�thode à chaque valeur de l appartenant à [1,L]
    % on se retrouve alors avec un tableau contenant le couple de minimum
    %(a1,l ; a0,l)
    
    L=floor(M/N);
    temp=zeros(1,N);
    Al=zeros(2,L);
    n=[1:N];
    Sigma=zeros(2,1);
    J = zeros(1,L);
    x = zeros(N,L);
   
    % On r�sout l'�quation matricielle MSAl = Sigma, en inversant la matrice
    % MS, on obtient Al qui contient al,0 et al,1
    for l = 1:L
        nbeta=n+N*(l-1);
        yinitl = yinit(1,(l-1)*N+1:l*N);

        [Al(1,l) Al(2,l)] = moindre_carre(yinitl,nbeta);

        x(:,l) = (Al(1,l)*nbeta + Al(2,l));
        %% tendance locale que l'on soustrait au profil pour trouver le r�sidu
        J(1,l) = sum( (yinitl -x(:,l).').^2 );

    end 
    %% On calcule le r�sidu
    F(1,k)=sum(J(1,:));
    F(1,k)=(1/(N*L)*F(1,k)).^0.5;

end
tF=(1:length(F));
ltF=log10(tF);
lF=log10(F);

[alpha beta] = moindre_carre(lF,ltF);

xminim = alpha*ltF + beta;


figure
plot(ltF,lF);
xlabel('log(N)');
ylabel('log(F(N))');
title('Repr�sentation de la puissance du r�sidu dans le plan log(F(N)) log(N)');
hold on
plot(ltF,(xminim));


