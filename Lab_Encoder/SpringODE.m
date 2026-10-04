syms x(t) m k F

eqn = m*diff(x, t, 2) + k * x == F;
dx = diff(x, t);

cond1 = x(0) == 5;
cond2 = dx(0) == 0;
conds = [cond1, cond2];

sol_x = dsolve(eqn, conds);

m_val = 1;
k_val = 10;
F_val = 0;

sol_x_numeric = subs(sol_x, [m, k, F], [m_val, k_val, F_val]);
dx = diff(x, t);

fplot(sol_x_numeric, [0, 10], 'b-', 'LineWidth', 1.5);
grid on;

title('System Response: Displacement Vs Time');
xlabel('Time, t (s)');
ylabel('Displacement, x(t) (m)');