Target = 1e-2 .*[ 104.7 15 ; 154.5 15 ; 204.8 15 ; 244.6 15 ; 286.3 15 ;  336.1,15 ];
name = {'P1_cal.tsv', 'P2_cal.tsv', 'P3_cal.tsv' , 'P4_cal.tsv' , 'P5_cal.tsv', 'P6_cal.tsv'};

err1 = 0;
err2 = 0;
t1 = 0;
t2 = 0; 

for k = 1:6
   file = char(name(k))
   x = load(file);
   Emit = Target(k, :);
   
   tic
   trilaleration;
   t = toc
   t2 = t2 +t;
   err2 = err2 + err;
   
   tic
   evaluateTimeOfFlight
   t = toc
   t1 = t1+t;
   err1 = err1 + err;


end

err1Mean = err1 / 6
t1Mean = t1 / 6
err2Mean = err2/6
t2Mean = t2 /6