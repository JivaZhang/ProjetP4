

close all;

if (not(exist('data','var')))
    x = load('P6_cal.tsv');
end
sp = 299792458; % Light Speed [m/s]

Tx = 1e-2*[336.1 15];
Z1 = 1e-2*[160.2 -416];
Z2 = 1e-2*[340 -416];
Z3 = 1e-2*[66.4 543.4];

Z = [Z1 ; Z2 ;  Z3];
d = [ 0 0 0 ];

[ interval , nInterval ] = findTimeImpulse(x);

for i=3:5
    d(i-2) = findMeanDelay(interval , nInterval , x , i);
end

d = d.*sp;

target = findTarget(Z , d);
viewTrilateration( Z , d , target , Tx);




