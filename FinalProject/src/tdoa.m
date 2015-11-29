function [xEstim , yEstim] = tdoa(Antennas , Waves , time ,fs)
%% INITIALIZATION
c = 299792458; % Light Speed [m/s]

%% DATA RETRIVATION AND DISTANCE CALCULATION


Tx  = Waves(:,1);        % Emitted signal
Rx1 = Waves(:,2);       % Received signal at 1st receiver
Rx2 = Waves(:,3);        % ... at 2nd...
Rx3 = Waves(:,4);        % ... at 3th...


[Cor1,Ind1] = xcorr(Rx1,Tx);
[Cor2,Ind2] = xcorr(Rx2,Tx);
[Cor3,Ind3] = xcorr(Rx3,Tx);



[~,Index1] = max(abs(Cor1));    % Retrieving index of largest value after cross-correlation
[~,Index2] = max(abs(Cor2));
[~,Index3] = max(abs(Cor3));
Dt1 = Ind1(Index1)/fs;          % Retrieving time difference [s]
Dt2 = Ind2(Index2)/fs;
Dt3 = Ind3(Index3)/fs;
d1  = Dt1*c;                    % Distance [m]
d2  = Dt2*c;
d3  = Dt3*c;

target = findTarget( Antennas(2:4 , :) , [d1 , d2 , d3]  , Antennas(1,:));

xEstim = target(1);
yEstim = target(2);

end











