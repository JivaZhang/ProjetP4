%close all;
nMax = 29; %Nombre de fichiers contenant des donnees
% Pre-allocation des vecteurs calcules
x = zeros(nMax,1); y = zeros(nMax,1);

% Ensuite, on effectue le calcul de la position des antennes
Antennas = findAntennas();
% Antennas est une matrice contenant a la ligne i (x_i,y_i), la position de
% l'antenne i. Attention, comme au labo, la ligne 1 est la position (de 
% depart) de l'antenne emettrice, et les lignes 2 a 4 correspondent aux
% recepteurs.

TimeToCalibrate = findDelayToCalibrate2(Antennas);


tic;

for j=1:4
    x = zeros(nMax,1) ; y = zeros(nMax,1);
for n=1:nMax
    % On cree le nom du fichier contenant le screenshot a analyser
    fileName = ['../data/Test' sprintf('%01d',j) '/Data0' sprintf('%02d',n) '.mat'];
    % On envoie ce nom et le setup a une fonction qui calcule la position
    [x(n) ,y(n)] =  findPosition(fileName,Antennas, TimeToCalibrate);
    % Je propose de faire ceci pour que findPosition connaisse la derniere
    % position trouvee, pour avoir un bon point de depart pour l'algo de
    % recherche de position (vu que ca depend tellement du point de depart)
    Antennas(1,:) = [x(n),y(n)]; % Ainsi Antennas contient la position actuelle de Tx
end

toc;
fileSave = ['test' sprintf('%01d',j) '.mat']; 
fileVariable = [x y];
save(fileSave , 'fileVariable');

figure(); hold on;
title('result');
plot(Antennas(2:4,1) , Antennas(2:4,2) , 'x' , x , y  );
legend('positionAntennes' , 'screenShots')
hold off;

end
