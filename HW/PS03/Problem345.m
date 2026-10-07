% Define the Laplace variable s
s = tf('s');

% Define the five transfer functions
G1 = 40 / (s^2 + 4*s + 40);
G2 = 40 / ((s + 1) * (s^2 + 4*s + 40));
G3 = 120 / ((s + 3) * (s^2 + 4*s + 40));
G4 = (20 * (s + 2)) / ((s + 1) * (s^2 + 4*s + 40));
G5 = ((36040/401) * (s^2 + s + 401)) / ((s^2 + 4*s + 40) * (s^2 + s + 901));

% Plot all step responses together for comparison
figure;
% step(G1, G2, G3, G4, G5);
step(G1, G2, G3, G4, G5);
legend('G_1(s)', 'G_2(s)', 'G_3(s)', 'G_4(s)', 'G_5(s)', 'Location', 'best');
grid on;
title('Step Responses of Transfer Functions');
