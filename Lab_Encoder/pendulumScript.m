m = 1;
g = 10;
L = 1;
J = m*L^2;
b = 2*(m*g*J*L)^0.5;

t = out.simout.Time;
a = out.simout.Data;

plot(t, a, 'LineWidth', 2);

grid on;
set(gca, 'FontSize', 15);
grid minor;

title('Pendulum Response', 'FontSize', 25);
xlabel('Time (s)', 'FontSize', 14);
ylabel('Angular Displacement (rad)', 'FontSize', 14);

xlim([0, max(t)]); xticks(0:1:max(t));
ylim([-max(a)-0.1, max(a)+0.1]); yticks(-max(a)-0.1:0.1:max(a)+0.1);