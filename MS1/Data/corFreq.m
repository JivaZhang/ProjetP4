function [ c ] = corFreq( r , s )

        S = fft(s);
        R = fft(r);
        C = R .* conj(S);
        c = ifft(C);

end

