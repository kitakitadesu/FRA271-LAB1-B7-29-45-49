%% Lab 1.1 - วิเคราะห์ Rotary Potentiometer A, B, C
%  เลือก trial ที่ต้องการ: เปลี่ยนค่า select ด้านล่าง
%    [1 2 3] = ใช้ทั้ง 3 trial (ค่าเฉลี่ย)
%    [1 2]   = ใช้ trial 1,2
%    [1]     = ใช้ trial 1 เท่านั้น
%    [2 3]   = ใช้ trial 2,3
clear; clc; close all;

select = [1 2 3];  % <<<< เปลี่ยนตรงนี้

%% โหลดข้อมูล
dataDir = fullfile(fileparts(mfilename('fullpath')), 'FindTypeandSens_data');
T = readtable(fullfile(dataDir, 'DATA_ABCpoten .xlsx'), 'Sheet', 'Sheet1');
x = T{:, 1};

colRanges = {2:4, 5:7, 8:10};
names = {'Rotary A', 'Rotary B', 'Rotary C'};

%% คำนวณ
figure('Name', 'Rotary A/B/C', 'Position', [50 50 1400 900]);
results = zeros(3, 3);

for i = 1:3
    y_all = T{:, colRanges{i}};
    y_sel = y_all(:, select);
    y_avg = mean(y_sel, 2);
    y_std = std(y_sel, 0, 2);

    p = polyfit(x, y_avg, 1);
    y_fit = polyval(p, x);
    R2 = 1 - sum((y_avg - y_fit).^2) / sum((y_avg - mean(y_avg)).^2);
    nonlin = (max(abs(y_avg - y_fit)) / (max(y_avg) - min(y_avg))) * 100;
    results(i, :) = [p(1), R2, nonlin];

    subplot(3,2,2*i-1);
    errorbar(x, y_avg, y_std, 'b-o', 'LineWidth', 1.5, 'MarkerFaceColor', 'b');
    hold on;
    plot(x, y_fit, 'r--', 'LineWidth', 2);
    xlabel('ตำแหน่ง (%)', 'FontSize', 14);
    ylabel('แรงดัน (V)', 'FontSize', 14);
    title(sprintf('%s  S=%.4f  R^2=%.4f', names{i}, p(1), R2), 'FontSize', 14);
    legend('ข้อมูลวัดได้', 'เส้นเชิงเส้น', 'FontSize', 12, 'Location', 'northwest');
    grid on; grid minor;
    set(gca, 'FontSize', 18, 'LineWidth', 1.5);

    subplot(3,2,2*i);
    bar(x, y_avg - y_fit, 'FaceColor', [0.3 0.6 0.9]);
    xlabel('ตำแหน่ง (%)', 'FontSize', 14);
    ylabel('ค่าคลาดเคลื่อน (V)', 'FontSize', 14);
    title('ค่าคลาดเคลื่อนจากเชิงเส้น', 'FontSize', 14);
    grid on; grid minor;
    set(gca, 'FontSize', 18, 'LineWidth', 1.5);
end

sgtitle(sprintf('เปรียบเทียบ Rotary (ใช้ trial: %s)', num2str(select)), 'FontSize', 16);

%% สรุป
fprintf('===== สรุป (trial: %s) =====\n', num2str(select));
fprintf('%-10s %12s %10s %10s\n', 'ชนิด', 'ความไว', 'R2', 'ความคลาด');
for i = 1:3
    fprintf('%-10s %10.4f V/%% %10.6f %9.2f%%\n', names{i}, results(i,1), results(i,2), results(i,3));
end
