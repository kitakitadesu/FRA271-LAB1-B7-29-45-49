% Magnet - Hall Distance
t = 0:30:450;
x = (1/150) * t + 1.0;

% Quiescent Voltage Reference (Vq)
vq = 1607; % mV (หรือ 1650 mV ตามสเปกแรงดันจ่าย)

% Shield South
s_s_B = Shield_S{1};
s_s_Vo = Shield_S{2};
s_s_tB = s_s_B.Values.Time; % Magnetic Flux Time Series
s_s_dB = s_s_B.Values.Data; % Magnetic Flux Data Series
s_s_tVo = s_s_Vo.Values.Time; % Vout Time Series
s_s_dVo = s_s_Vo.Values.Data; % Vout Data Series

% Shield North
s_n_B = Shield_N{1};
s_n_Vo = Shield_N{2};
s_n_tB = s_n_B.Values.Time; % Magnetic Flux Time Series
s_n_dB = s_n_B.Values.Data; % Magnetic Flux Data Series
s_n_tVo = s_n_Vo.Values.Time; % Vout Time Series
s_n_dVo = s_n_Vo.Values.Data; % Vout Data Series

% No Shield South
ns_s_B = No_Shield_S{1};
ns_s_Vo = No_Shield_S{2};
ns_s_tB = ns_s_B.Values.Time; % Magnetic Flux Time Series
ns_s_dB = ns_s_B.Values.Data; % Magnetic Flux Data Series
ns_s_tVo = ns_s_Vo.Values.Time; % Vout Time Series
ns_s_dVo = ns_s_Vo.Values.Data; % Vout Data Series

% No Shield North
ns_n_B = No_Shield_N{1};
ns_n_Vo = No_Shield_N{2};
ns_n_tB = ns_n_B.Values.Time; % Magnetic Flux Time Series
ns_n_dB = ns_n_B.Values.Data; % Magnetic Flux Data Series
ns_n_tVo = ns_n_Vo.Values.Time; % Vout Time Series
ns_n_dVo = ns_n_Vo.Values.Data; % Vout Data Series

% Voltage Interpolation & Referencing

% Interpolate raw Vout directly from sensor measurement data
ns_s_dV_raw = interp1(ns_s_tVo, ns_s_dVo, t); % South Vout
ns_n_dV_raw = interp1(ns_n_tVo, ns_n_dVo, t); % North Vout
s_s_dV_raw  = interp1(s_s_tVo, s_s_dVo, t);   % Shielded South Vout
s_n_dV_raw  = interp1(s_n_tVo, s_n_dVo, t);   % Shielded North Vout

% Calculate Vout referenced to Vq according to magnetic poles
ns_s_dVo_at_x = vq + ns_s_dV_raw;
ns_n_dVo_at_x = vq - ns_n_dV_raw;
s_s_dVo_at_x  = vq + s_s_dV_raw;
s_n_dVo_at_x  = vq - s_n_dV_raw;

% Magnetic Interpolation
ns_s_dB_at_x = interp1(ns_s_tB, ns_s_dB, t);
ns_n_dB_at_x = interp1(ns_n_tB, ns_n_dB, t);
s_s_dB_at_x  = interp1(s_s_tB, s_s_dB, t);
s_n_dB_at_x  = interp1(s_n_tB, s_n_dB, t);

% Plot 1: Magnetic Distance Plotting Graph
figure;
subplot(2,2, [1,2]);
plot(x, flip(-ns_n_dB_at_x), '-o', 'Color', 'g', 'LineWidth', 1.5, 'MarkerSize', 5, 'MarkerFaceColor', 'b');
hold on;
plot(x, flip(-s_n_dB_at_x), '-o', 'Color', 'b', 'LineWidth', 1.5, 'MarkerSize', 5, 'MarkerFaceColor', 'b');
xlabel('Distance from sensor to magnet (cm)', 'FontSize', 12);
ylabel('Magnetic Flux Density (mT)', 'FontSize', 12);
title('North Polar Magnetic Flux Density vs Distance', 'FontSize', 16);
legend('No Shield', 'Shield');
grid on; grid minor;                      

subplot(2,2, [3,4]);
plot(x, ns_s_dB_at_x, '-o', 'Color', 'y', 'LineWidth', 1.5, 'MarkerSize', 5, 'MarkerFaceColor', 'b');
hold on;
plot(x, s_s_dB_at_x, '-o', 'Color', 'r', 'LineWidth', 1.5, 'MarkerSize', 5, 'MarkerFaceColor', 'b');
xlabel('Distance from sensor to magnet (cm)', 'FontSize', 12);
ylabel('Magnetic Flux Density (mT)', 'FontSize', 12);
title('South Polar Magnetic Flux Density vs Distance', 'FontSize', 16);
legend('No Shield', 'Shield');
grid on; grid minor;     

% Plot 2: Voltage - Magnetic Flux Density Plotting Graph
figure;
subplot(2,2,[1,2]);


plot(-ns_n_dB_at_x, ns_n_dVo_at_x, '-o', 'Color', 'b', 'LineWidth', 1.5, 'MarkerSize', 5, 'MarkerFaceColor', 'b');
plot(ns_s_dB_at_x, ns_s_dVo_at_x, '-o', 'Color', 'r', 'LineWidth', 1.5, 'MarkerSize', 5, 'MarkerFaceColor', 'b');

