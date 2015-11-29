function [ex] = extractEnv(sig , t , f0 , fs)
 % extrait l'enveloppe complexe de sig et se retrouve dans ex

 NFFT = length(sig); %nombre d'element dans le signal
 Frange = fs*(-NFFT/2:NFFT/2-1)/NFFT; %creation de l'echelle des frequences
 
 % creation du filtre de hilbert (je pense que c'est ça son petit nom)
 FilterA = (Frange >= 0)*2;
 
 % on trouver sig dans le domaine frequentielle pour lui appliquer le
 % filtre de hilbert (tjs pas sur de son petit nom)
 X = fftshift(fft(sig))';
 Xa = X .* FilterA;
 
 % on revient dans le domaine temporel et on lui applique un decalle dans
 % les frequence afin de ramener l'enveloppe autour de l'origine
 xa = ifft(fftshift(Xa));
 ex = (xa .* exp(-i*f0*2*pi*t))'; 

end