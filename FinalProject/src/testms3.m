function [xEstim , yEstim] = testms3(Waves , Antennas, t)

delta = 1.5;
% on creer un mesh autour du point de depart
[X , Y] = meshgrid(linspace(Antennas(1,1)-delta , Antennas(1,1)+delta ,40),linspace(Antennas(1,2)-delta,Antennas(1,2)+delta,40));

fs = 40e9;
f0 = 7e9; % on a filtrer entre 6G et 8G -> fo est donc egale a 7G
c = 299792458;

% on creer le mesh pour les differents taux correspondant a chacune des
% trois antennes


% on filtre les signaux avec une fenetre de 6G -> 8G
Waves = myfilter(Waves , 6e9 , 8e9 , fs);

% on extrait l'enveloppe complexe pour chacun des signaux
Waves(:,1) = extractEnv(Waves(:,1) , t , f0 , fs);
Waves(:,2) = extractEnv(Waves(:,2) , t , f0 , fs);
Waves(:,3) = extractEnv(Waves(:,3) , t , f0 , fs);
Waves(:,4) = extractEnv(Waves(:,4) , t , f0 , fs);

% on creer le mesh pour les differents taux correspondant a chacune des
% trois antennes
tau1 = sqrt((X-Antennas(2,1)).^2+(Y-Antennas(2,2)).^2)/c;
tau2 = sqrt((X-Antennas(3,1)).^2+(Y-Antennas(3,2)).^2)/c;
tau3 = sqrt((X-Antennas(4,1)).^2+(Y-Antennas(4,2)).^2)/c;

% pour trouver la position du maximum de vraiss. Il faut change ceci car
% c'est tres tres lent... 
mini = 1;
minj = 1;
min = 1000000;
likehood = tau1;

for i=1:40
    for j =1:40
        % recuperation de la valeur de likehood pour les i et j
        % correspondant
        likehood(i,j) = likehoodValueAtInside([X(i,j) , Y(i,j)]);
        if likehood(i,j)<min
            mini=i;
            minj=j;
            min = likehood(i,j);
        end 
    end
end
%figure; hold on;
%surface( X , Y , likehood);
%hold off;
[X(mini,minj) Y(mini,minj)]
sol = fminsearch(@likehoodValueAtInside,[X(mini,minj) Y(mini,minj)]);
xEstim = sol(1); yEstim = sol(2);

function [likehoodValue] = likehoodValueAtInside(arg)
% permet de retrouver la valeur de la fonction de likehood pour les tau
% donnes. les integrations se font par la methode des trapezes
Xin = arg(1); Yin = arg(2);

tau1 = sqrt((Xin-Antennas(2,1)).^2+(Yin-Antennas(2,2)).^2)/c;
tau2 = sqrt((Xin-Antennas(3,1)).^2+(Yin-Antennas(3,2)).^2)/c;
tau3 = sqrt((Xin-Antennas(4,1)).^2+(Yin-Antennas(4,2)).^2)/c;

% on decal les signaux de la valeur voulue dans le temps (un delay
% different pour chaque antennes. On recupere pour chacunes de ces
% transformations les index permettant de mettre le signal emis dans la meme
% base de temps. 
[del1 newt1 bgIndex1 endIndex1] = delaySig(Waves(:,2) , tau1 , fs, t);
[del2 newt2 bgIndex2 endIndex2] = delaySig(Waves(:,3) , tau2 , fs, t);
[del3 newt3 bgIndex3 endIndex3] = delaySig(Waves(:,4) , tau3 , fs, t);
    
% on calcule les numérateurs par la méthode des trapèzes.
n1 = trapz(newt1 , Waves(bgIndex1:endIndex1,1).*conj(del1));
n2 = trapz(newt2 , Waves(bgIndex2:endIndex2,1).*conj(del2));
n3 = trapz(newt3 , Waves(bgIndex3:endIndex3,1).*conj(del3));
 
% on calcule les denominateurs par la méthode des trapèzes
d1 = trapz(newt1 , abs(del1.*del1));
d2 = trapz(newt2 , abs(del2.*del2));
d3 = trapz(newt3 , abs(del3.*del3));
        
% on trouve la somme correspondante a chaque antenne.
s1 = - (real(n1)^2/d1) - (imag(n1)^2/d1);
s2 = - (real(n2)^2/d2) - (imag(n2)^2/d2);
s3 = - (real(n3)^2/d3) - (imag(n3)^2/d3);
    
likehoodValue = s1 + s2 + s3;
end

end
