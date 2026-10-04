t = out.simout.Time;
x = out.simout.Data;

k = 4;
m = 3;

plot(t, x, 'LineWidth', 3);

grid on; grid minor;
xlabel('Time(t)', 'FontSize', 14);
ylabel('Displacement (x)', 'FontSize', 14);