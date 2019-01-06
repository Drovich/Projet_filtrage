function [J,alpha,beta,yinit,Al,lF,ltF] = DFA_function(y,N_tab)

%% Initialisation
M=length(y);
yinit=zeros(1,M);

%% Repr�sentation temporelle et temps fr�quence

%% Extraction du profil

for m = 1:M
    yinit(1,m) = sum(y(1,1:m) - mean(y));
end

<<<<<<< HEAD
% D�composition du profil en L segment de taille N
=======
%% D�composition du profil en L segment de taille N
% Nb=floor(M/4);
N_tab=[11 13 17 21 27 35 47 59 77 101];
>>>>>>> parent of d4389e3... Spectrogram et double commentaire
F=zeros(1,length(N_tab));

for k=1:length(N_tab)
    N=N_tab(k);
<<<<<<< HEAD
    % Utilisation de la m�thode des moindres carr�s pour minimiser le crit�re Jdfa
    % on applique cette m�thode � chaque valeur de l appartenant � [1,L]
=======
%     N=k+2;
    %% Utilisation de la m�thode des moindres carr�s pour minimiser le crit�re Jdfa
    % on applique cette m�thode à chaque valeur de l appartenant � [1,L]
>>>>>>> parent of d4389e3... Spectrogram et double commentaire
    % on se retrouve alors avec un tableau contenant le couple de minimum
    L=floor(M/N);
    Al=zeros(2,L);
    n=[1:N];
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

end

