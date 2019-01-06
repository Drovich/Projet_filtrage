function [] = plot_tendance(yinit,N,t,fech)
M=length(yinit);
L=floor(M/N);
Al=zeros(2,L);
n=[1:N];
x = zeros(N,L);

plot(t,yinit);
xlabel('Temps (s)');
ylabel('yint(t)');
title('Représentation temporelle du profil de y(t) yint(t)');
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
    title('Représentation temporelle de yint(t) avec les tendances locales');
    plot([N*l N*l ]/fech,[min(yinit)-0.1*max(abs(yinit)) max(yinit)+0.1*max(abs(yinit))],'r')
end
hold off
end