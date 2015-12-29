clear all; 
clc;

T2 = [0.01 0.02 0.05 0.1 0.2 0.3 0.5 0.7 1 1.3 1.5 2 4 6 8 10 20 50 100 200 500];
options = optimset('MaxFunEvals', 50)

for i = 1:21;
    num = [1];
    denum = [T2(i)*T2(i) 2*T2(i) 1];
    G = tf(num, denum, 'InputDelay', 1);
    
    if T2(i) == 500
        x0 = [148; 0.35; -259; 0.57];
    elseif T2(i) == 200
        x0 = [170; 0.2; -518; 0.32];
    else
        x0 = [T2(i); 1; -T2(i)/1; 1];
    end
    
    [xopt, fopt, flag, iter] = fminsearch(@PIDOptim, x0, options);
    
    P = xopt(1) 
    I = xopt(2)
    D = xopt(3)
    N = xopt(4)
    
    P1(i) = xopt(1)
    I1(i) = xopt(2)
    D1(i) = xopt(3)
    N1(i) = xopt(4)
    
    [t, x, y] = sim('Model.slx', 50); 
    figure(i)
    plot(t, y(:,2))
    
end