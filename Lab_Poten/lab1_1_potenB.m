%% Lab 1.1 - วิเคราะห์ Rotary Potentiometer B
%  เลือก trial: เปลี่ยนค่า select ด้านล่าง
%    [1 2 3] = ทั้ง 3 trial, [1 2] = trial 1,2, [1] = trial 1 เท่านั้น
clear; clc; close all;

select = [1 2 3];  % <<<< เปลี่ยนตรงนี้

%% โหลดข้อมูล
dataDir = fullfile(fileparts(mfilename('fullpath')), 'FindTypeandSens_data');
rotFile = fullfile(dataDir, 'DATA_ABCpoten .xlsx');
T = readtable(rotFile, 'Sheet', 'Sheet1');

%% แยกข้อมูล Rotary B
x_pos = T{:, 1};
y_all = T{:, 5:7};
y_sel = y_all(:, select);
y_avg = mean(y_sel, 2);
y_std = std(y_sel, 0, 2);

%% การถดถอยเชิงเส้น
p = polyfit(x_pos, y_avg, 1);
m_val = p(1);
c_val = p(2);
y_fit = polyval(p, x_pos);
R2 = 1 - sum((y_avg - y_fit).^2) / sum((y_avg - mean(y_avg)).^2);
nonlin = (max(abs(y_avg - y_fit)) / (max(y_avg) - min(y_avg))) * 100;

fprintf('===== Rotary B (trial: %s) =====\n', num2str(select));
fprintf('ความไว = %.6f V/%%\n', m_val);
fprintf('R2 = %.6f\n', R2);
fprintf('ค่าคลาดเคลื่อน = %.2f %%\n', nonlin);

%% Transfer Function (Symbolic)
syms x m_s c_s
V_sym = m_s * x + c_s;
fprintf('\nTransfer Function:\n');
disp(V_sym);

%% สร้างกราฟ
figure('Name', 'Rotary B', 'Position', [100 100 1000 450]);

subplot(1,2,1);
errorbar(x_pos, y_avg, y_std, 'b-o', 'LineWidth', 1.5, 'MarkerFaceColor', 'b');
hold on;
plot(x_pos, y_fit, 'r--', 'LineWidth', 2);
xlabel('ตำแหน่ง (%)', 'FontSize', 14);
ylabel('แรงดัน (V)', 'FontSize', 14);
title(sprintf('Rotary B  S = %.4f V/%%  R^2 = %.4f', m_val, R2), 'FontSize', 14);
legend('ข้อมูลวัดได้', 'เส้นเชิงเส้น', 'FontSize', 12, 'Location', 'northwest');
grid on; grid minor;
set(gca, 'FontSize', 18, 'LineWidth', 1.5);

subplot(1,2,2);
bar(x_pos, y_avg - y_fit, 'FaceColor', [0.3 0.6 0.9]);
xlabel('ตำแหน่ง (%)', 'FontSize', 14);
ylabel('ค่าคลาดเคลื่อน (V)', 'FontSize', 14);
title('ค่าคลาดเคลื่อนจากเชิงเส้น', 'FontSize', 14);
grid on; grid minor;
set(gca, 'FontSize', 18, 'LineWidth', 1.5);

sgtitle(sprintf('Rotary Potentiometer B (trial: %s)', num2str(select)), 'FontSize', 16);
