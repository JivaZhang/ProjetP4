close all;
load('MS3-Labo/labMS3/config1.mat')
N = length(Waves(:,1));
fs = 40e9;
t = linspace(0 , N*1/fs , N);

delayToCalibrate = calibrate(Waves(:,2) , Waves(:,1) , 3 , fs); % recuperation de delay pour calibrer l'antenne
calibrated = delaySig( Waves(:,2) , delayToCalibrate , fs); % le signal reçu est decale de ce delay

plot(t , Waves(:,1)' , t , Waves(:,2)'  , t , calibrated );
legend( 'sended' , 'recieved' , 'calibrated');