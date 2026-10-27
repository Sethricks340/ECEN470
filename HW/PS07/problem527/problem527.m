% Problem 5.27
% Design lag compensator Dc(s) = k * (s+z) / (s+p), G(s) = 1/(s(s+2))
% Requirement: s = -1 +- j, ess < 0.2
clear; clc;
wn = sqrt(2);
zeta = 1/sqrt(2); % 0.707
s = tf('s');
G = 1/(s*(s+2));

% % Step 2 - Plot uncompensated root locus
figure(1);
rlocus(G);
title('Uncompensated Root Locus');

% % Step 3 - Pick lag compensator values
z_lag = wn / 200;
p_lag = z_lag / 5;
D_lag = (s + z_lag)/(s + p_lag);

% % Step 4 - Find gain K and achieved pole programmatically FIRST
s_target = -1 + 1j;
k_vec = linspace(0, 20, 50000);
[r, k] = rlocus(D_lag * G, k_vec);

[min_dist, idx_linear] = min(abs(r(:) - s_target));
[row, col] = ind2sub(size(r), idx_linear);

K_exact = k(col);
achieved_pole = r(row, col);

% Display verification results in Command Window
fprintf('\n--- Root Locus Verification ---\n');
fprintf('Target Pole:    %.4f + %.4fi\n', real(s_target), imag(s_target));
fprintf('Achieved Pole:  %.4f + %.4fi\n', real(achieved_pole), imag(achieved_pole));
fprintf('Required Gain:  K = %.4f\n', K_exact);
fprintf('Distance Error: %.6f\n', min_dist);

if min_dist < 0.05
    fprintf('SUCCESS: The root locus passes through s = -1 + j!\n');
else
    fprintf('WARNING: The root locus misses s = -1 + j (Error too large).\n');
end

% % Step 5 - Plot Compensated Root Locus with Expanded Axis Limits
figure(2);
rlocus(D_lag * G);
sgrid(zeta, wn);
hold on;

% Set axis limits so s = -1 + j is centered nicely
xlim([-2.5, 0.5]);
ylim([-1.5, 1.5]);

% Plot the achieved pole marker
h_pole = plot(real(achieved_pole), imag(achieved_pole), 'ro', 'MarkerSize', 8, 'LineWidth', 2);

% Add Data Tip showing Gain and Pole
row_gain = dataTipTextRow('Gain', repmat(K_exact, size(achieved_pole)));
row_pole = dataTipTextRow('Pole', achieved_pole);
h_pole.DataTipTemplate.DataTipRows(end+1) = row_gain;
h_pole.DataTipTemplate.DataTipRows(end+1) = row_pole;

datatip(h_pole, real(achieved_pole), imag(achieved_pole));
hold off;

% Steady State Error Calculation
K = K_exact;
ess = (2 * p_lag) / (K * z_lag);
fprintf('ess = %.4f\n', ess);