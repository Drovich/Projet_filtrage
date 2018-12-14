function [J,alpha,beta,yinit,yinitt] = DMA_function(y)
%% PARTIE 1

%% Constante
Mb=2048;
Nb=64;
fech=1*10^3;
Lb = floor(Mb/Nb);


%% Initialisation
N=64;
M=length(y);
t = (1:1:M)/fech;
yinit=zeros(1,M);
L = floor(M/N);

%% Représentation temporelle et temps fréquence


%% Extraction du profil

for m = 1:M
    yinit(1,m) = sum(y(1,1:m) - mean(y));
end

% [JDFA,alphaDFA,betaDFA,yinitDFA,AlDFA] = DFA_function(y);

N=200;
L=floor(M/N);
temp=zeros(1,N);
Al=zeros(2,L);
n=[1:N];
Sigma=zeros(2,1);
J = zeros(1,L);
x = zeros(N,L);


   

%% Décomposition du profil en L segment de taille N
NB = M/4;
% F=zeros(1,floor(NB));
% FDFA=zeros(1,floor(NB));
N_tab=[11 13 17 21 27 35 47 59 77 101];
F=zeros(1,length(N_tab));
FDFA=zeros(1,length(N_tab));
for k=1:length(N_tab)
    N=N_tab(k);
%     N=k+2;
    %% Utilisation de la méthode des moindres carrés pour minimiser le critère Jdfa
    % on applique cette méthode à chaque valeur de l appartenant à [1,L]
    % on se retrouve alors avec un tableau contenant le couple de minimum
    %(a1,l ; a0,l)
    
    L=floor(M/N);
    Al=zeros(2,L);
    n=[1:N];
    J = zeros(1,L);
    JDFA = zeros(1,L);

    x = zeros(N,L);
    
    b=ones(1,N)/N;
    a=1;
    
    yinittest = filter(b,a,yinit);
    yinittb = conv(b,yinit);
    [gd,w] = grpdelay(b,a);
    yinitt = yinittb(floor(gd)+1:length(yinittb)-floor(gd)+1);
%     yinittest = yinittb(floor(N/2)+1:length(yinittb)-floor(N/2)+1);
    % On résout l'équation matricielle MSAl = Sigma, en inversant la matrice
    % MS, on obtient Al qui contient al,0 et al,1
    X=[];
    for l = 1:L
        nbeta=n+N*(l-1);
        yinitl = yinit(1,(l-1)*N+1:l*N);

        [Al(1,l) Al(2,l)] = moindre_carre(yinitl,nbeta);
        
        x(:,l) = (Al(1,l)*nbeta.' + Al(2,l));
        %% tendance locale que l'on soustrait au profil filtrer pour trouver le résidu
        JDFA(1,l) = sum( (yinitl - x(:,l).').^2 );
        X = [X x(:,l).'];
    end
    J(1,l) = sum( (yinitt(1:length(X)) - X).^2 );
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
% 
% figure
% plot(yinitt);
% hold on
% plot(yinit);
% plot(yinittest);
% 
% hold off
% % figure
% % plot(yinittb);
% % hold on
% % plot(yinit);
% % plot(yinitt);
% % hold off
% 
% figure
% plot(ltF,lF);
% xlabel('log(N)');
% ylabel('log(F(N))');
% title('Représentation de la puissance du résidu dans la plan log(N)/log(F(N))');
% hold on
% plot(ltF,(xminim));


