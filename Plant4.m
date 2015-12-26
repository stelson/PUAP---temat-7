clear all; 
clc;

num = [1];
denum = [1 2 3 4 5];

G = tf(num, denum);
x0 = 20*ones(4, 1);


options = optimset('MaxFunEvals', 250)

[xopt, fopt, flag, iter] = fminsearch(@PIDOptim, x0, options);
P = xopt(1) 
I = xopt(2)
D = xopt(3)
N = xopt(4)