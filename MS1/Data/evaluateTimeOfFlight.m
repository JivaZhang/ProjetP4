%% INITIALIZATION
close all;
c = 299792458; % Light Speed [m/s]
% Position of receivers (x,y) [m]
Z1 = 1e-2*[160.2 -416 ];
Z2 = 1e-2*[340   -416 ];
Z3 = 1e-2*[66.4  543.4];

%% DATA RETRIVATION AND DISTANCE CALCULATION

% Check if data is already loaded to avoid unnessary loading
if (not(exist('data','var')))
    data = load('P2_cal.tsv');
end

t   = data(:,1);        % Time, increment is 2.5e-11 seconds
Sr  = 1/(t(2)-t(1));    % Sample rate
Tx  = data(:,2);        % Emitted signal
Rx1 = data(:,3);        % Received signal at 1st receiver
Rx2 = data(:,4);        % ... at 2nd...
Rx3 = data(:,5);        % ... at 3th...


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

% Setup visualisation
figure(); hold on;
plot(Z1(1),Z1(2),'bo');
plot(Z2(1),Z2(2),'go');
plot(Z3(1),Z3(2),'ro');

plotCircle(Z1(1),Z1(2),d1,'b');
plotCircle(Z2(1),Z2(2),d2,'g');
plotCircle(Z3(1),Z3(2),d3,'r');

% xlim([-10,10]);
% ylim([-10,10]);
axis([-10 10 -10 10]);

plot(1.547,0.15,'co');

hold off;










