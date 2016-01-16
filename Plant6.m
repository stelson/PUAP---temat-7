clear all; 
clc;

L6 = [0.01 0.02 0.05 0.1 0.3 0.5 0.7 0.9 1];
options = optimset('MaxFunEvals', 10);

for i = 1:9;

    G = tf(1,[(1-L6(i)) 1 0],'InputDelay', L6(i));
    
    if L6(i) == 0.01
        x0 = [2; 0.03; 1; 4];
    elseif L6(i) == 0.02
        x0 = [2; 0.03; 1; 4];
    elseif L6(i) == 0.05
        x0 = [2; 0.03; 1; 4];
    elseif L6(i) == 0.1
        x0 = [2; 0.03; 1; 4];
    elseif L6(i) == 0.3
        x0 = [2; 0.02; 1.2; 200];
    elseif L6(i) == 0.5
        x0 = [0.8; 0.006; 0.3; 10];
    elseif L6(i) == 0.7
        x0 = [0.5; 0.002; 0.03; 0.5];
    elseif L6(i) == 0.9
        x0 = [0.7; 0.003; 0.15; 76];
    elseif L6(i) == 1
        x0 = [0.5; 0.003; 0.06; 70];
    end
    
    [xopt, fopt, flag, iter] = fminsearch(@PIDOptimLTI, x0, options);
    
    P = xopt(1) 
    I = xopt(2)
    D = xopt(3)
    N = xopt(4)
    
    P1(i) = xopt(1)
    I1(i) = xopt(2)
    D1(i) = xopt(3)
    N1(i) = xopt(4)
    
    [t, x, y] = sim('ModelLTI.slx', 50); 
    
    T = num2str(L6(i));
    S = strcat(('L = '), (' '), T);
    figure(i)
    plot(t, y(:,2), t, y(:,3))
    grid on
    title(S);
    xlabel('Time')
    ylabel('Value')
    legend('Output value', 'Set value')
end