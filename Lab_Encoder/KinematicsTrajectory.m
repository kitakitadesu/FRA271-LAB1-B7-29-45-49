%Input Parameters
t_measured = [0, 0.12, 0.35, 0.40, 0.85, 1.20, 1.55, 1.90, 2.10, 2.80, 3.25, 3.70, 4.15, 4.80, 5.20, 5.75, 6.28];
t_fine = linspace(min(t_measured), max(t_measured), 200);

v_sensor = [
    0.82,  0.75,  0.41,  0.30, -0.21, -0.85, -1.10, -0.62, -0.15,  0.78,  1.05,  0.52, -0.12, -0.74, -0.92, -0.45,  0.10;
    0.15,  0.22,  0.48,  0.51,  0.88,  0.62,  0.11, -0.35, -0.58, -0.90, -0.65, -0.18,  0.32,  0.71,  0.85,  0.42,  0.05;
    -0.08, -0.12, -0.25, -0.28, -0.41, -0.55, -0.38, -0.10,  0.22,  0.61,  0.82,  0.70,  0.45,  0.12, -0.22, -0.38, -0.15];

%Joint Equation
theta_1 = sin(t_fine) + 0.5 .* cos(2* t_fine);
theta_2 = 2 * sin(1.5 * t_fine) - 0.2 * t_fine;
theta_3 = cos(t_fine) .* exp(-0.1 * t_fine);

%Trajectory
end_effector = [0.8 0.1 -0.2; 0.2 0.7 0.3; -0.1 0.4 0.9] * [theta_1; theta_2; theta_3];
x_end = end_effector(1, :);
y_end = end_effector(2, :);
z_end = end_effector(3, :);

%Velocity Error Recovery
k = [1.05 0.02 -0.01; 0.03 0.98 0.04; -0.02 0.01 1.02];
v_actual = k \ v_sensor;

%Data Visualization
plot(t_fine, theta_1, 'r', 'LineWidth', 5);
grid on;  hold on;
plot(t_fine, theta_2, 'b', 'LineWidth', 5);
hold on;
plot(t_fine, theta_3, 'g', 'LineWidth', 5);
hold on;

title('Joint Motion Analysis', 'FontSize', 30);
xlabel('Time (s)', 'FontSize', 15);
ylabel('Angular Position (deg)', 'FontSize', 15);
legend('theta_1', 'theta_2', 'theta_3');
xlim([0, max(t_fine)]);