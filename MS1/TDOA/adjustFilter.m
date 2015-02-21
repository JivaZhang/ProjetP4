% Script de test pour ajuster les parametres du filtre sur le signal recu

close all;
n_air = 1.0003;      % Index of refraction of air
c_vac = 299792458;   % Light Speed in vacuum [m/s]
c     = c_vac/n_air; % Light Speed in air    [m/s]

% Position of receivers (x,y) [m]
Z1 = 1e-2*[160.2 -416 ];
Z2 = 1e-2*[340   -416 ];
Z3 = 1e-2*[66.4  543.4];

% Parameters to be adjusted
low  = [0.65 0.70 0.75]*1e9;
high = [1.64 1.65 1.66]*1e9;
ordr = 10;

error = zeros(3,3);



% ---------------- BEGIN FOR LOOP : TREAT ALL DATA ------------------------

for i=1:6 
    name = ['P' num2str(i) '_cal.tsv']
    data = load(name);

    t   = data(:,1);        % Time, increment is 2.5e-11 seconds
    Sr  = 1/(t(2)-t(1));    % Sample rate
    Tx  = data(:,2);        % Emitted signal
    Rx1 = data(:,3);        % Received signal at 1st receiver
    Rx2 = data(:,4);        % ... at 2nd...
    Rx3 = data(:,5);        % ... at 3th...
    for m = 1:3
    for n = 1:3

    cutoff_low = 2*pi*high(m)/(Sr);
    cutoff_high = 2*pi*low(n)/(Sr);

    [b1,a1] = butter(ordr,cutoff_low,'low'); % Low pass Butterworth filter of order 10
    [b2,a2] = butter(ordr,cutoff_high,'high');
    Rx1_low = filtfilt(b2,a2,filtfilt(b1,a1,Rx1)); % filtering 
    Rx2_low = filtfilt(b2,a2,filtfilt(b1,a1,Rx2));
    Rx3_low = filtfilt(b2,a2,filtfilt(b1,a1,Rx3));


    [Cor1,Ind1] = xcorr(Rx1_low,Rx2); % For computing d12
    [Cor2,Ind2] = xcorr(Rx2_low,Rx3); % For computing d23
    [Cor3,Ind3] = xcorr(Rx3_low,Rx1); % For computing d31

    [~,Index1] = max(abs(Cor1));    % Retrieving index of largest value after cross-correlation
    [~,Index2] = max(abs(Cor2));
    [~,Index3] = max(abs(Cor3));
    Dt1 = Ind1(Index1)/Sr;          % Retrieving time difference [s]
    Dt2 = Ind2(Index2)/Sr;
    Dt3 = Ind3(Index3)/Sr;
    d12e  = Dt1*c;                    % Difference of distance [m]
    d23e  = Dt2*c;
    d31e  = Dt3*c;

    [Cor1,Ind1] = xcorr(Rx1,Tx);
    [Cor2,Ind2] = xcorr(Rx2,Tx);
    [Cor3,Ind3] = xcorr(Rx3,Tx);

    % plot(t,tx);
    % figure();
    % plot(lags,r); % lags en indices

    [~,Index1] = max(abs(Cor1));    % Retrieving index of largest value after cross-correlation
    [~,Index2] = max(abs(Cor2));
    [~,Index3] = max(abs(Cor3));
    Dt1 = Ind1(Index1)/Sr;          % Retrieving time difference [s]
    Dt2 = Ind2(Index2)/Sr;
    Dt3 = Ind3(Index3)/Sr;
    d1  = Dt1*c;                    % Distance [m]
    d2  = Dt2*c;
    d3  = Dt3*c;
    d12 = d1 - d2;
    d23 = d2 - d3;
    d31 = d3 - d1;

    error(m,n) = error(m,n) + abs(d12e-d12) + abs(d23e-d23) + abs(d31e-d31);
    
    end
    end

end

% ----------------- END FOR LOOP : TREAT ALL DATA -------------------------




disp(error);