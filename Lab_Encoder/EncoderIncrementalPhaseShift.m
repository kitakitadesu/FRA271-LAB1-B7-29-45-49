% กำหนดค่าตัวแปรสำหรับการวนลูป
encoders = [1, 2];
x_modes = [1, 2, 4];
directions = {'CW', 'CCW'};
runs = 1:3;
% สร้างโครงสร้างตัวแปร (Struct) สำหรับเก็บข้อมูลทั้งหมด
experimentData = struct();
% วนลูปเพื่อโหลดไฟล์ตาม Format: EncodeN_XN_CW/CCW_RunN.mat
for e = 1:length(encoders)
    enc_num = encoders(e);
    for x = 1:length(x_modes)
        x_num = x_modes(x);
        for d = 1:length(directions)
            dir_str = directions{d};
            for r = runs
                % สร้างชื่อไฟล์แบบไดนามิก
                fileName = sprintf('Encoder%d_X%d_%s_Run%d.mat', enc_num, x_num, dir_str, r);
                % ตรวจสอบว่าไฟล์มีอยู่จริงใน Current Folder หรือไม่
                if isfile(fileName)
                    % โหลดข้อมูลจากไฟล์
                    loadedData = load(fileName);
                    % ตั้งชื่อ Field ให้เข้าถึงง่าย 
                    % ตัวอย่าง: experimentData.Encode1.X4.CW.Run1
                    encField = sprintf('Encode%d', enc_num);
                    xField = sprintf('X%d', x_num);
                    runField = sprintf('Run%d', r);
                    % เก็บข้อมูลลงใน Struct หลัก
                    experimentData.(encField).(xField).(dir_str).(runField) = loadedData;
                    fprintf('Loaded successfully: %s\n', fileName);
                else
                    warning('File not found: %s', fileName);
                end
            end
        end
    end
end
disp('====================================');
disp('Import ข้อมูลเสร็จสิ้น สามารถเรียกใช้ผ่านตัวแปร experimentData');
% ==========================
% Channel A & Channel B Data Extraction
% ==========================
% --- Run 1 ---
% AMT103-V (Encoder 1) Run 1 - Channel A & B
Encode1_x1_cw_channelA_data_run1 = experimentData.Encode1.X1.CW.Run1.data{end-3}.Values.Data;
Encode1_x1_cw_channelA_time_run1 = experimentData.Encode1.X1.CW.Run1.data{end-3}.Values.Time;
Encode1_x1_cw_channelB_data_run1 = experimentData.Encode1.X1.CW.Run1.data{end-2}.Values.Data;
Encode1_x1_cw_direction_data_run1 = experimentData.Encode1.X1.CW.Run1.data{9}.Values.Data;

Encode1_x2_cw_channelA_data_run1 = experimentData.Encode1.X2.CW.Run1.data{end-3}.Values.Data;
Encode1_x2_cw_channelA_time_run1 = experimentData.Encode1.X2.CW.Run1.data{end-3}.Values.Time;
Encode1_x2_cw_channelB_data_run1 = experimentData.Encode1.X2.CW.Run1.data{end-2}.Values.Data;
Encode1_x2_cw_direction_data_run1 = experimentData.Encode1.X2.CW.Run1.data{9}.Values.Data;

Encode1_x4_cw_channelA_data_run1 = experimentData.Encode1.X4.CW.Run1.data{end-3}.Values.Data;
Encode1_x4_cw_channelA_time_run1 = experimentData.Encode1.X4.CW.Run1.data{end-3}.Values.Time;
Encode1_x4_cw_channelB_data_run1 = experimentData.Encode1.X4.CW.Run1.data{end-2}.Values.Data;
Encode1_x4_cw_direction_data_run1 = experimentData.Encode1.X4.CW.Run1.data{9}.Values.Data;

Encode1_x1_ccw_channelA_data_run1 = experimentData.Encode1.X1.CCW.Run1.data{end-3}.Values.Data;
Encode1_x1_ccw_channelA_time_run1 = experimentData.Encode1.X1.CCW.Run1.data{end-3}.Values.Time;
Encode1_x1_ccw_channelB_data_run1 = experimentData.Encode1.X1.CCW.Run1.data{end-2}.Values.Data;
Encode1_x1_ccw_direction_data_run1 = experimentData.Encode1.X1.CCW.Run1.data{9}.Values.Data;

