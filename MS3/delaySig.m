function [sig2] = delaySig( sig , delay , fs)
% delay sig of delay. Fs is the sample frequency of sig
Sig = fft(sig);
NFFT = length(Sig); 
Frange = fs*(-NFFT/2:NFFT/2-1)/NFFT; % retrieving the frequency scale
Sigshift = fftshift(Sig);
angles = fftshift(angle(Sigshift) + (Frange'*delay*2*pi)); %changing the phase of all frequency
Sig2 = abs(Sig).*exp(i*(angles)); % creating the new spectrum with phase angle and amplitude of abs(sig)
sig2 = ifft(Sig2);
end


