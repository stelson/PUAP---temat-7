clear all; 
clc;

alfa5 = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9];
options = optimset('MaxFunEvals', 30);

for i = 1:9;
    
    syms s
    c = sym2poly((1+s)*(1+alfa5(i)*s)*(1+alfa5(i)*alfa5(i)*s)*(1+alfa5(i)*alfa5(i)*alfa5(i)*s));
    G = tf(1,c);
    
    if alfa5(i) == 0.1
        x0 = [2; 2; -0.4; 2];
    elseif alfa5(i) == 0.2
        x0 = [2; 2; -0.4; 2];
    elseif alfa5(i) == 0.3
        x0 = [2; 2; 0.1; 10];
    elseif alfa5(i) == 0.4
        x0 = [2; 2; 0.1; 20];
    elseif alfa5(i) == 0.5
        x0 = [2; 2; 0.7; 150];
    elseif alfa5(i) == 0.6
        x0 = [2; 2; 0.8; 170];
    elseif alfa5(i) == 0.7
        x0 = [2; 1; 1.1; 120];
    elseif alfa5(i) == 0.8
        x0 = [2; 1; 1; 100];
    elseif alfa5(i) == 0.9
        x0 = [1.6; 0.5; 1.2; 70];
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
    
    T = num2str(alfa5(i));
    S = strcat(('Alpha = '), (' '), T);
    figure(i)
    plot(t, y(:,2), t, y(:,3))
    grid on
    title(S);
    xlabel('Time')
    ylabel('Value')
    legend('Output value', 'Set value')
end