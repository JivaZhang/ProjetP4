function [sig2 newt bgIndex endIndex] = delaySig( sig , delayArg , fs, t)
% delay sig of delay. Fs is the sample frequency of sig. Si delay est
% positif alors le signal est décalé vers la droite, sinon vers la gauche.
% newt est la base de temps du signal 
% bgIndew et endIndex sont les indexs entre les quels les valeurs de temps
% sont prises dans le vecteur t. Cela permet de ne pas traiter un autre
% signal avec cette fonction mais de pouvoir le mettre sur le vecteur de
% temps newt

delay = -delayArg;
Sig = fft(sig);
NFFT = length(Sig); 
Frange = fs*(-NFFT/2:NFFT/2-1)/NFFT; % retrieving the frequency scale
Sigshift = fftshift(Sig);
angles = fftshift(angle(Sigshift) + (Frange'*(delay*2*pi))); %changing the phase of all frequency
Sig2 = abs(Sig).*exp(i*(angles)); % creating the new spectrum with phase angle and amplitude of abs(sig)
sig2 = ifft(Sig2);

B = t;

if delay>=0
    B = (t < (t(NFFT)-delay))
    plot(t , B);
    endIndex = find(B , 1 , 'last');
    bgIndex = 1;
    newt = t(bgIndex:endInde);
    sig2 = sig2.*B';
    sig2 = sig2(bgIndex:endIndex);
else
    B = (t > abs(delay));
    bgIndex = find(B , 1 , 'first');
    endIndex = length(t);
    newt = t(bgIndex:endIndex);
    sig2 = sig2.*B';
    sig2 = sig2(bgIndex:endIndex);
end

end


