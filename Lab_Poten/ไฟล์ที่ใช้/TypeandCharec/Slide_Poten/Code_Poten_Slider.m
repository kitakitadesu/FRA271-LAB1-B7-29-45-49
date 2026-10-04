% =========================================================================
% Automatic Data Logger: Slide Potentiometers (2 Channels, 10 Seconds)
% =========================================================================
clc; clear; close all;

model_name = 'Lab_Poten.slx'; % <<-- เปลี่ยนเป็นชื่อไฟล์ .slx ของคุณ

% ระบุตำแหน่งระยะการเลื่อนตามที่กำหนด
pos_steps  = [0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6]; 
num_points = length(pos_steps);
num_trials = 3;                          % ทดลองซ้ำ 3 รอบ
Fs         = 1000;                       % Sampling frequency (1000 Hz)

% เมทริกซ์เก็บผลลัพธ์ [จำนวนจุด x 3 รอบ] สำหรับ Slide Poten 2 ตัว
mean_A = zeros(num_points, num_trials); std_A = zeros(num_points, num_trials);
mean_B = zeros(num_points, num_trials); std_B = zeros(num_points, num_trials);

load_system(model_name);

fprintf('=======================================================\n');
fprintf('  บันทึกข้อมูล Slide Poten 2 ตัว (จุดละ 10 วินาที x 3 รอบ)  \n');
fprintf('=======================================================\n');

for trial = 1:num_trials
    fprintf('\n=======================================================\n');
    fprintf('>>> เริ่มการทดลองรอบที่ %d / %d <<<\n', trial, num_trials);
    fprintf('=======================================================\n');

    for idx = 1:num_points
        current_pos = pos_steps(idx);

        fprintf('\n[รอบ %d/%d] จุดที่ %2d/%d: เลื่อน Slide Poten ไปที่ระยะ [%g]\n', ...
            trial, num_trials, idx, num_points, current_pos);
        input('เมื่อปรับเรียบร้อยแล้ว กด [Enter] เพื่อเริ่มบันทึก (10 วินาที)...', 's');

        fprintf('   [กำลังบันทึกข้อมูล 10 วินาที...] ');

        % สั่งรัน Simulink 10 วินาที
        simOut = sim(model_name, 'StopTime', '10');

        % ดึงข้อมูล 2 ช่องสัญญาณ (ตัด 1 วินาทีแรกออก)
        vA = double(squeeze(simOut.A_poten.Data)); vA_stable = vA(Fs+1:end);
        vB = double(squeeze(simOut.B_poten.Data)); vB_stable = vB(Fs+1:end);

        % คำนวณค่าเฉลี่ยและ Noise
        mean_A(idx, trial) = mean(vA_stable); std_A(idx, trial) = std(vA_stable);
        mean_B(idx, trial) = mean(vB_stable); std_B(idx, trial) = std(vB_stable);

        fprintf('เสร็จสิ้น!\n');
        fprintf('   --> ค่าแรงดันเฉลี่ย: Slide A = %.4f V | Slide B = %.4f V\n', ...
            mean_A(idx, trial), mean_B(idx, trial));

        % สำรองข้อมูลลงไฟล์ใหม่กันหลุดร่วง
        save('slide_poten_backup.mat', 'pos_steps', 'mean_A', 'std_A', 'mean_B', 'std_B');
    end
end

% เซฟไฟล์ฉบับสมบูรณ์ของ Slide Poten
save('slide_poten_final.mat', 'pos_steps', 'mean_A', 'std_A', 'mean_B', 'std_B');
fprintf('\n=======================================================\n');
fprintf('  บันทึกข้อมูล Slide Poten ครบทั้ง %d จุด x 3 รอบ สำเร็จ!\n', num_points);
fprintf('=======================================================\n');