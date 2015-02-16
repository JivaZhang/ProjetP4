x = load('P6_cal.tsv');
Tx = [336.1 15];
Rx1 = [160.2 -416];
Rx2 = [340 -416];
Rx3 = [66.4 543.4];

n1 = norm(Rx1- Tx)
n2 = norm(Rx2 - Tx)
n3 = norm(Rx3 - Tx)
t = x(:,1);
n = 1;

while(t(n) < 0.9e-7) 
    n = n+1;
end

for i=3:5 
    t = t(1:n);
    s = x(1:n, 2);
    r = x(1:n, i);

    S = fft(s);
    R = fft(r);
    C = R .* conj(S);
    c = ifft(C);
    delay = t(find(c == max(c(:))))
end

plot(t , c);

