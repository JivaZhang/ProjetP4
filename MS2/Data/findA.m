function [A] = findA(t , s , r)

% n = 0;
% delta = 100000;
% A = 1200;
% 
% while n<1000 && abs(delta) > 1e-4
%     prod = s - A*r;
%     val = trapz(t , -2*A*prod);
%     diff = trapz(t , -2*s + 4*A);
%     delta = val/diff;
%     A = A-delta;
%     n = n +1;
% end
% n

%   n = 0;
%   delta = 100000;
%   A = 1;
%   Av = linspace(0.01 , 1 , 10000);
%   Int = Av;
%   for i = 1:1000
%       
%       val = (s-Av(i)*r)
%       Int(i) = trapz( t , val);
%   end
%   
%   figure;
%   plot(Av , Int);
%  


fun= @(A) sum((s-A*r).^2);
[A,fval] = fminsearch(fun,[1000]); 

  
end

