if (not(exist('data','var')))
    data = load('P2_cal.tsv');
end
close all;
sp = 299792458; % Light Speed [m/s]

Tx = 1e-2*[154.5 15];
Z1 = 1e-2*[160.2 -416];
Z2 = 1e-2*[340 -416];
Z3 = 1e-2*[66.4 543.4];

Z = [Z1  Z2  Z3]

n1 = norm(Z1- Tx)
n2 = norm(Z2 - Tx)
n3 = norm(Z3 - Tx)
bg = 1;
ed = 1;
d = [ 0 0 0 ];
t = x(: , 1);

for i=3:5
    bg = 1;
    ed = 1;
    n = 1;
    sdelay = 0;
    l = length(t);
    while( ed < l)
        bg = ed;
        flagA = 0; % si on a passe le pick
        flagB = 0; % si on arrive sur un nouveau pick
        while (flagB == 0 || flagA == 0) && ed <l
            if ed+1 < l && flagA == 0
                if x(ed , 2) == 0 && x(ed+1 , 2)==0
                    flagA = 1;
                end
            else
                if ed+1 < l
                    if x(ed, 2) ~=0
                        break;
                    end
                else
                    flagB = 1;
                end
            end
            ed = ed +1;
        end
        
        time = t(1:(ed-bg+1));
        s = x(bg:ed, 2);
        r = x(bg:ed, i);
        S = fft(s);
        R = fft(r);
        C = R .* conj(S);
        c = ifft(C);
        [max_value, index] = max(c(:));
        sdelay = sdelay + time(index);
        n = n+1;
    end
        d(i-2) = sdelay/n;
end

[inter1 , inter2] = intersect( Z1 , d(1)*sp , Z2 , d(2)*sp)
figure(); hold on;
plot(Z1(1),Z1(2),'bo');
plot(Z2(1),Z2(2),'go');
plot(Z3(1),Z3(2),'ro');

plotCircle(Z1(1),Z1(2),d(1)*sp,'b');
plotCircle(Z2(1),Z2(2),d(2)*sp,'g');
plotCircle(Z3(1),Z3(2),d(3)*sp,'r');

% xlim([-10,10]);
% ylim([-10,10]);
axis([-10 10 -10 10]);

plot(Tx(1),Tx(2),'co');

hold off;




