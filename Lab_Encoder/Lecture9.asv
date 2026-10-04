m = 5;
k = 2000;
b = 0;
alpha = 2;
F0 = 10;
wf = 10;

ode_eqn = @(t,Y,b,alpha,wf)[Y(2); (1/m)*(F0*sin(wf*t)-b*Y(2)-k*Y(1)-alpha*Y(1)^3)];
tspan = [0 20];
y0 = [0; 0];

% Resonance in different situations
undamped = @(t,Y) ode_eqn(t,Y,0,0,wf);
damped   = @(t,Y) ode_eqn(t,Y,2,0,wf);
harden   = @(t,Y) ode_eqn(t,Y,2,1000*2,wf);

[t_undamped, sol_undamped] = ode45(undamped, tspan, y0);
[t_damped, sol_damped] = ode45(damped, tspan, y0);
[t_harden, sol_harden] = ode45(harden, tspan, y0);

% Non Resonance Steady Response
constant = @(t,Y) ode_eqn(t,Y,0,5 ,10);
[t_const, sol_const] = ode45(constant, tspan, [0, 0]);

figure(1);
subplot(1,3,1);
plot(t_undamped, sol_undamped(:,1),'r', 'LineWidth', 2.5);
xlabel('Time(s)', 'FontSize', 20);
ylabel('Displacement(m)', 'FontSize', 14);
title('Undamped Resonance (b=0, alpha=0)', 'FontSize', 15);
grid on; grid minor;

subplot(1,3,2);
plot(t_damped, sol_damped(:,1),'r', 'LineWidth', 2.5);
xlabel('Time(s)', 'FontSize', 14);
ylabel('Displacement(m)', 'FontSize', 14);
title('Damped Resonance (b>0, alpha=0)', 'FontSize', 15);
grid on; grid minor;

subplot(1,3,3);
plot(t_harden, sol_harden(:,1),'r', 'LineWidth', 2.5);
xlabel('Time(s)', 'FontSize', 14);
ylabel('Displacement(m)', 'FontSize', 14);
title('Hardening Spring (b>0, alpha=1000*b)', 'FontSize', 15);
grid on; grid minor;

figure(2);
plot(t_const, sol_const(:,1),'r', 'LineWidth', 2.5);
xlabel('Time(s)', 'FontSize', 14);
ylabel('Displacement(m)', 'FontSize', 14);
title('Non-Resonant Steady-State Response', 'FontSize', 15);
grid on; grid minor;