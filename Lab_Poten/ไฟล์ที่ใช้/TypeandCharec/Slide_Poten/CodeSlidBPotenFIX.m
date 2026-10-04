% =========================================================================
% Automatic Data Logger: Slide Potentiometer B Only
% =========================================================================
clc; clear; close all;

model_name = 'Lab_Poten.slx'; % <<-- เปลี่ยนเป็นชื่อไฟล์ .slx ของคุณ
pos_steps  = [0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6.5];
num_points = length(pos_steps);
num_trials = 1;                          % ทำซ้ำ 3 รอบ
Fs         = 1000;                       % Sampling frequency (1000 Hz)

% โหลดข้อมูลเดิม (ถ้ามี) เพื่อรักษาข้อมูล Slide A ไว้
if exist('slide_poten_final.mat', 'file')
    load('slide_poten_final.mat');
    fprintf('โหลดข้อมูล Slide A เดิมสำเร็จแล้ว!\n');
else
    mean_A = zeros(num_points, num_trials); std_A = zeros(num_points, num_trials);
end

% รีเซ็ตเมทริกซ์เก็บผลลัพธ์ของ Slide B ใหม่
mean_B = zeros(num_points, num_trials); 
std_B  = zeros(num_points, num_trials);

load_system(model_name);

fprintf('=======================================================\n');
fprintf('  บันทึกข้อมูลเฉพาะ Slide B (จุดละ 10 วินาที x 3 รอบ)   \n');
fprintf('=======================================================\n');

for trial = 1:num_trials
    fprintf('\n=======================================================\n');
    fprintf('>>> เริ่มการทดลอง Slide B รอบที่ %d / %d <<<\n', trial, num_trials);
    fprintf('=======================================================\n');

    for idx = 1:num_points
        current_pos = pos_steps(idx);

        fprintf('\n[รอบ %d/%d] จุดที่ %2d/%d: เลื่อน Slide B ไปที่ระยะ [%g]\n', ...
            trial, num_trials, idx, num_points, current_pos);
        input('เมื่อปรับเรียบร้อยแล้ว กด [Enter] เพื่อเริ่มบันทึก (10 วินาที)...', 's');

        fprintf('   [กำลังบันทึกข้อมูล Slide B 10 วินาที...] ');

        % สั่งรัน Simulink 10 วินาที
        simOut = sim(model_name, 'StopTime', '10');

        % ดึงเฉพาะข้อมูล Slide B (ตัด 1 วินาทีแรกออก)
        vB = double(squeeze(simOut.B_poten.Data)); vB_stable = vB(Fs+1:end);

        % คำนวณค่าเฉลี่ยและ Noise
        mean_B(idx, trial) = mean(vB_stable); 
        std_B(idx, trial)  = std(vB_stable);

        fprintf('เสร็จสิ้น!\n');
        fprintf('   --> ค่าแรงดันเฉลี่ย Slide B = %.4f V\n', mean_B(idx, trial));

        % บันทึกไฟล์สำรองข้อมูล
        save('slide_poten_backup.mat', 'pos_steps', 'mean_A', 'std_A', 'mean_B', 'std_B');
    end
end

% เซฟไฟล์ฉบับสมบูรณ์ที่รวมทั้ง Slide A และ Slide B ใหม่
save('slide_poten_final.mat', 'pos_steps', 'mean_A', 'std_A', 'mean_B', 'std_B');
fprintf('\n=======================================================\n');
fprintf('  อัปเดตข้อมูล Slide B ครบถ้วนและบันทึกรวมลงไฟล์เรียบร้อย!\n');
fprintf('=======================================================\n');