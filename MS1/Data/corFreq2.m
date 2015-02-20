
function [ c ] = corFreq2( r , s , s2 )
        S2 = fft(s2);
        %S2 = (S2~=0);
        S = fft(s).*S2;
        R = fft(r) .*S2;
        C = R .* conj(S);
        c = ifft(C);

end

