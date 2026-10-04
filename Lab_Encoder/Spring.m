k = 3;
m = 2;

t = out.simout.Time;
x = out.simout.Data;

%{
plot(t, x, 'r-', 'LineWidth', 5);

grid on; 
set(gca, 'Fontsize', 12);
grid minor;
set(gca, 'Linewidth', 1.5);

title('Undamped Oscillation', 'FontSize', 20);
xlabel('Time(t)', 'FontSize', 14);
ylabel('Displacement (x)', 'FontSize', 14);

xlim([0, 30]); xticks(0:1:30);
ylim([-max(x), max(x)]); yticks(-max(x):1:max(x));
%}

sym x(t) m k f