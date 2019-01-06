function [J,alpha,beta,yinit,yinit_filt,lF,ltF] = DMA_function(y,N_tab)

%% Initialisation
M=length(y);
yinit=zeros(1,M);

%% Représentation temporelle et temps fréquence
%
%% Extraction du profil

for m = 1:M
    yinit(1,m) = sum(y(1,1:m) - mean(y));
end

<<<<<<< HEAD
% Décomposition du profil en L segment de taille N
=======
%% Décomposition du profil en L segment de taille N
% Nb=floor(M/4);
N_tab=[11 13 17 21 27 35 47 59 77 101];
>>>>>>> parent of d4389e3... Spectrogram et double commentaire
F=zeros(1,length(N_tab));

for k=1:length(N_tab)
    N=N_tab(k);
<<<<<<< HEAD
    % Utilisation de la méthode des moindres carrés pour minimiser le critère Jdfa
    % on applique cette méthode à  chaque valeur de l appartenant à  [1,L]
=======
%     N=k+2;
    %% Utilisation de la méthode des moindres carrés pour minimiser le critÃ¨re Jdfa
    % on applique cette méthode Ã  chaque valeur de l appartenant Ã  [1,L]
>>>>>>> parent of d4389e3... Spectrogram et double commentaire
    % on se retrouve alors avec un tableau contenant le couple de minimum
    L=floor(M/N);
    b=ones(1,N)/N;
    yinit_filt = conv(b,yinit);
    yinit_filt = yinit_filt(floor(N/2)+1:length(yinit_filt)-round(N/2)+1);
    
<<<<<<< HEAD
    J = (yinit - yinit_filt ).^2 ;
    % On calcule le résidu
=======
    %% On calcule le résidu
>>>>>>> parent of d4389e3... Spectrogram et double commentaire
    F(1,k)=sum(J);
    F(1,k)=(1/(N*L)*F(1,k)).^0.5;
    
end
tF=(1:length(F));
ltF=log10(tF);
lF=log10(F);

[alpha beta] = moindre_carre(lF,ltF);

