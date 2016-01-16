clear all; 
clc;

T1 = [0.02 0.05 0.1 0.2 0.3 0.5 0.7 1 1.3 1.5 2 4 6 8 10 20 50 100 200 500 1000];
options = optimset('MaxFunEvals', 30);

for i = 1:21;
    
    num = [1];
    denum = [T1(i) 1];
    G = tf(num, denum, 'InputDelay', 1);
    
    if T1(i) == 500
        x0 = [148; 0.35; -259; 0.57];
    elseif T1(i) == 1000
        x0 = [170; 0.2; -518; 0.32];
    elseif T1(i) == 200
        x0 = [135; 0.73; -103; 1.3];
    elseif T1(i) == 100
        x0 = [56; 0.255; -52; 1.09];
    elseif T1(i) == 50
        x0 = [35; 0.2; -25; 1.37];
    elseif T1(i) == 20
        x0 = [44; 0.8; -10; 4.33];
    elseif T1(i) > 0 && T1(i) < 1
        x0 = 1*ones(4, 1);
    elseif T1(i) >= 1 <= 10
        x0 = 5*ones(4, 1);
    else
        x0 = [T1(i); 1; -T1(i)/1; 1]
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
    
    T = num2str(T1(i));
    S = strcat(('T = '), (' '), T);
    figure(i)
    plot(t, y(:,2), t, y(:,3))
    grid on
    title(S);
    xlabel('Time')
    ylabel('Value')
    legend('Output value', 'Set value')
end





































































