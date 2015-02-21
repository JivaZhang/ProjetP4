% multilateration

%% INITIALIZATION
close all;
n_air = 1.0003;      % Index of refraction of air
c_vac = 299792458;   % Light Speed in vacuum [m/s]
c     = c_vac/n_air; % Light Speed in air    [m/s]
% Position of receivers (x,y) [m]
Z1 = 1e-2*[160.2 -416 ];
Z2 = 1e-2*[340   -416 ];
Z3 = 1e-2*[66.4  543.4];
% Position of emitter in 6 cases [m]
Ze = 1e-2*[[104.7 15];[154.5 15];[204.8 15];[244.6 15];[286.3 15];[336.1 15]];

%% DATA RETRIVATION AND DIFFERENCE OF DISTANCE CALCULATION

% Check if data is already loaded to avoid unnessary loading
if (not(exist('data','var')))
    data = zeros(793476,5,6); % Pre-allocation
    for i=1:6
        name = ['P' num2str(i) '_cal.tsv'];
        data(:,:,i) = load(name);
    end
end

for i=1:6 % For each dataset
    
    t   = data(:,1,i);        % Time, increment is 2.5e-11 seconds
    Sr  = 1/(t(2)-t(1));      % Sample rate
    Tx  = data(:,2,i);        % Emitted signal
    Rx1 = data(:,3,i);        % Received signal at 1st receiver
    Rx2 = data(:,4,i);        % ... at 2nd...
    Rx3 = data(:,5,i);        % ... at 3th...

    % Filtering Rx1...Rx3 through two Butterworth filters
    cutoff_low = 2*pi*1e9*1.8/(Sr);
    cutoff_high = 2*pi*1e9*0.7/(Sr);
    [b1,a1] = butter(20,cutoff_low,'low'); 
    [b2,a2] = butter(20,cutoff_high,'high');
    Rx1_low = filtfilt(b2,a2,filtfilt(b1,a1,Rx1)); 
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
    d12  = Dt1*c;                    % Difference of distance [m]
    d23  = Dt2*c;
    d31  = Dt3*c;

    % Sum of distances to the 3 hyperbolas (function to be minimized) x(1) = x,
    % x(2) = y
    fun = @(x) abs(sqrt((x(1)-Z1(1))^2+(x(2)-Z1(2))^2)-sqrt((x(1)-Z2(1))^2+(x(2)-Z2(2))^2)-d12) + abs(sqrt((x(1)-Z2(1))^2+(x(2)-Z2(2))^2)-sqrt((x(1)-Z3(1))^2+(x(2)-Z3(2))^2)-d23) + abs(sqrt((x(1)-Z3(1))^2+(x(2)-Z3(2))^2)-sqrt((x(1)-Z1(1))^2+(x(2)-Z1(2))^2)-d31);

    xopt = fminsearch(fun,[0 0])
    
    % Setup visualisation
    figure(); hold on;
    plot(Z1(1),Z1(2),'bo','Linewidth',5);
    plot(Z2(1),Z2(2),'go','Linewidth',5);
    plot(Z3(1),Z3(2),'ro','Linewidth',5);
    plot(Ze(i,1),Ze(i,2),'cs','Linewidth',5);
    plot(xopt(1),xopt(2),'mx','Linewidth',7);
    
    % Plot settings
    title(['Dataset ' num2str(i) ' : TDOA']);
    xlabel('x position [m]'); ylabel('y position [m]');
    axis([-10 10 -10 10]);
    legend('Rx1','Rx2','Rx3','Tx','Estimation');
    grid on;


    hold off;

end






