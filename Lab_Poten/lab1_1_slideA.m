%% Lab 1.1 - วิเคราะห์ Slide Potentiometer A
%  เลือก trial: เปลี่ยนค่า select ด้านล่าง
%    [1 2 3] = ทั้ง 3 trial, [1 2] = trial 1,2, [1] = trial 1 เท่านั้น
clear; clc; close all;

select = [1 2 3];  % <<<< เปลี่ยนตรงนี้

%% โหลดข้อมูล
dataDir = fullfile(fileparts(mfilename('fullpath')), 'FindTypeandSens_data');
slideFile = fullfile(dataDir, 'slide_poten_data.xlsx');
T = readtable(slideFile, 'Sheet', 'Sheet1');

%% แยกข้อมูล Slide A
x_cm  = T{:, 1};
y_all = T{:, 2:4};
y_sel = y_all(:, select);
y_avg = mean(y_sel, 2);
y_std = std(y_sel, 0, 2);

%% การถดถอยเชิงเส้น
p = polyfit(x_cm, y_avg, 1);
m_val = p(1);
c_val = p(2);
y_fit = polyval(p, x_cm);
R2 = 1 - sum((y_avg - y_fit).^2) / sum((y_avg - mean(y_avg)).^2);
nonlin = (max(abs(y_avg - y_fit)) / (max(y_avg) - min(y_avg))) * 100;

fprintf('===== Slide A (trial: %s) =====\n', num2str(select));
fprintf('ความไว = %.6f V/cm\n', m_val);
fprintf('R2 = %.6f\n', R2);
fprintf('ค่าคลาดเคลื่อน = %.2f %%\n', nonlin);

%% Transfer Function (Symbolic)
syms x m_s c_s
V_sym = m_s * x + c_s;
fprintf('\nTransfer Function:\n');
disp(V_sym);

%% สร้างกราฟ
figure('Name', 'Slide A', 'Position', [100 100 1000 450]);

subplot(1,2,1);
errorbar(x_cm, y_avg, y_std, 'g-o', 'LineWidth', 1.5, 'MarkerFaceColor', 'g');
hold on;
plot(x_cm, y_fit, 'r--', 'LineWidth', 2);
xlabel('ระยะทาง (cm)', 'FontSize', 14);
ylabel('แรงดัน (V)', 'FontSize', 14);
title(sprintf('Slide A  S = %.4f V/cm  R^2 = %.4f', m_val, R2), 'FontSize', 14);
legend('ข้อมูลวัดได้', 'เส้นเชิงเส้น', 'FontSize', 12, 'Location', 'northwest');
grid on; grid minor;
set(gca, 'FontSize', 18, 'LineWidth', 1.5);

subplot(1,2,2);
plot(x_cm, y_avg - y_fit, 'm-s', 'LineWidth', 1.5, 'MarkerFaceColor', 'm');
xlabel('ระยะทาง (cm)', 'FontSize', 14);
ylabel('ค่าคลาดเคลื่อน (V)', 'FontSize', 14);
title('ค่าคลาดเคลื่อนจากเส้นเชิงเส้น', 'FontSize', 14);
grid on; grid minor;
set(gca, 'FontSize', 18, 'LineWidth', 1.5);

sgtitle(sprintf('Slide Potentiometer A (trial: %s)', num2str(select)), 'FontSize', 16);
