function [Sig2] = delaySig( sig , delay , fs)

Sig = fft(sig);
NFFT = length(Sig);
Frange = fs*(-NFFT/2:NFFT/2-1)/NFFT;
Sigshift = fftshift(Sig);
angles = fftshift(angle(Sigshift) + (Frange*delay*2*pi));
Sig2 = abs(Sig).*exp(i*(angles));


end

