function [delayToCalibrate] = findDelayToCalibrate( Antennas , filename)
%a pour but de trouver les delays qu'il faut utiliser pour calibrer 
%Antennas est les positions des antennes receptrices et l'emetrice qui sont
%connues pour le screenshot pris dans le fichier filename 
% les valeurs des delays sont positives si il faut avancer et negatives si
% il faut reculer

c = 299792458;
fs  = 40e9;
nSample = 40000;
load(filename);
t = linspace(0 , nSample*(1/fs) , nSample);

%Les distances qui séparent les antennes resectrines à l'emettrice
d01 = sqrt((Antennas(1,1)-Antennas(2,1))^2 + (Antennas(1,2)-Antennas(2,2))^2);
d02 = sqrt((Antennas(1,1)-Antennas(3,1))^2 + (Antennas(1,2)-Antennas(3,2))^2);
d03 = sqrt((Antennas(1,1)-Antennas(4,1))^2 + (Antennas(1,2)-Antennas(4,2))^2);

%Les temps attendus entre l'emission et la reception
t01Expeted = d01/c;
t02Expeted = d02/c;
t03Expeted = d03/c;
tExpeted = [t01Expeted , t02Expeted , t03Expeted];

%Les temps réels entre l'emission et l'emission
t01Real = findDelay(Waves(:,1) , Waves(:,2) , fs);
t02Real = findDelay(Waves(:,1) , Waves(:,3) , fs);
t03Real = findDelay(Waves(:,1) , Waves(:,4) , fs);
tReal = [ t01Real , t02Real , t03Real];

delayToCalibrate = -tReal + tExpeted;

end