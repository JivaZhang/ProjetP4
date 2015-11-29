function [xEstim,yEstim] = findPosition(fileName, Antennas , TimeToCalibrate)
% C'est la "seule" fonction qu'il reste a ecrire
% Rappel : Antennas est une matrice contenant a la ligne i (x_i,y_i), la position de
% l'antenne i. Attention, comme au labo, la ligne 1 est la position (de 
% depart) de l'antenne emettrice, et les lignes 2 a 4 correspondent au
% recepteurs.
% TimeToCalibrate est le delay à introduire pour la calibration des signaux
% recu


    load(fileName);
    disp(['traitement du fichier' fileName])
    
    fs = 40e9;
    nSample = 40000;
    
    %calibration des signaux sur base des valeurs trouvées pour la
    %calibration
    [Waves t]= calibrate(Waves , TimeToCalibrate , fs);
    
    
    %trouver le point de depart de l'algo en utilisant le toa, si il est
    %plausible
    %[xEstim , yEstim] = tdoa(Antennas , Waves , t , fs);
    %if (sqrt((Antennas(1,1) - xEstim)^2 + (Antennas(1,2) - yEstim)^2) < 5)
    %    Antennas(1,1) = xEstim;
    %    Antennas(1,2) = yEstim;
    %end
    
    %implementation de l'algo du ms3
    [xEstim , yEstim] = testms3(Waves , Antennas , t);

end