Encode1_x2_ccw_channelA_data_run1 = experimentData.Encode1.X2.CCW.Run1.data{end-3}.Values.Data;
Encode1_x2_ccw_channelA_time_run1 = experimentData.Encode1.X2.CCW.Run1.data{end-3}.Values.Time;
Encode1_x2_ccw_channelB_data_run1 = experimentData.Encode1.X2.CCW.Run1.data{end-2}.Values.Data;
Encode1_x2_ccw_direction_data_run1 = experimentData.Encode1.X2.CCW.Run1.data{9}.Values.Data;

Encode1_x4_ccw_channelA_data_run1 = experimentData.Encode1.X4.CCW.Run1.data{end-3}.Values.Data;
Encode1_x4_ccw_channelA_time_run1 = experimentData.Encode1.X4.CCW.Run1.data{end-3}.Values.Time;
Encode1_x4_ccw_channelB_data_run1 = experimentData.Encode1.X4.CCW.Run1.data{end-2}.Values.Data;
Encode1_x4_ccw_direction_data_run1 = experimentData.Encode1.X4.CCW.Run1.data{9}.Values.Data;

% BOURNS PEC11R (Encoder 2) Run 1 - Channel A & B
Encode2_x1_cw_channelA_data_run1 = experimentData.Encode2.X1.CW.Run1.data{end-3}.Values.Data;
Encode2_x1_cw_channelA_time_run1 = experimentData.Encode2.X1.CW.Run1.data{end-3}.Values.Time;
Encode2_x1_cw_channelB_data_run1 = experimentData.Encode2.X1.CW.Run1.data{end-2}.Values.Data;
Encode2_x1_cw_direction_data_run1 = experimentData.Encode2.X1.CW.Run1.data{9}.Values.Data;

Encode2_x2_cw_channelA_data_run1 = experimentData.Encode2.X2.CW.Run1.data{end-3}.Values.Data;
Encode2_x2_cw_channelA_time_run1 = experimentData.Encode2.X2.CW.Run1.data{end-3}.Values.Time;
Encode2_x2_cw_channelB_data_run1 = experimentData.Encode2.X2.CW.Run1.data{end-2}.Values.Data;
Encode2_x2_cw_direction_data_run1 = experimentData.Encode2.X2.CW.Run1.data{9}.Values.Data;

Encode2_x4_cw_channelA_data_run1 = experimentData.Encode2.X4.CW.Run1.data{end-3}.Values.Data;
Encode2_x4_cw_channelA_time_run1 = experimentData.Encode2.X4.CW.Run1.data{end-3}.Values.Time;
Encode2_x4_cw_channelB_data_run1 = experimentData.Encode2.X4.CW.Run1.data{end-2}.Values.Data;
Encode2_x4_cw_direction_data_run1 = experimentData.Encode2.X4.CW.Run1.data{9}.Values.Data;

Encode2_x1_ccw_channelA_data_run1 = experimentData.Encode2.X1.CCW.Run1.data{end-3}.Values.Data;
Encode2_x1_ccw_channelA_time_run1 = experimentData.Encode2.X1.CCW.Run1.data{end-3}.Values.Time;
Encode2_x1_ccw_channelB_data_run1 = experimentData.Encode2.X1.CCW.Run1.data{end-2}.Values.Data;
Encode2_x1_ccw_direction_data_run1 = experimentData.Encode2.X1.CCW.Run1.data{9}.Values.Data;

Encode2_x2_ccw_channelA_data_run1 = experimentData.Encode2.X2.CCW.Run1.data{end-3}.Values.Data;
Encode2_x2_ccw_channelA_time_run1 = experimentData.Encode2.X2.CCW.Run1.data{end-3}.Values.Time;
Encode2_x2_ccw_channelB_data_run1 = experimentData.Encode2.X2.CCW.Run1.data{end-2}.Values.Data;
Encode2_x2_ccw_direction_data_run1 = experimentData.Encode2.X2.CCW.Run1.data{9}.Values.Data;

