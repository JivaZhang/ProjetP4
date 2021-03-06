function [ meanDelay] = findMeanDelay( interval , nInterval , x , i )

sdelay = 0;
n = 1;
Sr = 1/(x(2,1) - x(1,1));
while( n < nInterval)
    bg = interval( 1 , n);
    ed = interval( 2 , n);
    time = x(1:(ed-bg+1) , 1);
    s = x(bg:ed, 2);
    r = x(bg:ed, i);
    c = corFreq(r , s);
    [max_value, index] = max(c(:));
    sdelay = sdelay + time(index);
    n = n+1;

end
meanDelay = sdelay/n;

end

