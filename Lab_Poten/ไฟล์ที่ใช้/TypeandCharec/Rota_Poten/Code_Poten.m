% =========================================================================
% Automatic Data Logger (Simultaneous A, B, C Logging: 1 Point = 10s)
% =========================================================================
clc; clear; close all;

model_name = 'your_simulink_model_name'; % <<-- เปลี่ยนเป็นชื่อไฟล์ .slx ของคุณ
pos_steps  = 0:5:100;                    % 21 จุดตำแหน่ง (0% ถึง 100%)
num_points = length(pos_steps);
num_trials = 3;                          % จำนวนรอบการทดลอง (3 รอบ)
Fs         = 1000;                       % Sampling frequency (1000 Hz)

% เมทริกซ์เก็บผลลัพธ์ [21 จุด x 3 รอบ]
mean_A = zeros(num_points, num_trials); std_A = zeros(num_points, num_trials);
mean_B = zeros(num_points, num_trials); std_B = zeros(num_points, num_trials);
mean_C = zeros(num_points, num_trials); std_C = zeros(num_points, num_trials);

load_system(model_name);

fprintf('=======================================================\n');
fprintf('  ระบบบันทึกข้อมูลพร้อมกัน 3 Poten (1 จุด = 10 วินาที)   \n');
fprintf('=======================================================\n');

for trial = 1:num_trials
    fprintf('\n=======================================================\n');
    fprintf('>>> เริ่มการทดลองรอบที่ %d / %d <<<\n', trial, num_trials);
    fprintf('=======================================================\n');
    
    for idx = 1:num_points
        current_pos = pos_steps(idx);
        
        % 1. แจ้งเตือนให้ปรับตำแหน่ง Poten
        fprintf('\n[รอบ %d/%d] จุดที่ %2d/%d: โปรดหมุนปรับ Poten ไปที่ตำแหน่ง [%3d%%]\n', ...
            trial, num_trials, idx, num_points, current_pos);
        input('เมื่อปรับเรียบร้อยแล้ว กด [Enter] เพื่อเริ่มบันทึกพร้อมกัน 3 ช่อง (10 วินาที)...', 's');
        
        fprintf('   [กำลังบันทึกข้อมูล A, B, C พร้อมกัน 10 วินาที...] ');
        
        % 2. สั่งรัน Simulink 10 วินาที
        simOut = sim(model_name, 'StopTime', '10');
        
        % 3. ดึงข้อมูล 3 Poten พร้อมกัน และตัด 1 วินาทีแรกออก (Transient)
        vA = double(squeeze(simOut.A_poten.Data)); vA_stable = vA(Fs+1:end);
        vB = double(squeeze(simOut.B_poten.Data)); vB_stable = vB(Fs+1:end);
        vC = double(squeeze(simOut.C_poten.Data)); vC_stable = vC(Fs+1:end);
        
        % 4. คำนวณค่าเฉลี่ยแรงดันและบันทึกลง Array
        mean_A(idx, trial) = mean(vA_stable); std_A(idx, trial) = std(vA_stable);
        mean_B(idx, trial) = mean(vB_stable); std_B(idx, trial) = std(vB_stable);
        mean_C(idx, trial) = mean(vC_stable); std_C(idx, trial) = std(vC_stable);
        
        fprintf('เสร็จสิ้น!\n');
        fprintf('   --> แรงดันเฉลี่ย: Poten A = %.4f V | Poten B = %.4f V | Poten C = %.4f V\n', ...
            mean_A(idx, trial), mean_B(idx, trial), mean_C(idx, trial));
        
        % บันทึกไฟล์สำรองข้อมูลอัตโนมัติกันหลุดร่วง
        save('poten_characterization_backup.mat', 'pos_steps', 'mean_A', 'std_A', 'mean_B', 'std_B', 'mean_C', 'std_C');
    end
    fprintf('\n>>> จบการทดลองรอบที่ %d เรียบร้อย! <<<\n', trial);
end

% บันทึกไฟล์ฉบับสมบูรณ์
save('poten_characterization_final.mat', 'pos_steps', 'mean_A', 'std_A', 'mean_B', 'std_B', 'mean_C', 'std_C');
fprintf('\n=======================================================\n');
fprintf('  บันทึกข้อมูลครบถ้วน 21 จุด x 3 รอบ (พร้อมกัน 3 Poten) เรียบร้อย!\n');
fprintf('=======================================================\n');