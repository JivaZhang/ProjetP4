function [NewWaves newt] = calibrate( Waves , delayToCalibrate , fs)
% Ce code permet de calibrer la matrice Waves avec les valeurs
% delayToCalibreate. Ce matrice doit contenir des échantillons pris à une
% fréquence fs.

% on suppose qu'il y a le meme delay dans tous les cables pour le moment.
% cela c'est pas exactement vrai. Il faudrait mettre en relation chaque
% antenne avec son propre vecteur de temps afin de ne pas faire cette
% approximation.
delay = mean(delayToCalibrate);
t = linspace(0 , 40000*(1/(40e9)) , 40000);

% on decale les sigaux dans le temps et on recuperer le vecteur newt
% correspondant. il prendra toujours les meme valeurs car le delay ne
% change pas pour les differents appeles a la fonction
[New2 newt bg ed] = delaySig(Waves(:,2) , delay , fs , t);
[New3 newt bg ed] = delaySig(Waves(:,3) , delay , fs , t);
[New4 newt bg ed] = delaySig(Waves(:,4) , delay , fs , t);

% on ne decale pas le signal emis, mais on le met en correspondance avec
% les signaux decales.
New1 = Waves(bg:ed , 1);

NewWaves = [New1 New2 New3 New4];

end