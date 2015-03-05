%x = load('P2_cal.tsv');
close all;
load('Config0Try4') %load data from lab
fs = 20e9; % sample frequency used in lab
t = linspace(0 , 20000*1/fs , 20000); %retrieving time scale

% cutting the signal 
l = length(t);
l = l/10; 
t = t(1:l); 
s = Waves(1:l,1)'; % sended signal
r = Waves(1:l,3)'; % recieved signal



figure 
plot(t , s);
legend('s non filtre');

figure 
plot(t , r);
legend('r non filtre');

% Filter the signals 
 cutoff_low = 2*pi*1e9*2.5/(fs);
 cutoff_high = 2*pi*1e9*0.4/(fs);
 [b1,a1] = butter(20,cutoff_low,'low');
 [b2,a2] = butter(20,cutoff_high,'high');
% s = filtfilt(b2,a2,filtfilt(b1,a1,s));
 r = filtfilt(b2,a2,filtfilt(b1,a1,r));


delay = findDelay( r , s , fs); % do correlation in order to find the delay the sended and the recieved impulse
sigdelay = real(ifft(delaySig(r , delay , fs))); % delaying the recieved signal to align the sended and the recieved one 

figure; 
plot(t , s );
legend('sended with filter')

figure;
plot(t , r);
legend('recieved with filter');

figure;
plot(t , r , t , sigdelay);
legend( 'r' , 'sigdelay');
A = findA( t , s , sigdelay); % optimisation to retrieve the replica (s-A*sigdelay)

sr = s- A*sigdelay; % replica
figure;
plot( t , s ,  t  , A*sigdelay , t  , s - A*sigdelay );
legend('s ' ,  'A*sigdelay' , 's-A*sigdelay' );

figure;
plot(t , s-A*sigdelay);
legend('repliques');




