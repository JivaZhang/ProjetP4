%x = load('P2_cal.tsv');
close all;
load('multipath_CC');
l = length(t);
l = l/100;

t = t(1:l);
s = gcal(1:l)';
r = -r3bp(1:l);
fs = 1/(t(2)-t(1));
S = fft(s);
f = fs/2 * linspace( 0 , 1 , length(s));
filter = (f >= 0.7e9) .* ( f<=2e9);
r = ifft(fft(r).*filter);


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

Av = linspace(-1000, 1000 , 1000);
in = Av ;

for i = 1:1000
    in(i) = trapz( t , (s-Av(i)*sigdelay).^2);
end

plot(Av , in);



