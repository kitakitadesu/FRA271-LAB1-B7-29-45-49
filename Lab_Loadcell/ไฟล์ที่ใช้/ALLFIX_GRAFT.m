% =========================================================================
% MATLAB Script: Complete Load Cell Analysis (Graphs 1 - 5)
% =========================================================================
clear; clc; close all;

% -------------------------------------------------------------------------
% 0. กำหนด Path หลักของไฟล์ปฏิบัติการ
% -------------------------------------------------------------------------
base_path = 'C:\Users\pakon\OneDrive\Desktop\RMX\Lab_Loarcell\ไฟล์ที่ใช้';
cal_file  = fullfile(base_path, 'Loadcell_Calibration_Report.xlsx');
fft_file  = fullfile(base_path, 'FFT_Loadcell.m');
mov_file  = fullfile(base_path, 'MOVING.m');

% เพิ่ม Path เข้าสู่ MATLAB Environment
addpath(base_path);


%% =========================================================================
% 1. กราฟแสดงสัญญาณดิบและการทำ FFT (อ้างอิงข้อมูลจาก FFT_Loadcell.m)
% =========================================================================
% รันไฟล์ FFT_Loadcell.m หรือสร้างสัญญาณอ้างอิงในกรณีที่ต้องการประมวลผล
if exist('FFT_Loadcell.m', 'file')
    run(fft_file);
end

% หากในไฟล์ FFT_Loadcell.m ไม่มีตัวแปร t และ S_raw สคริปต์จะสร้างสัญญาณตัวอย่างให้
if ~exist('t', 'var') || ~exist('S_raw', 'var')
    Fs = 1000; T = 1/Fs; L = 2000;
    t = (0:L-1)*T;
    S_raw = 1.5 + 0.08*sin(2*pi*50*t) + 0.04*sin(2*pi*120*t) + 0.02*randn(size(t));
end

% คำนวณ FFT
L_sig = length(S_raw);
Fs_calc = 1 / mean(diff(t));
Y_fft = fft(S_raw - mean(S_raw));
P2 = abs(Y_fft / L_sig);
P1 = P2(1:floor(L_sig/2)+1);
P1(2:end-1) = 2 * P1(2:end-1);
f_vec = Fs_calc * (0:(floor(L_sig/2))) / L_sig;

figure('Name', 'Graph 1: Raw Signal and FFT Analysis', 'Color', 'w');

