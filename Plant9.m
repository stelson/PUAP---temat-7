clear all; 
clc;

T9 = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
options = optimset('MaxFunEvals', 30);

for i = 1:10;

    syms s
    c = sym2poly((s+1)*((s*T9(i))*(s*T9(i)) + 1.4*s*T9(i) +1));
    G = tf(1,c);
    
    if T9(i) == 0.1
        x0 = [2; 0.03; 1; 4];
    elseif T9(i) == 0.2
        x0 = [2; 0.03; 1; 4];
    elseif T9(i) == 0.3
        x0 = [2; 0.03; 1; 4];
    elseif T9(i) == 0.4
        x0 = [2; 0.03; 1; 4];
    elseif T9(i) == 0.5
        x0 = [2; 0.02; 1.2; 200];
    elseif T9(i) == 0.6
        x0 = [0.8; 0.006; 0.3; 10];
    elseif T9(i) == 0.7
        x0 = [0.5; 0.002; 0.03; 0.5];
    elseif T9(i) == 0.8
        x0 = [0.7; 0.003; 0.15; 76];
    elseif T9(i) == 0.9
        x0 = [0.5; 0.003; 0.06; 70];
    elseif T9(i) == 1
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
    
    Fmin = y(size(y, 1),1);
    
    T = num2str(T9(i));
    S = strcat(('L = '), (' '), T);
    figure(i)
    plot(t, y(:,2), t, y(:,3))
    grid on
    title(S);
    xlabel('Time')
    ylabel('Value')
    legend('Output value', 'Set value')
end