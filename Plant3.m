clear all; 
clc;

T3 = [0.005 0.01 0.02 0.05 0.1 0.2 0.5 2 5 10];
options = optimset('MaxFunEvals', 20)

for i = 1:10;
    num = [1];
    denum = [T3(i)*T3(i) T3(i)*T3(i)+ 2*T3 2*T3(i) 1 1];
    G = tf(num, denum, 'InputDelay', 1);
    
    if T3(i) == 0.005
        x0 = [148; 0.35; -259; 0.57];
    elseif T3(i) == 200
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