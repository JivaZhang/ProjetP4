x = load('P1_cal.tsv');

t = x(:,1);
n = 1;

while(t(n) < 0.9e-7) 
    n = n+1;
end

t = t(1:n);
s = x(1:n , 2);
r = x(1:n, 4);

plot(t , r , t , s);

S = fft(s);
R = fft(r);

C = R .* conj(S);

c = ifft(C);

plot(t , c);