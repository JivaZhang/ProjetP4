function [ target , fval] = findTarget( Z , d )
 Z1 = Z(1,:);
 Z2 = Z(2,:);
 Z3 = Z(3,:);
 
 err = @(u) (sqrt((u(1) - Z1(1))^2 + (u(2) - Z1(2))^2) - d(1))^2 + (sqrt((u(1) - Z2(1))^2 + (u(2) - Z2(2))^2) - d(2))^2 + (sqrt((u(1) - Z3(1))^2 + (u(2) - Z3(2))^2) - d(3))^2;
 [target,fval] = fminsearch(err, [0 0] , optimset('TolX',1e-8));


end

