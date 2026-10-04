% =========================================================================
% MATLAB Script: Load Cell Calibration Curve (Calibration_plot_Final)
% =========================================================================
clear; clc; close all;

% 1. กำหนดตำแหน่งไฟล์ Excel
cal_file = 'C:\Users\pakon\OneDrive\Desktop\RMX\Lab_Loarcell\Loadcell_Calibration_Report.xlsx';

% 2. อ่านข้อมูลจากแผ่นงาน Raw_Data_3Runs
data_cal = readmatrix(cal_file, 'Sheet', 'Raw_Data_3Runs');
Y_cal    = data_cal(:, 1); % Actual W (g) - คอลัมน์ 1
X_cal    = data_cal(:, 4); % V_AVR (V)    - คอลัมน์ 4

% กรองเฉพาะจุดข้อมูลที่เป็นตัวเลข (ไม่รวม NaN)
idx_cal  = ~isnan(X_cal) & ~isnan(Y_cal);
X_cal    = X_cal(idx_cal);
Y_cal    = Y_cal(idx_cal);

% 3. คำนวณความชัน (m) จุดตัดแกน Y (c) และ R^2
p = polyfit(X_cal, Y_cal, 1);
m = p(1);
c = p(2);
Y_cal_calc = polyval(p, X_cal);

% คำนวณ R^2
SS_tot = sum((Y_cal - mean(Y_cal)).^2);
SS_res = sum((Y_cal - Y_cal_calc).^2);
R2     = 1 - (SS_res / SS_tot);

% =========================================================================
% 4. พล็อตกราฟ Calibration Curve
% =========================================================================
figure('Name', 'Calibration Curve', 'Color', 'w', 'Position', [100, 100, 1000, 600]);

% พล็อตจุดข้อมูลจากการทดลอง (เพิ่มขนาดจุดเป็น 60 เพื่อให้สมดุลกับขนาดอักษร 18)
scatter(X_cal, Y_cal, 60, 'b', 'filled', 'DisplayName', 'Calibration Data');
hold on;

% พล็อตเส้นตรงสมการการถดถอย (ปรับความหนาเส้น LineWidth = 2)
plot(X_cal, Y_cal_calc, 'r-', 'LineWidth', 2, 'DisplayName', 'Linear Fit');

% ตั้งค่าชื่อแกน หัวข้อ และสเกลแกน (ปรับ FontSize = 18)
title('1. Calibration Curve', 'FontWeight', 'bold', 'FontSize', 18);
xlabel('V_{AVR} (V)', 'FontWeight', 'bold', 'FontSize', 18);
ylabel('Actual W (g)', 'FontWeight', 'bold', 'FontSize', 18);
xlim([0, 3.5]);
ylim([0, 8000]);
set(gca, 'FontSize', 18, 'LineWidth', 1.2); % ปรับขนาดตัวเลขสเกลบนแกนเป็น 18
grid on;
grid minor;
% Legend มุมซ้ายบน (ปรับ FontSize = 18)
legend('Location', 'northwest', 'FontSize', 18);

% กล่องข้อความแสดงสมการและ R^2 (ปรับ FontSize = 18 และขยายขนาดกล่องให้พอดี)
if c >= 0
    str_eq = sprintf('y = %.4f x + %.4f\nR^2 = %.4f', m, c, R2);
else
    str_eq = sprintf('y = %.4f x - %.4f\nR^2 = %.4f', m, abs(c), R2);
end

annotation('textbox', [0.18, 0.56, 0.32, 0.20], ...
    'String', str_eq, ...
    'FontSize', 18, ...
    'FontWeight', 'bold', ...
    'BackgroundColor', 'w', ...
    'EdgeColor', 'k');