x_line = [-max(ns_n_dB_at_x), max(ns_s_dB_at_x)];
plot(x_line, [vq, vq], 'k--', 'LineWidth', 1.2, 'DisplayName', 'Vq');
plot(x_line, [2*vq, 2*vq], 'r--', 'LineWidth', 1.2, 'DisplayName', '2*Vq');
plot(x_line, [0, 0], 'b--', 'LineWidth', 1.2, 'DisplayName', '0V');

xlabel('Magnetic Flux Density (mT)', 'FontSize', 12);
ylabel('Output Voltage (mV)', 'FontSize', 12);
title('No Shield Output Voltage vs Magnetic Flux Density', 'FontSize', 16);
legend('North', 'South','Quosient Voltage (Vq)', 'Supply Voltage (Vcc)', 'Ground/Reference (0mV)');
xlim([-max(ns_n_dB_at_x), max(ns_s_dB_at_x)]);
ylim([0, max(ns_s_dVo_at_x)]);
grid on; grid minor;              

subplot(2,2,[3,4]);
plot(-s_n_dB_at_x, s_n_dVo_at_x, '-o', 'Color', 'b', 'LineWidth', 1.5, 'MarkerSize', 5, 'MarkerFaceColor', 'b');
hold on;
plot(s_s_dB_at_x, s_s_dVo_at_x, '-o', 'Color', 'r', 'LineWidth', 1.5, 'MarkerSize', 5, 'MarkerFaceColor', 'b');

x_line = [-max(s_n_dB_at_x), max(s_s_dB_at_x)];
plot(x_line, [vq, vq], 'k--', 'LineWidth', 1.2, 'DisplayName', 'Vq');
plot(x_line, [2*vq, 2*vq], 'r--', 'LineWidth', 1.2, 'DisplayName', '2*Vq');
plot(x_line, [0, 0], 'b--', 'LineWidth', 1.2, 'DisplayName', '0V');

xlabel('Magnetic Flux Density (mT)', 'FontSize', 12);
ylabel('Output Voltage (mV)', 'FontSize', 12);
title('Shield Polar Output Voltage vs Magnetic Flux Density', 'FontSize', 16);
legend('North', 'South','Quosient Voltage (Vq)', 'Supply Voltage (Vcc)', 'Ground/Reference (0mV)');
xlim([-max(s_n_dB_at_x), max(s_s_dB_at_x)]);
ylim([0, max(s_s_dVo_at_x)]);
grid on; grid minor;       

% Plot 3: Voltage - Distance Plotting Graph
figure;
subplot(2,2,[1,2]);
plot(x, ns_s_dV_raw, 'r-', 'LineWidth', 1.5, 'MarkerSize', 5, 'MarkerFaceColor', 'b');
hold on;
plot(x, ns_n_dV_raw, '-o', 'Color', 'b', 'LineWidth', 1.5, 'MarkerSize', 5, 'MarkerFaceColor', 'b');

x_line = [min(x), max(x)];
plot(x_line, [1812.9, 1812.9], 'k--', 'LineWidth', 1.2, 'DisplayName', 'Vq');
plot(x_line, [vq, vq], 'k--', 'LineWidth', 1.2, 'DisplayName', 'Vq');
plot(x_line, [1550, 1550], 'b--', 'LineWidth', 1.2, 'DisplayName', '0V');

yline(vq, 'k--', 'LineWidth', 1.2, 'HandleVisibility', 'off');
yline(1812.9, 'r--', 'LineWidth', 1.2, 'HandleVisibility', 'off');
yline(max(ns_n_dV_raw), 'b--', 'LineWidth', 1.2, 'HandleVisibility', 'off');

xlabel('Distance from sensor to magnet (cm)', 'FontSize', 12);
ylabel('Output Voltage Vout (mV)', 'FontSize', 12);
title('No Shield Output Voltage vs Distance', 'FontSize', 16);
legend('South', 'North', 'Minimum South Pole Output Voltage', 'Ground/Reference (0mV)','Maximum North Pole Output Voltage');
grid on; grid minor;                      
xlim([1.1, 4.0]);                     

subplot(2,2,[3,4]);
plot(x, s_s_dV_raw, '-o', 'Color', 'r', 'LineWidth', 1.5, 'MarkerSize', 5, 'MarkerFaceColor', 'b');
hold on;
plot(x, s_n_dV_raw, '-o', 'Color', 'b', 'LineWidth', 1.5, 'MarkerSize', 5, 'MarkerFaceColor', 'b');

x_line = [min(x), max(x)];
plot(x_line, [1796.3, 1796.3], 'k--', 'LineWidth', 1.2, 'DisplayName', 'Vq');
plot(x_line, [vq, vq], 'k--', 'LineWidth', 1.2, 'DisplayName', 'Vq');
plot(x_line, [1559.86, 1559.86], 'b--', 'LineWidth', 1.2, 'DisplayName', '0V');

xlabel('Distance from sensor to magnet (cm)', 'FontSize', 12);
ylabel('Output Voltage Vout (mV)', 'FontSize', 12);
title('Shield Output Voltage vs Distance', 'FontSize', 16);
legend('South', 'North', 'Minimum South Pole Output Voltage', 'Ground/Reference (0mV)', 'Maximum North Pole Output Voltage');
grid on; grid minor;                      
xlim([1.2, 4.0]);