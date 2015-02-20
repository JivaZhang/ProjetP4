function viewTrilateration( Z , d , target , Tx)
Z1 = Z(1 , :);
Z2 = Z(2 , :);
Z3 = Z(3 , :);
figure(); hold on;
plot(Z1(1),Z1(2),'bo');
plot(Z2(1),Z2(2),'go');
plot(Z3(1),Z3(2),'ro');

plotCircle(Z1(1),Z1(2),d(1),'b');
plotCircle(Z2(1),Z2(2),d(2),'g');
plotCircle(Z3(1),Z3(2),d(3),'r');

% xlim([-10,10]);
% ylim([-10,10]);
axis([-10 10 -10 10]);

plot(Tx(1),Tx(2),'co');
plot(target(1) , target(2) , 'ro');


hold off;

end
