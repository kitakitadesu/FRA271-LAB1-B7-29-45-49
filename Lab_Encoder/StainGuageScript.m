% 1. ดึงข้อมูลแรงดันไฟฟ้า (V) และเวลา (s) จาก Workspace
V_out = out.simout.data; % สัญญาณแรงดันขาออก
t = out.simout.time;     % เวลา

% 2. คำนวณอัตราการสุ่มสัญญาณ (Sampling Frequency) และจำนวนจุดข้อมูล
dt = mean(diff(t));
Fs = 1 / dt;            % ความถี่การสุ่มสัญญาณ (Hz)
N = length(V_out);      % จำนวน Sample ทั้งหมด

% 3. คำนวณ Fast Fourier Transform (FFT)
Y = fft(V_out);

% 4. แปลงเป็น Single-Sided Spectrum เพื่อหา ขนาดแรงดัน (Voltage Amplitude)
P2 = abs(Y / N);                  % Magnitude แบบ Two-sided
P1 = P2(1:floor(N/2)+1);           % ตัดเหลือเฉพาะความถี่ฝั่งบวก (เริ่มจาก 0 Hz)
P1(2:end-1) = 2 * P1(2:end-1);     % ชดเชย Amplitude สำหรับความถี่ที่ไม่ใช่ DC (0 Hz)

% 5. สร้าง Vector แกนความถี่ เริ่มต้นที่ 0 Hz ถึง Fs/2
f = Fs * (0:(N/2)) / N;

% 6. พล็อต กราฟแรงดันขาออก - ความถี่
figure;
plot(f, P1, 'b-', 'LineWidth', 1.5);
grid on;
xlim([0 Fs/2]);                    % กำหนดแกน X เริ่มจาก 0 Hz ถึง Nyquist Frequency
xlabel('Frequency (Hz)');
ylabel('Output Voltage Amplitude (mV)');
title('FFT Analysis: Output Voltage vs Frequency');