Encode2_x4_ccw_channelA_data_run1 = experimentData.Encode2.X4.CCW.Run1.data{end-3}.Values.Data;
Encode2_x4_ccw_channelA_time_run1 = experimentData.Encode2.X4.CCW.Run1.data{end-3}.Values.Time;
Encode2_x4_ccw_channelB_data_run1 = experimentData.Encode2.X4.CCW.Run1.data{end-2}.Values.Data;
Encode2_x4_ccw_direction_data_run1 = experimentData.Encode2.X4.CCW.Run1.data{9}.Values.Data;
% --- Run 2 ---
% AMT103-V
Encode1_x1_cw_channelA_data_run2 = experimentData.Encode1.X1.CW.Run2.data{end-3}.Values.Data;
Encode1_x1_cw_channelA_time_run2 = experimentData.Encode1.X1.CW.Run2.data{end-3}.Values.Time;
Encode1_x1_cw_channelB_data_run2 = experimentData.Encode1.X1.CW.Run2.data{end-2}.Values.Data;
Encode1_x1_cw_direction_data_run2 = experimentData.Encode1.X1.CW.Run2.data{9}.Values.Data;

Encode1_x2_cw_channelA_data_run2 = experimentData.Encode1.X2.CW.Run2.data{end-3}.Values.Data;
Encode1_x2_cw_channelA_time_run2 = experimentData.Encode1.X2.CW.Run2.data{end-3}.Values.Time;
Encode1_x2_cw_channelB_data_run2 = experimentData.Encode1.X2.CW.Run2.data{end-2}.Values.Data;
Encode1_x2_cw_direction_data_run2 = experimentData.Encode1.X2.CW.Run2.data{9}.Values.Data;

Encode1_x4_cw_channelA_data_run2 = experimentData.Encode1.X4.CW.Run2.data{end-3}.Values.Data;
Encode1_x4_cw_channelA_time_run2 = experimentData.Encode1.X4.CW.Run2.data{end-3}.Values.Time;
Encode1_x4_cw_channelB_data_run2 = experimentData.Encode1.X4.CW.Run2.data{end-2}.Values.Data;
Encode1_x4_cw_direction_data_run2 = experimentData.Encode1.X4.CW.Run2.data{9}.Values.Data;

Encode1_x1_ccw_channelA_data_run2 = experimentData.Encode1.X1.CCW.Run2.data{end-3}.Values.Data;
Encode1_x1_ccw_channelA_time_run2 = experimentData.Encode1.X1.CCW.Run2.data{end-3}.Values.Time;
Encode1_x1_ccw_channelB_data_run2 = experimentData.Encode1.X1.CCW.Run2.data{end-2}.Values.Data;
Encode1_x1_ccw_direction_data_run2 = experimentData.Encode1.X1.CCW.Run2.data{9}.Values.Data;

Encode1_x2_ccw_channelA_data_run2 = experimentData.Encode1.X2.CCW.Run2.data{end-3}.Values.Data;
Encode1_x2_ccw_channelA_time_run2 = experimentData.Encode1.X2.CCW.Run2.data{end-3}.Values.Time;
Encode1_x2_ccw_channelB_data_run2 = experimentData.Encode1.X2.CCW.Run2.data{end-2}.Values.Data;
Encode1_x2_ccw_direction_data_run2 = experimentData.Encode1.X2.CCW.Run2.data{9}.Values.Data;

Encode1_x4_ccw_channelA_data_run2 = experimentData.Encode1.X4.CCW.Run2.data{end-3}.Values.Data;
Encode1_x4_ccw_channelA_time_run2 = experimentData.Encode1.X4.CCW.Run2.data{end-3}.Values.Time;
Encode1_x4_ccw_channelB_data_run2 = experimentData.Encode1.X4.CCW.Run2.data{end-2}.Values.Data;
Encode1_x4_ccw_direction_data_run2 = experimentData.Encode1.X4.CCW.Run2.data{9}.Values.Data;
% BOURN
Encode2_x1_cw_channelA_data_run2 = experimentData.Encode2.X1.CW.Run2.data{end-3}.Values.Data;
Encode2_x1_cw_channelA_time_run2 = experimentData.Encode2.X1.CW.Run2.data{end-3}.Values.Time;
Encode2_x1_cw_channelB_data_run2 = experimentData.Encode2.X1.CW.Run2.data{end-2}.Values.Data;
Encode2_x1_cw_direction_data_run2 = experimentData.Encode2.X1.CW.Run2.data{9}.Values.Data;

