%x = load('P2_cal.tsv');
close all;
l = length(tcal);
l = l / 200;

t = tcal(1:l);
s = gcal(1:l)';
r = r1cal(1:l)';
fs = 1/(t(2)-t(1));
S = fft(s);
f = fs/2 * linspace( 0 , 1 , length(s));
filter = (f >= 0.7e9) .* ( f<=1.8e9);
r = ifft(fft(r).*filter);


delay = findDelay( r , s , fs);
sigdelay = real(ifft(delaySig(r , delay , fs)));

figure;
plot(t , r , t , sigdelay);
legend( 'r' , 'sigdelay');
A = findA( t , s , sigdelay);
A = 600;

figure;
plot( t , s , t , s-A*sigdelay , t  , A*sigdelay );
legend('s ' , 's-A*sigdelay' , 'A*sigdelay' );

figure;
plot(t , s-A*sigdelay);
