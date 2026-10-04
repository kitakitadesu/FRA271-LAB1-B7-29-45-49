% =========================================================================
% MATLAB Script: Loadcell Calibration & Validation (Separate Figures)
% =========================================================================

% 1. กำหนดตำแหน่งไฟล์ Excel
cal_file = 'C:\Users\pakon\OneDrive\Desktop\RMX\Lab_Loarcell\ไฟล์ที่ใช้\Loadcell_Calibration_Report.xlsx';
val_file = 'C:\Users\pakon\OneDrive\Desktop\RMX\Lab_Loarcell\ไฟล์ที่ใช้\Loadcell_Validation_Report.xlsx';

% -------------------------------------------------------------------------
% 2. อ่านและประมวลผลข้อมูล Calibration
% -------------------------------------------------------------------------
data_cal = readmatrix(cal_file);
Y_cal    = data_cal(:, 1); % Actual W (คอลัมน์ A)
X_cal    = data_cal(:, 4); % V_AVR (คอลัมน์ D)
idx_cal  = ~isnan(X_cal) & ~isnan(Y_cal);
X_cal    = X_cal(idx_cal);
Y_cal    = Y_cal(idx_cal);

% Close the Excel file first, then run:
data_cal = readmatrix(cal_file);
% คำนวณความชัน (m) และจุดตัด (c)
p = polyfit(X_cal, Y_cal, 1);
m = p(1);
c = p(2);
Y_cal_calc = polyval(p, X_cal);
Error_cal  = Y_cal_calc - Y_cal;

% คำนวณ R^2
SS_tot = sum((Y_cal - mean(Y_cal)).^2);
SS_res = sum((Y_cal - Y_cal_calc).^2);
R2     = 1 - (SS_res / SS_tot);

% -------------------------------------------------------------------------
% 3. อ่านและประมวลผลข้อมูล Validation
% -------------------------------------------------------------------------
data_val     = readmatrix(val_file);
Y_val_actual = data_val(:, 1); % Actual W (คอลัมน์ A)
X_val_vavr   = data_val(:, 4); % V_AVR (คอลัมน์ D)
idx_val      = ~isnan(X_val_vavr) & ~isnan(Y_val_actual);
X_val_vavr   = X_val_vavr(idx_val);
Y_val_actual = Y_val_actual(idx_val);

% 3.1 คำนวณแบบไม่ Set 0 (Raw Calculation)
Y_val_calc_raw = polyval(p, X_val_vavr);
Error_val_raw  = Y_val_calc_raw - Y_val_actual;

% 3.2 คำนวณแบบ Set 0 (Tare Adjustment in Gram Space)
V_zero          = X_val_vavr(1); 
W_zero          = polyval(p, V_zero); 
Y_val_calc_set0 = Y_val_calc_raw - W_zero;
Error_val_set0  = Y_val_calc_set0 - Y_val_actual;

% -------------------------------------------------------------------------
% 4. แสดงผลการคำนวณใน Command Window
% -------------------------------------------------------------------------
disp('===================================================');
disp('            สรุปผลการวิเคราะห์ข้อมูล LOADCELL        ');
disp('===================================================');
fprintf('สมการ Calibration : y = %.4f * x + (%.4f)\n', m, c);
fprintf('ค่า R^2            : %.6f\n', R2);
fprintf('แรงดัน Set 0 (V0)  : %.6f V (Offset = %.4f g)\n', V_zero, W_zero);
fprintf('RMSE Validation (ก่อน Set 0) : %.4f กรัม\n', sqrt(mean(Error_val_raw.^2)));
fprintf('RMSE Validation (หลัง Set 0)  : %.4f กรัม\n', sqrt(mean(Error_val_set0.^2)));
disp('---------------------------------------------------');

% =========================================================================
% 5. พล็อตกราฟแยกแต่ละรูป (Separate Figures)
% =========================================================================

% --- FIGURE 1: Calibration Curve ---
figure('Name', 'Figure 1: Calibration Curve', 'Color', 'w');
scatter(X_cal, Y_cal, 50, 'b', 'filled', 'DisplayName', 'Calibration Data');
hold on;
plot(X_cal, Y_cal_calc, 'r-', 'LineWidth', 1.8, 'DisplayName', 'Linear Fit');
xlabel('V_{AVR} (V)', 'FontWeight', 'bold', 'FontSize', 13);
ylabel('Actual W (g)', 'FontWeight', 'bold', 'FontSize', 13);
title('1. Calibration Curve', 'FontWeight', 'bold', 'FontSize', 16); % เพิ่มขนาดหัวข้อเป็น 16
set(gca, 'FontSize', 11);
grid on;
legend('Location', 'northwest', 'FontSize', 11);

