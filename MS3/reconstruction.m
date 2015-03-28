function [Xcontinious] = reconstruction(Xdiscret,t,fs)
%permet de reconstruire le signal Xdiscret en temps continu. Xcontinious
%contient la valeur de cet fonction en temps continu pour tous les temps t
    N = length(Xdiscret);
    I = length(t);
    matrix = zeros(N , I);
    Ts = 1/fs;
    
    for i = 1:N %initialisation de matrix avec des fonction h_r(t-nTs) pour les différents n
        nts = t-((i-1)*Ts);
        matrix(i , :) = Ts * sin(pi*fs*nts)./(pi*nts);
    end

    Xcontinious = Xdiscret' * matrix;
end
