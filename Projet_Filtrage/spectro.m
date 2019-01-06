function [] = spectro(y,window,noverlap,nfft,fech)

M=length(y);
t = (1:1:M)/fech;


%% Représentation temporelle et temps fréquence
figure (3)
subplot(2,1,1)
plot(t,y);
xlabel('Temps (s)');
ylabel('y(t)');
title('Représentation temporelle de y(t)');
subplot(2,1,2)
spectrogram(y,window,noverlap,nfft,fech,'yaxis');
end