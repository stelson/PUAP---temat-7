clear all; 
clc;

alfa8 = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 1.1];
options = optimset('MaxFunEvals', 30);

for i = 1:2;
    
    num = [-alfa8(i) 1];
    denum = [1 3 3 1];
    G = tf(num, denum, 'InputDelay', 1);
    
    if alfa8(i) == 0.1
        x0 = [1.6; 0.7; 0.9; 76];
    elseif alfa8(i) == 0.2
        x0 = [2; 0.5; 2; 120];
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