Encode2_x2_cw_channelA_data_run2 = experimentData.Encode2.X2.CW.Run2.data{end-3}.Values.Data;
Encode2_x2_cw_channelA_time_run2 = experimentData.Encode2.X2.CW.Run2.data{end-3}.Values.Time;
Encode2_x2_cw_channelB_data_run2 = experimentData.Encode2.X2.CW.Run2.data{end-2}.Values.Data;
Encode2_x2_cw_direction_data_run2 = experimentData.Encode2.X2.CW.Run2.data{9}.Values.Data;

Encode2_x4_cw_channelA_data_run2 = experimentData.Encode2.X4.CW.Run2.data{end-3}.Values.Data;
Encode2_x4_cw_channelA_time_run2 = experimentData.Encode2.X4.CW.Run2.data{end-3}.Values.Time;
Encode2_x4_cw_channelB_data_run2 = experimentData.Encode2.X4.CW.Run2.data{end-2}.Values.Data;
Encode2_x4_cw_direction_data_run2 = experimentData.Encode2.X4.CW.Run2.data{9}.Values.Data;

Encode2_x1_ccw_channelA_data_run2 = experimentData.Encode2.X1.CCW.Run2.data{end-3}.Values.Data;
Encode2_x1_ccw_channelA_time_run2 = experimentData.Encode2.X1.CCW.Run2.data{end-3}.Values.Time;
Encode2_x1_ccw_channelB_data_run2 = experimentData.Encode2.X1.CCW.Run2.data{end-2}.Values.Data;
Encode2_x1_ccw_direction_data_run2 = experimentData.Encode2.X1.CCW.Run2.data{9}.Values.Data;

Encode2_x2_ccw_channelA_data_run2 = experimentData.Encode2.X2.CCW.Run2.data{end-3}.Values.Data;
Encode2_x2_ccw_channelA_time_run2 = experimentData.Encode2.X2.CCW.Run2.data{end-3}.Values.Time;
Encode2_x2_ccw_channelB_data_run2 = experimentData.Encode2.X2.CCW.Run2.data{end-2}.Values.Data;
Encode2_x2_ccw_direction_data_run2 = experimentData.Encode2.X2.CCW.Run2.data{9}.Values.Data;

Encode2_x4_ccw_channelA_data_run2 = experimentData.Encode2.X4.CCW.Run2.data{end-3}.Values.Data;
Encode2_x4_ccw_channelA_time_run2 = experimentData.Encode2.X4.CCW.Run2.data{end-3}.Values.Time;
Encode2_x4_ccw_channelB_data_run2 = experimentData.Encode2.X4.CCW.Run2.data{end-2}.Values.Data;
Encode2_x4_ccw_direction_data_run2 = experimentData.Encode2.X4.CCW.Run2.data{9}.Values.Data;
% --- Run 3 ---
% AMT103-V
Encode1_x1_cw_channelA_data_run3 = experimentData.Encode1.X1.CW.Run3.data{end-3}.Values.Data;
Encode1_x1_cw_channelA_time_run3 = experimentData.Encode1.X1.CW.Run3.data{end-3}.Values.Time;
Encode1_x1_cw_channelB_data_run3 = experimentData.Encode1.X1.CW.Run3.data{end-2}.Values.Data;
Encode1_x1_cw_direction_data_run3 = experimentData.Encode1.X1.CW.Run3.data{9}.Values.Data;

Encode1_x2_cw_channelA_data_run3 = experimentData.Encode1.X2.CW.Run3.data{end-3}.Values.Data;
Encode1_x2_cw_channelA_time_run3 = experimentData.Encode1.X2.CW.Run3.data{end-3}.Values.Time;
Encode1_x2_cw_channelB_data_run3 = experimentData.Encode1.X2.CW.Run3.data{end-2}.Values.Data;
Encode1_x2_cw_direction_data_run3 = experimentData.Encode1.X2.CW.Run3.data{9}.Values.Data;