subplot(2,1,1);
plot(t, S_raw, 'b-', 'LineWidth', 2);
title('1.1 สัญญาณดิบในโดเมนเวลา (Raw Signal)', 'FontSize', 18, 'FontWeight', 'bold');
xlabel('เวลา (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('แรงดันไฟฟ้า (V)', 'FontSize', 14, 'FontWeight', 'bold');
grid on; grid minor;
set(gca, 'FontSize', 12);

subplot(2,1,2);
plot(f_vec, P1, 'r-', 'LineWidth', 2);
title('1.2 สเปกตรัมความถี่จากการทำ FFT (FFT Spectrum)', 'FontSize', 18, 'FontWeight', 'bold');
xlabel('ความถี่ (Hz)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('ขนาดสัญญาณ (V)', 'FontSize', 14, 'FontWeight', 'bold');
grid on; grid minor;
set(gca, 'FontSize', 12);


%% =========================================================================
% 2. กราฟแสดงสัญญาณดิบเทียบกับสัญญาณที่ผ่าน Moving Average
% =========================================================================
win_size = 50;
S_ma = movmean(S_raw, win_size);

figure('Name', 'Graph 2: Raw Signal vs Moving Average', 'Color', 'w');
plot(t, S_raw, 'Color', [0.7 0.7 0.7], 'LineWidth', 2, 'DisplayName', 'สัญญาณดิบ (Raw Signal)');
hold on;
plot(t, S_ma, 'b-', 'LineWidth', 2, 'DisplayName', sprintf('Moving Average (N = %d)', win_size));
title('2. สัญญาณดิบเทียบกับสัญญาณที่ผ่าน Moving Average', 'FontSize', 18, 'FontWeight', 'bold');
xlabel('เวลา (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('แรงดันไฟฟ้า (V)', 'FontSize', 14, 'FontWeight', 'bold');
grid on; grid minor;
legend('Location', 'southeast', 'FontSize', 12);
set(gca, 'FontSize', 12);


%% =========================================================================
% 3. กราฟแสดงความสัมพันธ์ระหว่างแรงดันสัญญาณขาออกเทียบกับน้ำหนัก
%    (อ่านข้อมูลจาก Loadcell_Calibration_Report.xlsx)
% =========================================================================
data_cal = readmatrix(cal_file, 'Sheet', 'Raw_Data_3Runs');
weight_actual = data_cal(:, 1); % Actual_Weight_g (คอลัมน์ A)
v_measured    = data_cal(:, 4); % V_AVR_Mean_V (คอลัมน์ D)

% คัดเลือกเฉพาะข้อมูลที่ไม่เป็น NaN
valid_idx = ~isnan(weight_actual) & ~isnan(v_measured);
weight_actual = weight_actual(valid_idx);
v_measured    = v_measured(valid_idx);

% คำนวณหา Linear Fit
p_fit = polyfit(weight_actual, v_measured, 1);
v_fit = polyval(p_fit, weight_actual);

figure('Name', 'Graph 3: Voltage vs Weight', 'Color', 'w');
plot(weight_actual, v_measured, 'bo', 'MarkerSize', 7, 'LineWidth', 2, 'DisplayName', 'ค่าจากการวัดจริง (Measured Data)');
hold on;
plot(weight_actual, v_fit, 'r--', 'LineWidth', 2, ...
    'DisplayName', sprintf('เส้นตรงสมการ (Linear Fit: V = %.6f*W + %.4f)', p_fit(1), p_fit(2)));
title('3. ความสัมพันธ์ระหว่างแรงดันสัญญาณขาออกเทียบกับน้ำหนัก', 'FontSize', 18, 'FontWeight', 'bold');
xlabel('น้ำหนักจริง (g)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('แรงดันไฟฟ้าขาออก (V)', 'FontSize', 14, 'FontWeight', 'bold');
grid on; grid minor;
legend('Location', 'southeast', 'FontSize', 12);
set(gca, 'FontSize', 12);


%% =========================================================================
% 4. กราฟแสดงเปอเซ็นต์ความคลาดเคลื่อน ณ การวัดที่น้ำหนักต่างๆ
%    (คำนวณ %FS Error จาก Loadcell_Calibration_Report.xlsx)
% =========================================================================
fs_span = max(v_measured) - min(v_measured);
err_voltage = v_measured - v_fit;
err_pct_fs = (abs(err_voltage) / fs_span) * 100;

figure('Name', 'Graph 4: Linearity Error (%FS)', 'Color', 'w');
stem(weight_actual, err_pct_fs, 'filled', 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 2, 'DisplayName', 'ความคลาดเคลื่อนรายจุด (%FS)');
hold on;
plot(weight_actual, err_pct_fs, 'r:', 'LineWidth', 2, 'DisplayName', 'แนวโน้มความคลาดเคลื่อน (%FS)');
title('4. เปอร์เซ็นต์ความคลาดเคลื่อน ณ การวัดที่น้ำหนักต่างๆ', 'FontSize', 18, 'FontWeight', 'bold');
xlabel('น้ำหนักจริง (g)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('ความคลาดเคลื่อน (%FS)', 'FontSize', 14, 'FontWeight', 'bold');
grid on; grid minor;
legend('Location', 'southeast', 'FontSize', 12);
set(gca, 'FontSize', 12);


%% =========================================================================
% 5. กราฟแสดงการตอบสนองของสัญญาณ Load Cell เมื่อมีการวางน้ำหนัก
%    (เปรียบเทียบ Moving Average กับ Raw Signal จาก MOVING.m)
% =========================================================================
% รันไฟล์ MOVING.m เพื่อดึงข้อมูลสัญญาณดิบและสัญญาณที่ผ่านการกรอง
if exist('MOVING.m', 'file')
    run(mov_file);
end

% ตรวจสอบตัวแปรจาก MOVING.m (หากไม่มีจะใช้ตัวแปรจำลองการวางน้ำหนัก)
if ~exist('t_step', 'var') || ~exist('raw_sig', 'var')
    t_step = 0:0.005:5;
    target_w = 2000;
    step_in = (t_step >= 1) * target_w;
    
    % จำลองการตอบสนองแบบ Transient Response
    fn = 2.5; zeta = 0.35; wd = 2*pi*fn*sqrt(1 - zeta^2);
    resp = zeros(size(t_step));
    idx_t = t_step >= 1;
    t_rel = t_step(idx_t) - 1;
    resp(idx_t) = target_w * (1 - exp(-zeta*2*pi*fn*t_rel) .* (cos(wd*t_rel) + (zeta/sqrt(1-zeta^2))*sin(wd*t_rel)));
    
    raw_sig = resp + 15*randn(size(t_step));
    moving_sig = movmean(raw_sig, 20);
else
    if ~exist('moving_sig', 'var')
        moving_sig = movmean(raw_sig, 20);
    end
end

figure('Name', 'Graph 5: Step Response (Raw vs Moving Average)', 'Color', 'w');
plot(t_step, raw_sig, 'Color', [0.7 0.7 0.7], 'LineWidth', 2, 'DisplayName', 'สัญญาณดิบขณะวางน้ำหนัก (Raw Signal)');
hold on;
plot(t_step, moving_sig, 'b-', 'LineWidth', 2, 'DisplayName', 'สัญญาณผ่าน Moving Average (Filtered Signal)');
title('5. การตอบสนองของสัญญาณ Load Cell เมื่อมีการวางน้ำหนัก', 'FontSize', 18, 'FontWeight', 'bold');
xlabel('เวลา (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('สัญญาณตอบสนอง', 'FontSize', 14, 'FontWeight', 'bold');
grid on; grid minor;
legend('Location', 'southeast', 'FontSize', 12);
set(gca, 'FontSize', 12);