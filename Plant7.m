clear all; 
clc;

L7 = [0.01 0.02 0.05 0.1 0.3 0.5 0.7 0.9 1];
T7 = 10;
options = optimset('MaxFunEvals', 100);

for i = 1:9;

    G = tf(T7,[T7*(1-L7(i)) T7+(1-L7(i)) 1], 'InputDelay', L7(i));
    
    if L7(i) == 0.01
        x0 = [2; 0.2; 0.7; 2.6];
    elseif L7(i) == 0.02
        x0 = [2; 0.1; 2; 4];
    elseif L7(i) == 0.05
        x0 = [2; 0.1; 2; 4];
    elseif L7(i) == 0.1
        x0 = [2; 0.03; 1; 4];
    elseif L7(i) == 0.3
        x0 = [2; 0.02; 1.2; 200];
    elseif L7(i) == 0.5
        x0 = [1; 0.09; 0.3; 110];
    elseif L7(i) == 0.7
        x0 = [0.5; 0.04; 0; 100];
    elseif L7(i) == 0.9
        x0 = [0.7; 0.04; 0.1; 78];
    elseif L7(i) == 1
        x0 = [0.6; 0.06; 0.08; 70];
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
    
    Fmin = y(size(y, 1),1);
    
    T = num2str(L7(i));
    T1 = num2str(T7);
    S = strcat(('L = '), (' '), T, ('T = '), (' '), T1);
    figure(i)
    plot(t, y(:,2), t, y(:,3))
    grid on
    title(S);
    xlabel('Time')
    ylabel('Value')
    legend('Output value', 'Set value')
end