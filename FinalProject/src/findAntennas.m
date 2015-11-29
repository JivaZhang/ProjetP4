function Antennas = findAntennas()
    % Donne la position des antennes : a modifier (refaire les estimations)
    % si donnees plus precises...
    
    % Donnees mesurees : distances [m] : 0 = origine, 1 = emetteur, 
    % 2-4 = recepteurs
    d01 = mean([9.298 9.310 9.315]);
    d02 = mean([3.974 3.976 3.979]);
    d03 = mean([5.579 5.585 5.586]);
    d04 = mean([9.711 9.717 9.713]);
    d12 = mean([5.465 5.459 5.458]);
    d13 = mean([7.822 7.896 7.848]);
    d14 = mean([1.843 1.821 1.811]);
    d23 = mean([5.475 5.480 5.464]);
    d24 = mean([6.195 6.199 6.162]);
    d34 = mean([7.134 7.147 7.142]);
    
    d1w = 4.895; % Distance entre l'antenne 1 et le mur
    
    % Position de l'antenne 1
    Y1 = d1w;
    X1 = -sqrt(d01^2 - d1w^2);
    
    % Position de l'antenne 2 : on regarde sur le plot et on choisit la
    % solution la plus plausible
    %plotCircle (0,0,d02,'r'); hold on;
    %plot(0,0,'Color','r','Marker','o'); hold on; grid on;
    %plotCircle (X1,Y1,d12,'g');
    %plot(X1,Y1,'Color','g','Marker','o'); 
    X2 = -3.7224;
    Y2 = 1.3982;
    
    % Position de l'antenne 3 : idem
    %plotCircle (0,0,d03,'r'); 
    %plotCircle (X1,Y1,d13,'g');
    %plotCircle (X2,Y2,d23,'b');
    %plot(X2,Y2,'Color','b','Marker','o');
    
    X3 = mean([-0.1917 -0.0914 -0.0835]);
    Y3 = mean([5.58 5.5826 5.4862]);
    
    % Position de l'antenne 4
    %plotCircle (0,0,d04,'r'); 
    %plotCircle (X1,Y1,d14,'g');
    %plotCircle (X2,Y2,d24,'b');
    %plotCircle (X3,Y3,d34,'y');
    %plot(X3,Y3,'Color','y','Marker','o');
    
    X4 = mean([-7.2166 -7.1976 -7.1963 -7.1463 -7.1654 -7.19]);
    Y4 = mean([6.502 6.5149 6.5344 6.5495 6.5583 6.5691]);
    
    %plot(X4,Y4,'Color','m','Marker','o');
    
    Antennas = [X1 Y1; X2 Y2; X3 Y3; X4 Y4];
    
end
