t = 0:0.05:60;
const = 5;
y = const * sin(t);

plot(t, y);
xlabel('Time (s)', 'FontSize', 15);
ylabel('Amplitude (s)', 'FontSize', 15);
xlim([0, 60]);
ylim([-const, const]);
grid on; grid minor;