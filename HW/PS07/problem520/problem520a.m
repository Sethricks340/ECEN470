% Problem 5.20 b
clf;
sys = tf([1 3], [1 5 9 5 0]);
[r, k] = rlocus(sys, 0:0.1:50); 

rlocus(sys); grid on; hold on;

for i = 1:length(k)
    
    idx = find(abs(real(r(:, i))) < 1e-3);
    
    if ~isempty(idx)
        fprintf('Imaginary crossing at K = %.2f | Pole = %.4fi\n', k(i), imag(r(idx(1), i)));
    end
end
hold off;