if c >= 0
    str_eq = sprintf('y = %.4f x + %.4f\nR^2 = %.4f', m, c, R2);
else
    str_eq = sprintf('y = %.4f x - %.4f\nR^2 = %.4f', m, abs(c), R2);
end
annotation('textbox', [0.18, 0.70, 0.28, 0.14], 'String', str_eq, ...
    'FontSize', 12, 'FontWeight', 'bold', 'BackgroundColor', [1 1 1 0.85], 'EdgeColor', 'k');

% --- FIGURE 2: Calibration Residual Error ---
figure('Name', 'Figure 2: Calibration Residual Error', 'Color', 'w');
stem(Y_cal, Error_cal, 'filled', 'Color', [0 0.4470 0.7410], 'LineWidth', 1.2);
yline(0, '--k', 'LineWidth', 1);
xlabel('Actual Weight (g)', 'FontWeight', 'bold', 'FontSize', 13);
ylabel('Error (g)', 'FontWeight', 'bold', 'FontSize', 13);
title('2. Calibration Residual Error (Calc - Actual)', 'FontWeight', 'bold', 'FontSize', 16); % เพิ่มขนาดหัวข้อเป็น 16
set(gca, 'FontSize', 11);
grid on;

% --- FIGURE 3: Calibration vs Validation Data Points ---
figure('Name', 'Figure 3: Calibration vs Validation Data', 'Color', 'w');
plot(X_cal, Y_cal_calc, 'k--', 'LineWidth', 1.2, 'DisplayName', 'Calibration Line');
hold on;
scatter(X_cal, Y_cal, 40, 'b', 'filled', 'DisplayName', 'Calibration Points');
scatter(X_val_vavr, Y_val_actual, 60, 'm', 'd', 'filled', 'DisplayName', 'Validation Points');
xlabel('V_{AVR} (V)', 'FontWeight', 'bold', 'FontSize', 13);
ylabel('Actual W (g)', 'FontWeight', 'bold', 'FontSize', 13);
title('3. Load Cell Calibration vs Validation Data Points', 'FontWeight', 'bold', 'FontSize', 16); % เพิ่มขนาดหัวข้อเป็น 16
set(gca, 'FontSize', 11);
grid on;
legend('Location', 'northwest', 'FontSize', 11);

% --- FIGURE 4: Validation Predictions (Raw vs Set 0) ---
figure('Name', 'Figure 4: Validation Predictions', 'Color', 'w');
scatter(X_val_vavr, Y_val_actual, 70, 'k', 'filled', 'DisplayName', 'Actual Weight');
hold on;
scatter(X_val_vavr, Y_val_calc_raw, 50, 'r', 'o', 'LineWidth', 1.5, 'DisplayName', 'Raw Calc (No Set 0)');
scatter(X_val_vavr, Y_val_calc_set0, 50, [0 0.6 0], '^', 'filled', 'DisplayName', 'Set 0 Calc (Tared)');
xlabel('V_{AVR} (V)', 'FontWeight', 'bold', 'FontSize', 13);
ylabel('Weight (g)', 'FontWeight', 'bold', 'FontSize', 13);
title('4. Validation: Raw Prediction vs Set 0 (Tare)', 'FontWeight', 'bold', 'FontSize', 16); % เพิ่มขนาดหัวข้อเป็น 16
set(gca, 'FontSize', 11);
grid on;
legend('Location', 'northwest', 'FontSize', 11);

% --- FIGURE 5: Validation Residual Error Comparison Bar Chart ---
figure('Name', 'Figure 5: Validation Residual Error Comparison', 'Color', 'w');
b = bar(Y_val_actual, [Error_val_raw, Error_val_set0], 'grouped');
b(1).FaceColor = [0.8500 0.3250 0.0980]; % สีส้ม: Raw Error
b(2).FaceColor = [0.4660 0.6740 0.1880]; % สีเขียว: Set 0 Error
yline(0, '--k', 'LineWidth', 1);
xlabel('Actual Weight (g)', 'FontWeight', 'bold', 'FontSize', 13);
ylabel('Validation Error (g)', 'FontWeight', 'bold', 'FontSize', 13);
title('5. Validation Error Comparison: Raw vs Set 0', 'FontWeight', 'bold', 'FontSize', 16); % เพิ่มขนาดหัวข้อเป็น 16
set(gca, 'FontSize', 11);
legend({'Raw Error (No Set 0)', 'Set 0 Error'}, 'Location', 'northeast', 'FontSize', 11);
grid on;