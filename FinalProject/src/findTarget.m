function [target] = findTarget( Z ,r , StartingPoint)
x = StartingPoint(1);
y = StartingPoint(2);
delta = 1000;
n = 0;
while( norm(delta) >= 1e-10 && n<=40)
    dx = 0;
    dy = 0;
    ddxx = 0;
    ddyy = 0;
    ddxy = 0;
    ddyx = 0;
    
    for i= 1:3
        px = Z(i , 1);
        py = Z(i , 2);
        d = r(i);
        dx = dx + ((2*px - 2*x)*(d - ((px - x)^2 + (py - y)^2)^(1/2)))/((px - x)^2 + (py - y)^2)^(1/2);
        dy = dy + ((2*py - 2*y)*(d - ((px - x)^2 + (py - y)^2)^(1/2)))/((px - x)^2 + (py - y)^2)^(1/2);
        ddxx = ddxx + (2*px - 2*x)^2/(2*((px - x)^2 + (py - y)^2)) - (2*(d - ((px - x)^2 + (py - y)^2)^(1/2)))/((px - x)^2 + (py - y)^2)^(1/2) + ((2*px - 2*x)^2*(d - ((px - x)^2 + (py - y)^2)^(1/2)))/(2*((px - x)^2 + (py - y)^2)^(3/2));
        ddxy = ddxy +((2*px - 2*x)*(2*py - 2*y))/(2*((px - x)^2 + (py - y)^2)) + ((2*px - 2*x)*(2*py - 2*y)*(d - ((px - x)^2 + (py - y)^2)^(1/2)))/(2*((px - x)^2 + (py - y)^2)^(3/2));
        ddyx = ddyx + ((2*px - 2*x)*(2*py - 2*y))/(2*((px - x)^2 + (py - y)^2)) + ((2*px - 2*x)*(2*py - 2*y)*(d - ((px - x)^2 + (py - y)^2)^(1/2)))/(2*((px - x)^2 + (py - y)^2)^(3/2));
        ddyy = ddyy + (2*py - 2*y)^2/(2*((px - x)^2 + (py - y)^2)) - (2*(d - ((px - x)^2 + (py - y)^2)^(1/2)))/((px - x)^2 + (py - y)^2)^(1/2) + ((2*py - 2*y)^2*(d - ((px - x)^2 + (py - y)^2)^(1/2)))/(2*((px - x)^2 + (py - y)^2)^(3/2));
    end
    
    A = [ ddxx ddyx ; ddxy  ddyy] ;
    B = [ dx ; dy ];
    delta = - A \ B;
    x = delta(1) + x ;
    y = delta(2) + y ;
    n = n+1;
end
 target = [x y];
end

