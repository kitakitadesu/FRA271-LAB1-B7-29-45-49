% ========================================================================
% MATLAB Script: Plot Signal vs Time from Simulink Dataset (.mat)
% ไฟล์: C:\Users\pakon\OneDrive\Desktop\RMX\Lab_Loarcell\2oct\kita_967g.mat
% ========================================================================
clear; clc; close all;

% 1. กำหนดพาธไฟล์ .mat
filePath = 'C:\Users\pakon\OneDrive\Desktop\RMX\Lab_Loarcell\2oct\kita_967g.mat';

% 2. โหลดข้อมูลจากไฟล์ .mat
matData = load(filePath);

% 3. ดึง Object Dataset จาก Simulink
ds = matData.data;

% 4. ดึงสัญญาณแรกออกมาจาก Dataset (Element 1)
elem = ds.get(1);     % ดึง Element สัญญาณ
ts   = elem.Values;   % ได้เป็น Object timeseries

% 5. ดึงค่าตัวเลขสัญญาณ (แกน Y) และเวลา (แกน X)
y = squeeze(double(ts.Data)); % ดึงค่าสัญญาณและแปลงเป็นเวกเตอร์
t = ts.Time;                  % ดึงแกนเวลาที่บันทึกจาก Simulink

% กำหนด Step Time = 0.001 วินาที
dt = 0.001; 
if isempty(t)
    N = length(y);
    t = (0:N-1)' * dt;
end

% 6. สร้างและพล๊อตกราฟ (ปรับ LineWidth = 2)
figure('Name', 'Load Cell Signal', 'Color', [1 1 1], 'Position', [100, 100, 1000, 550]);
plot(t, y, 'LineWidth', 2, 'Color', [0, 0.4470, 0.7410]);

% 7. ตกแต่งแกนและองค์ประกอบกราฟ (ปรับ FontSize = 18)
grid on;
box on;
grid minor;

xlabel('Time (s)', 'FontSize', 18, 'FontWeight', 'bold');

if ~isempty(elem.Name)
    ylabel(['Signal (' elem.Name ')'], 'FontSize', 18, 'FontWeight', 'bold');
else
    ylabel('Signal', 'FontSize', 18, 'FontWeight', 'bold');
end

title(['Load Cell Signal vs Time (kita\_967g.mat) - Step: ' num2str(dt) ' s'], ...
    'FontSize', 18, 'FontWeight', 'bold');

ax = gca;
ax.FontSize = 18;       % ตัวเลขบนแกนเป็น 18
ax.LineWidth = 1.2;     % ความหนากรอยแกน
ax.GridAlpha = 0.3;