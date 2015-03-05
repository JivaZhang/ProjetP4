function [A] = findA(t , s , r)

%using Newton-Raphson method to find the minimum of
% int[ (s-A*r)^2]

n = 0;
delta = 100000;
A = 30;

while n<1000 && abs(delta) > 1e-16
    prod = s - A*r;
    val = trapz(t , -2*prod.*r);
    diff = trapz(t , 2*r.^2);
    delta = val/diff;
    A = A-delta;
    n = n +1;
end

end

