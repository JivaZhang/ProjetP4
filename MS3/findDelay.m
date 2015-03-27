function [timeDiff] = findDelay(s,r,Fs)
%permet de calculer le delay entre s et r. si s est en avance sur r, alors
%timeDiff est positif, sinon il est negatif.
        [acor,lag] = xcorr(r,s);
        [~,I] = max(abs(acor));
        lagDiff = lag(I);
        timeDiff = lagDiff/Fs;
end