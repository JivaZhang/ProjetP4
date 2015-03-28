close all;
load('MS3-Labo/labMS3/config1.mat')
N = length(Waves(:,1))/10;
Waves = Waves(1:N,:);
fs = 40e9;
t = (0)/fs:1/fs:(N-1)/fs;
delayToCalibrate = calibrate(Waves(:,2) , Waves(:,1) , 3 , fs); % recuperation de delay pour calibrer l'antenne
calibrated = delaySig( Waves(:,2) , delayToCalibrate , fs); % le signal reçu est decale de ce delay

figure; hold on;
plot(t , Waves(:,1)' , t , Waves(:,2)'  , t , calibrated );
legend( 'sended' , 'recieved' , 'calibrated');
hold off;

tcontinious = (0)/(fs):(1/(20*fs)):(N-1)/(fs);
Xcontinious = reconstruction(Waves(:,2),tcontinious,fs);

figure; hold on;
plot( t , Waves(:,2) , tcontinious , Xcontinious);
legend( 'discrete' , 'continious');
hold off;
