%% Complete Loadcell FFT Analysis & Excel Export Script
clear; clc; close all;

% =========================================================================
% 1. เช็คและล็อกข้อมูล (รัน Simulink แค่ครั้งแรก หรือเมื่อ force_rerun = true)
% =========================================================================
model_name     = 'Lab_Loadcell';            % ชื่อไฟล์ Simulink (.slx)
data_filename  = 'fixed_loadcell_data.mat'; % ไฟล์สแนปชอตล็อกข้อมูล
excel_filename = 'Loadcell_FFT_Data.xlsx';  % ชื่อไฟล์ Excel ที่ต้องการส่งออก
force_rerun    = false;                     % true = รันใหม่, false = ดึงข้อมูลเดิม

if ~exist(data_filename, 'file') || force_rerun
    fprintf('กำลังรัน Simulink (%s) เพื่อเก็บข้อมูลใหม่...\n', model_name);
    
    load_system(model_name);
    set_param(model_name, 'StopTime', '10');
    set_param(model_name, 'SolverType', 'Fixed-step');
    set_param(model_name, 'FixedStep', '0.001');
    
    out = sim(model_name);
    save(data_filename, 'out');
    fprintf('บันทึกข้อมูลลงไฟล์ %s เรียบร้อยแล้ว!\n', data_filename);
else
    fprintf('โหลดข้อมูลเดิมจากไฟล์ %s...\n', data_filename);
    load(data_filename, 'out');
end

% =========================================================================
% 2. ดึงข้อมูล Raw Signal (Time & Voltage) จาก out.simout
% =========================================================================
if isa(out.simout, 'timeseries')
    time_data   = out.simout.Time;
    signal_vals = out.simout.Data;
elseif isprop(out.simout, 'Values') 
    time_data   = out.simout.Values.Time;
    signal_vals = out.simout.Values.Data;
elseif isstruct(out.simout)
    time_data   = out.simout.time;
    signal_vals = out.simout.signals.values;
else
    time_data   = out.tout;
    signal_vals = out.simout;
end

signal_vals = signal_vals(:);
time_data   = time_data(:);

% =========================================================================
% 3. คำนวณ FFT ของสัญญาณแรงดันไฟฟ้า (Volt)
% =========================================================================
Ts = 0.001;               % Sampling time (1 ms)
Fs = 1/Ts;                % Sampling frequency (1000 Hz)
L  = length(signal_vals);  % จำนวนจุดข้อมูลทั้งหมด

% คำนวณ FFT และ Single-sided Amplitude Spectrum
Y  = fft(signal_vals);
P2 = abs(Y/L);
P1 = P2(1:floor(L/2)+1);
P1(2:end-1) = 2*P1(2:end-1);

% สร้างแกนความถี่ (0 ถึง Nyquist Frequency: Fs/2)
f  = Fs*(0:(floor(L/2)))/L;

% =========================================================================
% 4. พล็อตกราฟแสดงผล (Time Domain & FFT Spectrum)
% =========================================================================
figure('Name', 'Loadcell Voltage & FFT Analysis', 'Color', [1 1 1]);

% --- กราฟโดเมนเวลา ---
subplot(2,1,1);
plot(time_data, signal_vals, 'b-', 'LineWidth', 1);
title('สัญญาณแรงดันไฟฟ้าดิบจาก Loadcell (Time Domain)');
xlabel('เวลา (วินาที)');
ylabel('แรงดันไฟฟ้า (V)');
xlim([0, max(time_data)]);
grid on;

% --- กราฟโดเมนความถี่ ---
subplot(2,1,2);
plot(f, P1, 'r-', 'LineWidth', 1);
title('สเปกตรัมความถี่ของสัญญาณแรงดันไฟฟ้า (FFT Spectrum)');
xlabel('ความถี่ (Hz)');
ylabel('แอมพลิจูด (V)');
xlim([0, Fs/2]);
grid on;
drawnow;

% =========================================================================
% 5. แปลงและส่งออกข้อมูลลงไฟล์ Excel (.xlsx)
% =========================================================================
% 5.1 ตารางสัญญาณโดเมนเวลา
T_time = table(time_data, signal_vals, ...
    'VariableNames', {'Time_sec', 'Voltage_V'});

% 5.2 ตารางสเปกตรัมความถี่ FFT
T_fft = table(f(:), P1(:), ...
    'VariableNames', {'Frequency_Hz', 'Amplitude_V'});

% 5.3 บันทึกลง Excel แยก Sheet
writetable(T_time, excel_filename, 'Sheet', 'Time_Domain');
writetable(T_fft, excel_filename, 'Sheet', 'FFT_Spectrum');

fprintf('\n[SUCCESS] ส่งออกข้อมูลลงไฟล์ Excel "%s" เรียบร้อยแล้ว!\n', excel_filename);
fprintf('  - Sheet 1: "Time_Domain"  (เก็บ Time_sec และ Voltage_V)\n');
fprintf('  - Sheet 2: "FFT_Spectrum" (เก็บ Frequency_Hz และ Amplitude_V)\n');