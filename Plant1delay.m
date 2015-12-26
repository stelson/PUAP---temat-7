clear all; 
clc;

T1 = [0.02 0.05 0.1 0.2 0.3 0.5 0.7 1 1.3 1.5 2 4 6 8 10 20 50 100 200 500 1000];
options = optimset('MaxFunEvals', 200);
% %P = zeros(21, 1)';
% I = zeros(21, 1)';
% D = zeros(21, 1)';
% N = zeros(21, 1)';

for i = 9:10;
    
    num = [1];
    denum = [T1(i) 1];
    G = tf(num, denum, 'InputDelay', 1);
    
    if T1(i) > 100
        x0 = 10*ones(4, 1);
    else
        x0 = 1*ones(4, 1);
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
    
    [t, y] = sim('Model.slx', 50); 
    figure(i)
    plot(t, y)
end

% options = optimset('MaxFunEvals', 30)
% [xopt, fopt, flag, iter] = fminsearch(@PIDOptim, x0, options);
% P = xopt(1) 
% I = xopt(2)
% D = xopt(3)
% N = xopt(4)





































































