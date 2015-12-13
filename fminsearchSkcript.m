clear all; 
clc;
G = zpk([], [-1, -1], 1);
[zG, pG, kG] = zpkdata(G, 'v');
x0 = 20*ones(4, 1);
[xopt, fopt, flag, iter] = fminsearch(@PIDOptim, x0);
P = xopt(1) 
I = xopt(2)
D = xopt(3)
N = xopt(4)