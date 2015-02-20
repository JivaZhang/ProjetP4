close all;
sp = 299792458; % Light Speed [m/s]

l = length(x(:,1));
inter = int32(10);
ddiv = 10;
delta = idivide(l , inter);
bg = 1;
ed = 0;
d = [0 0 0];
r = x(: ,3:5);

for i = 1:inter
    
    bg = ed+1;
    if( i == inter)
        ed = l;
    else
        ed = bg + delta;
    end
    
    for j = 1:3
        z = mod(j , 3)+1;
        [ z j]
        s1 = r(bg:ed , z);
        s2 = r(bg:ed , j);
        
        [acor,lag] = xcorr(s2 , s1 );
        [~,I] = max(abs(acor));
        Fs = 1/(time(2)-time(1))
        lagDiff = lag(I);
        timeDiff = lagDiff/Fs;
        
        plot(lag  , acor);
        
        % c = corFreq(r(bg:ed, z) , r( bg:ed, j));
        % [max_value, index] = max(abs(c(:)));
        % [j z bg ed l index]
        %time(index)
        d(j) = d(j) + timeDiff;
      
    end
    
end

d = d
d = d.*(sp/ddiv)
