function [ timeDiff] = findDelay(r , s , Fs)

        [acor,lag] = xcorr(r , s );
        [~,I] = max(abs(acor));
        lagDiff = lag(I);
        timeDiff = lagDiff/Fs;
        
end

