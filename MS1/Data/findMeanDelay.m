function [ meanDelay] = findMeanDelay( interval , nInterval , x , i)

    sdelay = 0;
    n = 1;
    while( n < nInterval)
        bg = interval( 1 , n);
        ed = interval( 2 , n);
        time = x(1:(ed-bg+1) , 1);
        s = x(bg:ed, 2);
        r = x(bg:ed, i);
        S = fft(s);
        R = fft(r);
        C = R .* conj(S);
        c = ifft(C);
        [max_value, index] = max(c(:));
        sdelay = sdelay + time(index);
        n = n+1;
    end
        meanDelay = sdelay/n;

end

