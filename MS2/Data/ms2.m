%x = load('P2_cal.tsv');
close all;
load('Config0Try3')
fs = 20e9;
t = linspace(0 , 20000*1/fs , 20000);
l = length(t);
l = l/10;

t = t(1:l);
s = Waves(1:l,1)';
r = Waves(1:l,3)';
S = fft(s);
f = fs/2 * linspace( 0 , 1 , length(s));
filter = (f >= 0.7e9) .* ( f<=2e9);
r = real(ifft(fft(r).*filter));


delay = findDelay( r , s , fs);
sigdelay = real(ifft(delaySig(r , delay , fs)));

figure;
plot(t , r , t , sigdelay);
legend( 'r' , 'sigdelay');
A = findA( t , s , sigdelay);
%A = 1500;

sr = s- A*sigdelay;
figure;
plot( t , s ,  t  , A*sigdelay , t  , s - A*sigdelay );
legend('s ' ,  'A*sigdelay' , 's-A*sigdelay' );

figure;
plot(t , s-A*sigdelay);
legend('repliques');

Av = linspace(-1000, 1000 , 1000);
in = Av ;

for i = 1:1000
    in(i) = trapz( t , (s-Av(i)*sigdelay).^2);
end
figure
plot(Av , in);



