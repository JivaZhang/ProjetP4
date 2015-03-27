function [delay] = calibrate( sended , recieved , distance , fs)
% Ce code a pour but de calibré les signaux. sended est l'impulsion émise,
% recieved est le signal recu sur une antenne. distance est la distance
% entre les deux. la valeur retournée (delay) est le décalage temporel que doit subir 
% le signal reçu afin d'etre calibré. 

c = 299792458;
realDelay = findDelay(sended ,recieved , fs);
expectedDelay = distance / c;
delay = realDelay - expectedDelay;
end