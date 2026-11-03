num = [1 3];
den = conv([1 1], conv([1 2], [1 4])); % (s+1)(s+2)(s+4)
sys = tf(num, den);
figure;
rlocus(sys);
grid on;
title('Root Locus: Poles at -1, -2, -4 | Zero at -3');