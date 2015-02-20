function plotCircle (x,y,r,c)
    % Using parametric reprentation
    t = linspace(0,2*pi,1000);
    X = x+r*cos(t);
    Y = y+r*sin(t);
    plot(X,Y,c);
end