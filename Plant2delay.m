clear all; 
clc;

num = [1];
denum = [1 2 1];

G = tf(num, denum);
x0 = 2*ones(4, 1);

options = optimset('MaxFunEvals', 50)

[xopt, fopt, flag, iter] = fminsearch(@PIDOptim, x0, options);
P = xopt(1) 
I = xopt(2)
D = xopt(3)
N = xopt(4)