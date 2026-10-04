% =========================================================================
% MATLAB Script: Calculate and Display Delta V Summary Table
% =========================================================================
clc; clear;

mat_filename = 'static_noise_50pct.mat';
if ~exist(mat_filename, 'file')
    error('ไม่พบไฟล์ %s กรุณารันโค้ดเก็บบันทึกข้อมูลก่อนครับ', mat_filename);
end

load(mat_filename);

% 1. ตัด Transient ช่วง 0.5s แรกออก
idx = (t >= 0.5);
signals       = {vA(idx), vB(idx), vC(idx)};
names         = {'Poten A (A0)', 'Poten B (A1)', 'Poten C (A2)'};
safety_factor = 2.5;

fprintf('===================================================================================\n');
fprintf('                 สรุปการคำนวณ Hysteresis Band Width (Delta V)                     \n');
fprintf('===================================================================================\n');
fprintf('%-15s | %-10s | %-10s | %-10s | %-12s | %-12s\n', ...
        'Device', 'V_avg (V)', 'V_UT (V)', 'V_LT (V)', 'Delta V (V)', 'Delta V (mV)');
fprintf('-----------------------------------------------------------------------------------\n');

for i = 1:3
    v     = signals{i};
    v_avg = mean(v);
    v_pp  = max(v) - min(v);
    
    % คำนวณ Margin (Safety Factor 2.5x และกำหนดขั้นต่ำไว้ที่ 0.05 V)
    margin = max(0.05, (v_pp / 2) * safety_factor);
    
    v_UT    = v_avg + margin;
    v_LT    = v_avg - margin;
    delta_V = v_UT - v_LT; % ค่า Hysteresis Band Width
    
    fprintf('%-15s | %10.4f | %10.4f | %10.4f | %12.4f | %12.2f\n', ...
            names{i}, v_avg, v_UT, v_LT, delta_V, delta_V * 1000);
end
fprintf('===================================================================================\n');