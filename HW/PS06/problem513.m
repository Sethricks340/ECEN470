% Problem 5.13 

clf;
s = tf('s');
sys = ((s+1)*(s^2+81)) / ((s+13)*(s^2)*(s^2+100));
K = 88.2;

fig_rl = figure;
rlocus(sys);
grid on;

fig_step = figure;
step(T);
grid on;
title(sprintf('Closed-Loop Step Response for K = %.2f', K));