function [NewWaves] = myfilter(Waves , lowF , highF ,fs)
 NFFT = length(Waves(:,1));
 Frange = fs*(-NFFT/2:NFFT/2-1)/NFFT;
 Filter = (lowF<abs(Frange)).* (highF>abs(Frange));
 
 Sig1 = fftshift(fft(Waves(:,1))).*Filter';
 Sig2 = fftshift(fft(Waves(:,2))).*Filter';
 Sig3 = fftshift(fft(Waves(:,3))).*Filter';
 Sig4 = fftshift(fft(Waves(:,4))).*Filter';
 
 NewWaves = Waves;
 
 NewWaves(:,1) = ifft(fftshift(Sig1));
 NewWaves(:,2) = ifft(fftshift(Sig2));
 NewWaves(:,3) = ifft(fftshift(Sig3));
 NewWaves(:,4) = ifft(fftshift(Sig4));
 

end