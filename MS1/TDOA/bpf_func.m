function[pbp]=bpf_func(f1,f2,Ts,p)

%%%%%%%%%%%%%% Input
% f1 = lowest frequency
% f2 = highest frequency
% Ts = sampling period
% p = signal to filter (the number of samples of p MUST BE EVEN)

%%%%%%%%%%%%%% Output
% pbp = filtered signal

Nsam = length(p) ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Removing DC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p = p - mean(p) ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% fft %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
df = 1/(Nsam*Ts) ; P = fft(p)*Ts ;
f=(-Nsam/2:Nsam/2-1)*df;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BPF %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f1i = round(f1/df)+1 ; f2i = round(f2/df)+1 ; fi = 1:Nsam ; 
win = (fi>=f1i).*(fi<=f2i) + (fi>=Nsam+2-f2i).*(fi<=Nsam+2-f1i) ;
Pbp = P.*win' ; pbp = ifft(Pbp)/Ts ;
Pa=abs(fftshift(P)).^2; Pbpa=abs(fftshift(Pbp)).^2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure ; plot(p,'b','linewidth',2) ;
% hold on ; plot(pbp,'g','linewidth',2) ;




