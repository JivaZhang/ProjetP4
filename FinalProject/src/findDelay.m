function [timeDiff] = findDelay(Emit,Recieved,Fs)
%permet de calculer le delay entre Emit et Recieved. si Emit est en avance sur Recieved, alors
%timeDiff est positif, sinon il est negatif.
        [acor,lag] = xcorr(Recieved,Emit);
        [~,I] = max(abs(acor));
        lagDiff = lag(I);
        timeDiff = lagDiff/Fs;
end