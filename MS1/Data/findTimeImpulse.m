function [time , n] = findTimeImpulse( x )

    delta = 50;
    time = zeros(2 , delta);
    bg = 1;
    ed = 1;
    n = 1;
    l = length(x(:,1));
    
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
        
        if( mod( n , delta) == 0)
            time = [time  zeros(2, delta)];
        end
        
        time(1 , n) = bg;
        time(2 , n) = ed;
        n = n + 1;
        
    end
    
end

