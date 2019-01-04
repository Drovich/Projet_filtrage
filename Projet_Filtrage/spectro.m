function [] = spectro(y,window,noverlap,nfft,fech)

M=length(y);
t = (1:1:M)/fech;


%% Repr�sentation temporelle et temps fr�quence

figure 
subplot(2,1,1)
plot(t,y);
xlabel('Temps (s)');
ylabel('y(t)');
title('Repr�sentation temporelle de y(t) (bruit blanc)');
subplot(2,1,2)
spectrogram(y,32,8,256,fech,'yaxis');