Encode1_x4_cw_channelA_data_run3 = experimentData.Encode1.X4.CW.Run3.data{end-3}.Values.Data;
Encode1_x4_cw_channelA_time_run3 = experimentData.Encode1.X4.CW.Run3.data{end-3}.Values.Time;
Encode1_x4_cw_channelB_data_run3 = experimentData.Encode1.X4.CW.Run3.data{end-2}.Values.Data;
Encode1_x4_cw_direction_data_run3 = experimentData.Encode1.X4.CW.Run3.data{9}.Values.Data;

Encode1_x1_ccw_channelA_data_run3 = experimentData.Encode1.X1.CCW.Run3.data{end-3}.Values.Data;
Encode1_x1_ccw_channelA_time_run3 = experimentData.Encode1.X1.CCW.Run3.data{end-3}.Values.Time;
Encode1_x1_ccw_channelB_data_run3 = experimentData.Encode1.X1.CCW.Run3.data{end-2}.Values.Data;
Encode1_x1_ccw_direction_data_run3 = experimentData.Encode1.X1.CCW.Run3.data{9}.Values.Data;

Encode1_x2_ccw_channelA_data_run3 = experimentData.Encode1.X2.CCW.Run3.data{end-3}.Values.Data;
Encode1_x2_ccw_channelA_time_run3 = experimentData.Encode1.X2.CCW.Run3.data{end-3}.Values.Time;
Encode1_x2_ccw_channelB_data_run3 = experimentData.Encode1.X2.CCW.Run3.data{end-2}.Values.Data;
Encode1_x2_ccw_direction_data_run3 = experimentData.Encode1.X2.CCW.Run3.data{9}.Values.Data;

Encode1_x4_ccw_channelA_data_run3 = experimentData.Encode1.X4.CCW.Run3.data{end-3}.Values.Data;
Encode1_x4_ccw_channelA_time_run3 = experimentData.Encode1.X4.CCW.Run3.data{end-3}.Values.Time;
Encode1_x4_ccw_channelB_data_run3 = experimentData.Encode1.X4.CCW.Run3.data{end-2}.Values.Data;
Encode1_x4_ccw_direction_data_run3 = experimentData.Encode1.X4.CCW.Run3.data{9}.Values.Data;

% BOURN
Encode2_x1_cw_channelA_data_run3 = experimentData.Encode2.X1.CW.Run3.data{end-3}.Values.Data;
Encode2_x1_cw_channelA_time_run3 = experimentData.Encode2.X1.CW.Run3.data{end-3}.Values.Time;
Encode2_x1_cw_channelB_data_run3 = experimentData.Encode2.X1.CW.Run3.data{end-2}.Values.Data;
Encode2_x1_cw_direction_data_run3 = experimentData.Encode2.X1.CW.Run3.data{9}.Values.Data;

Encode2_x2_cw_channelA_data_run3 = experimentData.Encode2.X2.CW.Run3.data{end-3}.Values.Data;
Encode2_x2_cw_channelA_time_run3 = experimentData.Encode2.X2.CW.Run3.data{end-3}.Values.Time;
Encode2_x2_cw_channelB_data_run3 = experimentData.Encode2.X2.CW.Run3.data{end-2}.Values.Data;
Encode2_x2_cw_direction_data_run3 = experimentData.Encode2.X2.CW.Run3.data{9}.Values.Data;

Encode2_x4_cw_channelA_data_run3 = experimentData.Encode2.X4.CW.Run3.data{end-3}.Values.Data;
Encode2_x4_cw_channelA_time_run3 = experimentData.Encode2.X4.CW.Run3.data{end-3}.Values.Time;
Encode2_x4_cw_channelB_data_run3 = experimentData.Encode2.X4.CW.Run3.data{end-2}.Values.Data;
Encode2_x4_cw_direction_data_run3 = experimentData.Encode2.X4.CW.Run3.data{9}.Values.Data;

Encode2_x1_ccw_channelA_data_run3 = experimentData.Encode2.X1.CCW.Run3.data{end-3}.Values.Data;
Encode2_x1_ccw_channelA_time_run3 = experimentData.Encode2.X1.CCW.Run3.data{end-3}.Values.Time;
Encode2_x1_ccw_channelB_data_run3 = experimentData.Encode2.X1.CCW.Run3.data{end-2}.Values.Data;
Encode2_x1_ccw_direction_data_run3 = experimentData.Encode2.X1.CCW.Run3.data{9}.Values.Data;

