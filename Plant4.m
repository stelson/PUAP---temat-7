clear all; 
clc;

n4 = [ 3 4 5 6 7 8];
options = optimset('MaxFunEvals', 100);

for i = 1:6;
    
    syms s;
    c = sym2poly((s+1)^n4(i));
    G = tf(1,c);
    
    if n4(i) == 3
        x0 = [2; 1; 1; 80];
    elseif n4(i) == 4
        x0 = [1; 0.3; 0.06; 40];
    elseif n4(i) == 5
        x0 = [1.5; 0.3; 1.6; 48];
    elseif n4(i) == 6
        x0 = [0.4; 0.15; 0; 100];
    elseif n4(i) == 7
        x0 = [0.56; 0.14; 0; 100];
    elseif n4(i) == 8
        x0 = [0.35; 0.1; 0; 100];
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
    
    Fmin(i) = y(size(y, 1),1);
    PID = [P1' I1' D1' N1' Fmin'];
    
    T = num2str(n4(i));
    S = strcat(('rank = '), (' '), T);
    figure(i)
    plot(t, y(:,2), t, y(:,3))
    grid on
    title(S);
    xlabel('Time')
    ylabel('Value')
    legend('Output value', 'Set value')
end