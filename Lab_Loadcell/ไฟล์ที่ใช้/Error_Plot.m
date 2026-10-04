% ========================================================================
% MATLAB Script: Relative Error (% Relative Error) Bar Chart
% สำหรับไฟล์สอบเทียบโหลดเซลล์ (Sheet 2)
% ========================================================================
clear; clc; close all;

% 1. กำหนดพาธของไฟล์ Excel
filePath = 'C:\Users\pakon\OneDrive\Desktop\RMX\Lab_Loarcell\Loadcell_Calibration_Report.xlsx';

% 2. อ่านข้อมูลจากแผ่นงานที่ 2 (Sheet 2)
opts = detectImportOptions(filePath, 'Sheet', 2);
opts.VariableNamingRule = 'preserve'; 
data = readtable(filePath, opts);

% 3. ดึงข้อมูลดิบ (คอลัมน์ A = น้ำหนักจริง, คอลัมน์ B = Error กรัม)
actWeight_raw = data{:, 1}; % แกน X: Actual Weight (g)
absError_raw   = data{:, 2}; % ค่า Error สัมบูรณ์ (g)

% คำนวณ % Relative Error
relError_raw = (absError_raw ./ actWeight_raw) * 100;
relError_raw(actWeight_raw == 0) = 0;
relError_raw(isinf(relError_raw) | isnan(relError_raw)) = 0;

% สร้าง Table สำหรับจัดกลุ่ม
cleanTable = table(actWeight_raw, relError_raw, ...
    'VariableNames', {'Weight', 'PercentError'});

% 4. จัดกลุ่มตามน้ำหนักจริง คำนวณค่าเฉลี่ยและ Std Dev
summaryData = groupsummary(cleanTable, 'Weight', {'mean', 'std'}, 'PercentError');
x_axis       = summaryData.Weight;
y_mean_pErr  = summaryData.mean_PercentError;
y_std_pErr   = summaryData.std_PercentError;
y_std_pErr(isnan(y_std_pErr)) = 0;

% 5. สร้างกราฟแท่ง (Bar Chart) - ขยายขนาด Window ให้เหมาะกับตัวอักษรขนาด 18
figure('Name', 'Load Cell Relative Error Bar Chart', 'Color', [1 1 1], 'Position', [100, 100, 1000, 600]);

% แปลงแกน X เป็น Categorical
x_categories = categorical(string(x_axis));
x_categories = reordercats(x_categories, string(x_axis));

% พล๊อตกราฟแท่ง
b = bar(x_categories, y_mean_pErr, ...
    'FaceColor', [0.2, 0.5, 0.8], ... % สีฟ้าโทนสะอาดตา
    'EdgeColor', 'none', ...
    'BarWidth', 0.6);                 % ความกว้างของแท่ง
hold on;

% แสดงแถบความคลาดเคลื่อน (Error Bar) บนแท่งกราฟ (ปรับ LineWidth = 2)
errorbar(x_categories, y_mean_pErr, y_std_pErr, 'k.', ...
    'LineWidth', 2, ...
    'CapSize', 8);

% แสดงเส้นอ้างอิงที่ 0% (Ideal Line) (ปรับ LineWidth = 2, FontSize = 18)
yline(0, 'r--', 'LineWidth', 2, 'Label', 'Ideal (0%)', ...
    'LabelHorizontalAlignment', 'right', 'FontSize', 18);

% ตกแต่งแกนและองค์ประกอบของกราฟ (ปรับ FontSize = 18)
grid on;
grid minor;
box on;
ax = gca;
ax.FontSize = 18;       % ตัวเลขบนแกนเป็น 18
ax.LineWidth = 1.2;     % ความหนากรอยแกน
ax.YGrid = 'on';
ax.XGrid = 'off'; 
ytickformat('%.2f'); 

xlabel('Actual Weight (g)', 'FontSize', 18, 'FontWeight', 'bold');
ylabel('% Relative Error (%)', 'FontSize', 18, 'FontWeight', 'bold');
title('เปอร์เซ็นต์ความคลาดเคลื่อนสัมพัทธ์ (% Relative Error Bar Chart)', ...
    'FontSize', 18, 'FontWeight', 'bold');
legend({'Average % Error', 'Std Dev (3 Runs)'}, ...
    'Location', 'northeast', 'FontSize', 18);
hold off;