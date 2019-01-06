function [J,alpha,beta,yinit,yinit_filt,lF,ltF] = DMA_function(y,N_tab)

% Initialisation
M=length(y);
yinit=zeros(1,M);

% Repr�sentation temporelle et temps fr�quence

% Extraction du profil

for m = 1:M
    yinit(1,m) = sum(y(1,1:m) - mean(y));
end

% D�composition du profil en L segment de taille N
F=zeros(1,length(N_tab));

for k=1:length(N_tab)
    N=N_tab(k);
    % Utilisation de la m�thode des moindres carr�s pour minimiser le crit�re Jdfa
    % on applique cette m�thode �  chaque valeur de l appartenant �  [1,L]
    % on se retrouve alors avec un tableau contenant le couple de minimum
    L=floor(M/N);
    b=ones(1,N)/N;
    yinit_filt = conv(b,yinit);
    yinit_filt = yinit_filt(floor(N/2)+1:length(yinit_filt)-round(N/2)+1);
    
    J = (yinit - yinit_filt ).^2 ;
    % On calcule le r�sidu
    F(1,k)=sum(J);
    F(1,k)=(1/(N*L)*F(1,k)).^0.5;
    
end
tF=(1:length(F));
ltF=log10(tF);
lF=log10(F);

[alpha beta] = moindre_carre(lF,ltF);