t = 1e-9*linspace(0,50,10000);

Rx1 = 3*sin(2*pi*0.5*1e9*t)+ 5*sin(2*pi*1.5*1e9*t + 2) + 1*sin(2*pi*8.5*1e9*t + 1);

Sr = 1/(t(2)-t(1))
%cutoff = 2*pi*1e9*[0.8 1.8]/(Sr);
cutoff = 2*pi*1e9*1.8/(Sr);

figure(); hold on; plot(t,Rx1);
[b1,a1] = butter(10,cutoff,'low'); % Low pass Butterworth filter of order 10
low_data = filtfilt(b1,a1,Rx1); % filtering 
plot(t,low_data,'g'); legend('1','2');
hold off;