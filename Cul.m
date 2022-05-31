clc;clear;close all;
c=3*10^5;%光速
Mpc=10^6*3.26;%单位取光年
H0_r=70/Mpc;
H0_t=70/(Mpc*3*10^5);
syms z;%z代表红移
r = @(z) c./(H0_r.*(0.3.*(1+z).^3+0.00001.*(1+z).^4+0.7).^0.5);
t = @(z) 1./((1+z).*H0_t.*(0.3.*(1+z).^3+0.00001.*(1+z).^4+0.7).^0.5);
% 宇宙微波背景辐射的红移量为inf
X = integral(r,0,inf);
T = integral(t,0,inf);
disp(X)
disp(T)