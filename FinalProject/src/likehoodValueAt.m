function [likehoodValue] = likehoodValueAt( Waves  , tau , t , fs)
% permet de retrouver la valeur de la fonction de likehood pour les tau
% donnes. les integrations se font par la methode des trapezes

% on decal les signaux de la valeur voulue dans le temps (un delay
% different pour chaque antennes. On recupere pour chacunes de ces
% transformations les index permettant de mettre le signal emis dans la meme
% base de temps. 
[del1 newt1 bgIndex1 endIndex1] = delaySig(Waves(:,2) , tau(1) , fs, t);
[del2 newt2 bgIndex2 endIndex2] = delaySig(Waves(:,3) , tau(2) , fs, t);
[del3 newt3 bgIndex3 endIndex3] = delaySig(Waves(:,4) , tau(3) , fs, t);
    
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