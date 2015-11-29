
function [delayToCalibrate] = findDelayToCalibrate2( Antennas)




dels = zeros(3,1); % Matrix of all computed delays

% On cree le nom du fichier contenant le screenshot a analyser
fileName = ['../data/Test1/Data001.mat'];
dels(1) = mean(findDelayToCalibrate( Antennas , fileName));
fileName = ['../data/Test2/Data001.mat'];
dels(2) = mean(findDelayToCalibrate( Antennas , fileName));
fileName = ['../data/Test5/Data001.mat'];
dels(3) = mean(findDelayToCalibrate( Antennas , fileName));

dels
delayToCalibrate = mean(dels);

end
