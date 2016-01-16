clear all; 
clc;

T2 = [0.01 0.02 0.05 0.1 0.2 0.3 0.5 0.7 1 1.3 1.5 2 4 6 8 10 20 50 100 200 500];
options = optimset('MaxFunEvals', 30)

for i = 1:21;
    num = [1];
    denum = [T2(i)*T2(i) 2*T2(i) 1];
    G = tf(num, denum, 'InputDelay', 1);
    
    if T2(i) == 500
        x0 = [148; 0.35; -259; 0.57];
    elseif T2(i) == 200
        x0 = [170; 0.2; -518; 0.32];
    elseif T2(i) == 0.5
        x0 = [1.82; 2.6; 0.14; 5.77];
    elseif T2(i) == 0.7
        x0 = [1.81; 1.85; 0.2; 4.12];
    elseif T2(i) == 1
        x0 = [1.81; 1.3; 0.29; 2.89];
    elseif T2(i) == 1.3
        x0 = [3.05; 1.4; 0.8; 3.21];
    elseif T2(i) == 1.5
        x0 = [7.05; 0.82; 8.45; 1.63];
    elseif T2(i) == 2
        x0 = [4.7; 1.15; 2.14; 2.88];
    elseif T2(i) == 4
        x0 = [3; 0.5; 2.45; 1];
    elseif T2(i) == 6
        x0 = [7; 0.5; 13; 1.1];
    elseif T2(i) == 8
        x0 = [10; 0.6; 33; 1];
    elseif T2(i) == 10
        x0 = [14; 0.7; 65; 1.15];
    elseif T2(i) == 20
        x0 = [37; 0.5; 364; 1.45];
    elseif T2(i) == 50
        x0 = [61; 0.25; 1500; 1];
    elseif T2(i) == 100
        x0 = [3878; 60; 20000; 4];
    elseif T2(i) == 200
        x0 = [139; 0.27; 15000; 0.6];
    elseif T2(i) == 200
        x0 = [81134; 1188; 491150; 4];
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
    
    T = num2str(T2(i));
    S = strcat(('T = '), (' '), T);
    
    figure(i)
    plot(t, y(:,2), t, y(:,3))
    grid on
    title(S);
    xlabel('Time')
    ylabel('Value')
    legend('Output value', 'Set value')
    
end