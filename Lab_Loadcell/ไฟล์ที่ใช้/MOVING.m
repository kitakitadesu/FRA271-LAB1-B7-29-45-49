% 1. ระบุพาธไฟล์ Excel
filePath = 'C:\Users\pakon\OneDrive\Desktop\RMX\Lab_Loarcell\Loadcell_FFT_Data.xlsx';

% 2. อ่านข้อมูลจากไฟล์ Excel เข้ามาในรูปแบบ Table
data = readtable(filePath);

% 3. แยกข้อมูลตามคอลัมน์
time = data{:, 1};       % คอลัมน์ A: เวลา (แกน X)
rawSignal = data{:, 2};  % คอลัมน์ B: rawsignal (แกน Y)

% 4. คำนวณ Moving Average (Window length = 50)
windowLength = 50;
maSignal = movmean(rawSignal, windowLength);

% 5. พล็อตกราฟเปรียบเทียบระหว่าง Raw Signal กับ Moving Average
figure('Name', 'Loadcell Moving Average', 'NumberTitle', 'off');

% พล็อต Raw Signal (สีเทา)
plot(time, rawSignal, 'Color', [0.7 0.7 0.7], 'LineWidth', 0.8, 'DisplayName', 'Raw Signal');
hold on;

% พล็อต Moving Average (สีแดง)
plot(time, maSignal, 'r-', 'LineWidth', 1.8, 'DisplayName', sprintf('Moving Average (Window=%d)', windowLength));
hold off;

% 6. ตกแต่งกราฟ
title('Loadcell Raw Signal vs Moving Average (Window = 50)');
xlabel('Time');
ylabel('Raw Signal');
grid on;
legend('Location', 'best');