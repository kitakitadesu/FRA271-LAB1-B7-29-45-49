% Example if the actual signal is stored in `v`

t = out.vout.Time;
v = out.vout.Data;

idx = (t >= 0.5) & (t <= 10);
v_steady = v(idx);

v_noise_p2p = max(v_steady) - min(v_steady)

fprintf('Peak-to-Peak Magnitude = %.2f mV\n', v_noise_p2p);

%{
plot(t, v, 'LineWidth', 3);
grid on;
set(gca, 'FontSize', 18)
grid minor
set(gca, 'LineWidth', 1.5)
xlabel('Time (t)', 'FontSize', 14);
ylabel('Displacement (x)', 'FontSize', 14,);
%}