Encode2_x2_ccw_channelA_data_run3 = experimentData.Encode2.X2.CCW.Run3.data{end-3}.Values.Data;
Encode2_x2_ccw_channelA_time_run3 = experimentData.Encode2.X2.CCW.Run3.data{end-3}.Values.Time;
Encode2_x2_ccw_channelB_data_run3 = experimentData.Encode2.X2.CCW.Run3.data{end-2}.Values.Data;
Encode2_x2_ccw_direction_data_run3 = experimentData.Encode2.X2.CCW.Run3.data{9}.Values.Data;

Encode2_x4_ccw_channelA_data_run3 = experimentData.Encode2.X4.CCW.Run3.data{end-3}.Values.Data;
Encode2_x4_ccw_channelA_time_run3 = experimentData.Encode2.X4.CCW.Run3.data{end-3}.Values.Time;
Encode2_x4_ccw_channelB_data_run3 = experimentData.Encode2.X4.CCW.Run3.data{end-2}.Values.Data;
Encode2_x4_ccw_direction_data_run3 = experimentData.Encode2.X4.CCW.Run3.data{9}.Values.Data;

% ==========================
% PLOTTING: Run 1
% ==========================
figure(1);
subplot(2,2,1);
plot(Encode1_x1_cw_channelA_time_run1, Encode1_x1_cw_channelA_data_run1, 'r','LineWidth',2, 'DisplayName','Chanel A');
hold on;
plot(Encode1_x1_cw_channelA_time_run1, Encode1_x1_cw_channelB_data_run1, 'b','LineWidth',2, 'DisplayName','Chanel B');
hold on;
xlabel('Time (s)', 'FontSize',14); 
xlim([38.25, 38.3]);
ylabel('Output Signal', 'FontSize', 14);
title('AMT103-V Output Signal Phase Shift in Clockwise', 'FontSize', 14);
legend('Location', 'northeast');
grid on; grid minor;

subplot(2,2,3);
plot(Encode1_x1_ccw_channelA_time_run1, Encode1_x1_ccw_channelA_data_run1, 'r','LineWidth',2, 'DisplayName','Chanel A');
hold on;
plot(Encode1_x1_ccw_channelA_time_run1, Encode1_x1_ccw_channelB_data_run1, 'b','LineWidth',2, 'DisplayName','Chanel B');
hold on;
xlabel('Time (s)', 'FontSize',14);
ylabel('Output Signal', 'FontSize', 14);
title('AMT103-V  Output Signal Phase Shift in Counterlockwise', 'FontSize', 14);
legend('Location', 'northeast');
xlim([39, 39.05]);
grid on; grid minor;

subplot(2,2,2);
plot(Encode2_x1_cw_channelA_time_run3, Encode2_x1_cw_channelA_data_run3, 'r','LineWidth',2, 'DisplayName','Chanel A');
hold on;
plot(Encode2_x1_cw_channelA_time_run3, Encode2_x1_cw_channelB_data_run3, 'b','LineWidth',2, 'DisplayName','Chanel B');
hold on;
xlabel('Time (s)', 'FontSize',14);
ylabel('Output Signal', 'FontSize', 14);
title('BOURNS PEC11R-4220F-N0024 Output Signal Phase Shift in Clockwise', 'FontSize', 13);
legend('Location', 'northeast');
xlim([33, 36.5]);
grid on; grid minor;

subplot(2,2,4);
plot(Encode2_x1_ccw_channelA_time_run1, Encode2_x1_ccw_channelA_data_run1, 'r','LineWidth',2, 'DisplayName','Chanel A');
hold on;
plot(Encode2_x1_ccw_channelA_time_run1, Encode2_x1_ccw_channelB_data_run1, 'b','LineWidth',2, 'DisplayName','Chanel B');
hold on;
xlabel('Time (s)', 'FontSize',14);
ylabel('Output Signal', 'FontSize', 14);
title('BOURNS PEC11R-4220F-N0024 Output Signal Phase Shift in Counterclockwise', 'FontSize', 13);
legend('Location', 'northeast');
xlim([10, 12.5]);
grid on; grid minor;
