% ==========================
% Wrapping Around - Time
% ==========================
% AMT103-V Run 1
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


Encode1_x1_cw_wrapping_data_run1 = experimentData.Encode1.X1.CW.Run1.data{end}.Values.Data;
Encode1_x1_cw_wrapping_time_run1 = experimentData.Encode1.X1.CW.Run1.data{end}.Values.Time;

Encode1_x1_ccw_wrapping_data_run1 = experimentData.Encode1.X1.CCW.Run1.data{end}.Values.Data;
Encode1_x1_ccw_wrapping_time_run1 = experimentData.Encode1.X1.CCW.Run1.data{end}.Values.Time;

Encode1_x2_cw_wrapping_data_run1 = experimentData.Encode1.X2.CW.Run1.data{end}.Values.Data;
Encode1_x2_cw_wrapping_time_run1 = experimentData.Encode1.X2.CW.Run1.data{end}.Values.Time;

Encode1_x2_ccw_wrapping_data_run1 = experimentData.Encode1.X2.CCW.Run1.data{end}.Values.Data;
Encode1_x2_ccw_wrapping_time_run1 = experimentData.Encode1.X2.CCW.Run1.data{end}.Values.Time;

Encode1_x4_cw_wrapping_data_run1 = experimentData.Encode1.X4.CW.Run1.data{end}.Values.Data;
Encode1_x4_cw_wrapping_time_run1 = experimentData.Encode1.X4.CW.Run1.data{end}.Values.Time;

Encode1_x4_ccw_wrapping_data_run1 = experimentData.Encode1.X4.CCW.Run1.data{end}.Values.Data;
Encode1_x4_ccw_wrapping_time_run1 = experimentData.Encode1.X4.CCW.Run1.data{end}.Values.Time;

% AMT103-V Run 2
Encode1_x1_cw_wrapping_data_run2 = experimentData.Encode1.X1.CW.Run2.data{end}.Values.Data;
Encode1_x1_cw_wrapping_time_run2 = experimentData.Encode1.X1.CW.Run2.data{end}.Values.Time;

Encode1_x2_cw_wrapping_data_run2 = experimentData.Encode1.X2.CW.Run2.data{end}.Values.Data;
Encode1_x2_cw_wrapping_time_run2 = experimentData.Encode1.X2.CW.Run2.data{end}.Values.Time;

Encode1_x4_cw_wrapping_data_run2 = experimentData.Encode1.X4.CW.Run2.data{end}.Values.Data;
Encode1_x4_cw_wrapping_time_run2 = experimentData.Encode1.X4.CW.Run2.data{end}.Values.Time;

Encode1_x1_ccw_wrapping_data_run2 = experimentData.Encode1.X1.CCW.Run2.data{end}.Values.Data;
Encode1_x1_ccw_wrapping_time_run2 = experimentData.Encode1.X1.CCW.Run2.data{end}.Values.Time;

Encode1_x2_ccw_wrapping_data_run2 = experimentData.Encode1.X2.CCW.Run2.data{end}.Values.Data;
Encode1_x2_ccw_wrapping_time_run2 = experimentData.Encode1.X2.CCW.Run2.data{end}.Values.Time;

Encode1_x4_ccw_wrapping_data_run2 = experimentData.Encode1.X4.CCW.Run2.data{end}.Values.Data;
Encode1_x4_ccw_wrapping_time_run2 = experimentData.Encode1.X4.CCW.Run2.data{end}.Values.Time;

% AMT103-V Run 3
Encode1_x1_cw_wrapping_data_run3 = experimentData.Encode1.X1.CW.Run3.data{end}.Values.Data;
Encode1_x1_cw_wrapping_time_run3 = experimentData.Encode1.X1.CW.Run3.data{end}.Values.Time;

Encode1_x2_cw_wrapping_data_run3 = experimentData.Encode1.X2.CW.Run3.data{end}.Values.Data;
Encode1_x2_cw_wrapping_time_run3 = experimentData.Encode1.X2.CW.Run3.data{end}.Values.Time;

Encode1_x4_cw_wrapping_data_run3 = experimentData.Encode1.X4.CW.Run3.data{end}.Values.Data;
Encode1_x4_cw_wrapping_time_run3 = experimentData.Encode1.X4.CW.Run3.data{end}.Values.Time;

Encode1_x1_ccw_wrapping_data_run3 = experimentData.Encode1.X1.CCW.Run3.data{end}.Values.Data;
Encode1_x1_ccw_wrapping_time_run3 = experimentData.Encode1.X1.CCW.Run3.data{end}.Values.Time;

Encode1_x2_ccw_wrapping_data_run3 = experimentData.Encode1.X2.CCW.Run3.data{end}.Values.Data;
Encode1_x2_ccw_wrapping_time_run3 = experimentData.Encode1.X2.CCW.Run3.data{end}.Values.Time;

Encode1_x4_ccw_wrapping_data_run3 = experimentData.Encode1.X4.CCW.Run3.data{end}.Values.Data;
Encode1_x4_ccw_wrapping_time_run3 = experimentData.Encode1.X4.CCW.Run3.data{end}.Values.Time;

% BOURNS PEC11R-422-F -N0024 Run 1
Encode2_x1_cw_wrapping_data_run1 = experimentData.Encode2.X1.CW.Run1.data{end}.Values.Data;
Encode2_x1_cw_wrapping_time_run1 = experimentData.Encode2.X1.CW.Run1.data{end}.Values.Time;

Encode2_x2_cw_wrapping_data_run1 = experimentData.Encode2.X2.CW.Run1.data{end}.Values.Data;
Encode2_x2_cw_wrapping_time_run1 = experimentData.Encode2.X2.CW.Run1.data{end}.Values.Time;

Encode2_x4_cw_wrapping_data_run1 = experimentData.Encode2.X4.CW.Run1.data{end}.Values.Data;
Encode2_x4_cw_wrapping_time_run1 = experimentData.Encode2.X4.CW.Run1.data{end}.Values.Time;

Encode2_x1_ccw_wrapping_data_run1 = experimentData.Encode2.X1.CCW.Run1.data{end}.Values.Data;
Encode2_x1_ccw_wrapping_time_run1 = experimentData.Encode2.X1.CCW.Run1.data{end}.Values.Time;

Encode2_x2_ccw_wrapping_data_run1 = experimentData.Encode2.X2.CCW.Run1.data{end}.Values.Data;
Encode2_x2_ccw_wrapping_time_run1 = experimentData.Encode2.X2.CCW.Run1.data{end}.Values.Time;

Encode2_x4_ccw_wrapping_data_run1 = experimentData.Encode2.X4.CCW.Run1.data{end}.Values.Data;
Encode2_x4_ccw_wrapping_time_run1 = experimentData.Encode2.X4.CCW.Run1.data{end}.Values.Time;

% BOURNS PEC11R-422-F -N0024 Run 2
Encode2_x1_cw_wrapping_data_run2 = experimentData.Encode2.X1.CW.Run2.data{end}.Values.Data;
Encode2_x1_cw_wrapping_time_run2 = experimentData.Encode2.X1.CW.Run2.data{end}.Values.Time;

Encode2_x2_cw_wrapping_data_run2 = experimentData.Encode2.X2.CW.Run2.data{end}.Values.Data;
Encode2_x2_cw_wrapping_time_run2 = experimentData.Encode2.X2.CW.Run2.data{end}.Values.Time;

Encode2_x4_cw_wrapping_data_run2 = experimentData.Encode2.X4.CW.Run2.data{end}.Values.Data;
Encode2_x4_cw_wrapping_time_run2 = experimentData.Encode2.X4.CW.Run2.data{end}.Values.Time;

Encode2_x1_ccw_wrapping_data_run2 = experimentData.Encode2.X1.CCW.Run2.data{end}.Values.Data;
Encode2_x1_ccw_wrapping_time_run2 = experimentData.Encode2.X1.CCW.Run2.data{end}.Values.Time;

Encode2_x2_ccw_wrapping_data_run2 = experimentData.Encode2.X2.CCW.Run2.data{end}.Values.Data;
Encode2_x2_ccw_wrapping_time_run2 = experimentData.Encode2.X2.CCW.Run2.data{end}.Values.Time;

Encode2_x4_ccw_wrapping_data_run2 = experimentData.Encode2.X4.CCW.Run2.data{end}.Values.Data;
Encode2_x4_ccw_wrapping_time_run2 = experimentData.Encode2.X4.CCW.Run2.data{end}.Values.Time;

% BOURNS PEC11R-422-F -N0024 Run 3
Encode2_x1_cw_wrapping_data_run3 = experimentData.Encode2.X1.CW.Run3.data{end}.Values.Data;
Encode2_x1_cw_wrapping_time_run3 = experimentData.Encode2.X1.CW.Run3.data{end}.Values.Time;

Encode2_x2_cw_wrapping_data_run3 = experimentData.Encode2.X2.CW.Run3.data{end}.Values.Data;
Encode2_x2_cw_wrapping_time_run3 = experimentData.Encode2.X2.CW.Run3.data{end}.Values.Time;

Encode2_x4_cw_wrapping_data_run3 = experimentData.Encode2.X4.CW.Run3.data{end}.Values.Data;
Encode2_x4_cw_wrapping_time_run3 = experimentData.Encode2.X4.CW.Run3.data{end}.Values.Time;

Encode2_x1_ccw_wrapping_data_run3 = experimentData.Encode2.X1.CCW.Run3.data{end}.Values.Data;
Encode2_x1_ccw_wrapping_time_run3 = experimentData.Encode2.X1.CCW.Run3.data{end}.Values.Time;

Encode2_x2_ccw_wrapping_data_run3 = experimentData.Encode2.X2.CCW.Run3.data{end}.Values.Data;
Encode2_x2_ccw_wrapping_time_run3 = experimentData.Encode2.X2.CCW.Run3.data{end}.Values.Time;

Encode2_x4_ccw_wrapping_data_run3 = experimentData.Encode2.X4.CCW.Run3.data{end}.Values.Data;
Encode2_x4_ccw_wrapping_time_run3 = experimentData.Encode2.X4.CCW.Run3.data{end}.Values.Time;
%}

% Wrapping Around Run 1
figure(1);
subplot(2,2,1);
plot(Encode1_x1_cw_wrapping_time_run1, Encode1_x1_cw_wrapping_data_run1,'r','LineWidth',2,'DisplayName','EncoderX1');
hold on;
plot(Encode1_x2_cw_wrapping_time_run1, Encode1_x2_cw_wrapping_data_run1,'m','LineWidth',2,'DisplayName','EncoderX2');
hold on;
plot(Encode1_x4_cw_wrapping_time_run1, Encode1_x4_cw_wrapping_data_run1,'b','LineWidth',2,'DisplayName','EncoderX4');
xlabel('Time (s)', 'FontSize',14);
ylabel('Angular Position (Degs)', 'FontSize', 14);
title('AMT103-V Angular Position in Clockwise', 'FontSize', 15);
legend('Location', 'northeast');
grid on; grid minor;

subplot(2,2,3);
plot(Encode1_x1_ccw_wrapping_time_run1, Encode1_x1_ccw_wrapping_data_run1,'r','LineWidth',2,'DisplayName','EncoderX1');
hold on;
plot(Encode1_x2_ccw_wrapping_time_run1, Encode1_x2_ccw_wrapping_data_run1,'m','LineWidth',2,'DisplayName','EncoderX2');
hold on;
plot(Encode1_x4_ccw_wrapping_time_run1, Encode1_x4_ccw_wrapping_data_run1,'b','LineWidth',2,'DisplayName','EncoderX4');
xlabel('Time (s)', 'FontSize',14);
ylabel('Angular Position (Degs)', 'FontSize', 14);
title('AMT103-V Angular Position in Counterclockwise', 'FontSize', 15);
legend('Location', 'northeast');
grid on; grid minor;

subplot(2,2,2);
plot(Encode2_x1_cw_wrapping_time_run1, Encode2_x1_cw_wrapping_data_run1,'r','LineWidth',2,'DisplayName','EncoderX1');
hold on;
plot(Encode2_x2_cw_wrapping_time_run1, Encode2_x2_cw_wrapping_data_run1,'m','LineWidth',2,'DisplayName','EncoderX2');
hold on;
plot(Encode2_x4_cw_wrapping_time_run1, Encode2_x4_cw_wrapping_data_run1,'b','LineWidth',2,'DisplayName','EncoderX4');
xlabel('Time (s)', 'FontSize',14);
ylabel('Angular Position (Degs)', 'FontSize', 14);
title('BOURNS PEC11R-4220F-N0024 Angular Position in Clockwise', 'FontSize', 15);
legend('Location', 'northeast');
grid on; grid minor;

subplot(2,2,4);
plot(Encode2_x1_ccw_wrapping_time_run1, Encode2_x1_ccw_wrapping_data_run1,'r','LineWidth',2,'DisplayName','EncoderX1');
hold on;
plot(Encode2_x2_ccw_wrapping_time_run1, Encode2_x2_ccw_wrapping_data_run1,'m','LineWidth',2,'DisplayName','EncoderX2');
hold on;
plot(Encode2_x4_ccw_wrapping_time_run1, Encode2_x4_ccw_wrapping_data_run1,'b','LineWidth',2,'DisplayName','EncoderX4');
xlabel('Time (s)', 'FontSize',14);
ylabel('Angular Position (Degs)', 'FontSize', 14);
title('BOURNS PEC11R-4220F-N0024 Angular Position in Clockwise', 'FontSize', 15);
legend('Location', 'northeast');
grid on; grid minor;

% Wrapping Around Run 2
figure(2);
subplot(2,2,1);
plot(Encode1_x1_cw_wrapping_time_run2, Encode1_x1_cw_wrapping_data_run2,'r','LineWidth',2,'DisplayName','EncoderX1');
hold on;
plot(Encode1_x2_cw_wrapping_time_run2, Encode1_x2_cw_wrapping_data_run2,'m','LineWidth',2,'DisplayName','EncoderX2');
hold on;
plot(Encode1_x4_cw_wrapping_time_run2, Encode1_x4_cw_wrapping_data_run2,'b','LineWidth',2,'DisplayName','EncoderX4');
xlabel('Time (s)', 'FontSize',14);
ylabel('Angular Position (Degs)', 'FontSize', 14);
title('AMT103-V Angular Position in Clockwise', 'FontSize', 15);
legend('Location', 'northeast');
grid on; grid minor;

subplot(2,2,3);
plot(Encode1_x1_ccw_wrapping_time_run2, Encode1_x1_ccw_wrapping_data_run2,'r','LineWidth',2,'DisplayName','EncoderX1');
hold on;
plot(Encode1_x2_ccw_wrapping_time_run2, Encode1_x2_ccw_wrapping_data_run2,'m','LineWidth',2,'DisplayName','EncoderX2');
hold on;
plot(Encode1_x4_ccw_wrapping_time_run2, Encode1_x4_ccw_wrapping_data_run2,'b','LineWidth',2,'DisplayName','EncoderX4');
xlabel('Time (s)', 'FontSize',14);
ylabel('Angular Position (Degs)', 'FontSize', 14);
title('AMT103-V Angular Position in Counterclockwise', 'FontSize', 15);
legend('Location', 'northeast');
grid on; grid minor;

subplot(2,2,2);
plot(Encode2_x1_cw_wrapping_time_run2, Encode2_x1_cw_wrapping_data_run2,'r','LineWidth',2,'DisplayName','EncoderX1');
hold on;
plot(Encode2_x2_cw_wrapping_time_run2, Encode2_x2_cw_wrapping_data_run2,'m','LineWidth',2,'DisplayName','EncoderX2');
hold on;
plot(Encode2_x4_cw_wrapping_time_run2, Encode2_x4_cw_wrapping_data_run2,'b','LineWidth',2,'DisplayName','EncoderX4');
xlabel('Time (s)', 'FontSize',14);
ylabel('Angular Position (Degs)', 'FontSize', 14);
title('BOURNS PEC11R-4220F-N0024 Angular Position in Clockwise', 'FontSize', 15);
legend('Location', 'northeast');
grid on; grid minor;

subplot(2,2,4);
plot(Encode2_x1_ccw_wrapping_time_run2, Encode2_x1_ccw_wrapping_data_run2,'r','LineWidth',2,'DisplayName','EncoderX1');
hold on;
plot(Encode2_x2_ccw_wrapping_time_run2, Encode2_x2_ccw_wrapping_data_run2,'m','LineWidth',2,'DisplayName','EncoderX2');
hold on;
plot(Encode2_x4_ccw_wrapping_time_run2, Encode2_x4_ccw_wrapping_data_run2,'b','LineWidth',2,'DisplayName','EncoderX4');
xlabel('Time (s)', 'FontSize',14);
ylabel('Angular Position (Degs)', 'FontSize', 14);
title('BOURNS PEC11R-4220F-N0024 Angular Position in Clockwise', 'FontSize', 15);
legend('Location', 'northeast');
grid on; grid minor;

% Wrapping Around Run 3
figure(3);
subplot(2,2,1);
plot(Encode1_x1_cw_wrapping_time_run3, Encode1_x1_cw_wrapping_data_run3,'r','LineWidth',2,'DisplayName','EncoderX1');
hold on;
plot(Encode1_x2_cw_wrapping_time_run3, Encode1_x2_cw_wrapping_data_run3,'m','LineWidth',2,'DisplayName','EncoderX2');
hold on;
plot(Encode1_x4_cw_wrapping_time_run3, Encode1_x4_cw_wrapping_data_run3,'b','LineWidth',2,'DisplayName','EncoderX4');
xlabel('Time (s)', 'FontSize',14);
ylabel('Angular Position (Degs)', 'FontSize', 14);
title('AMT103-V Angular Position in Clockwise', 'FontSize', 15);
legend('Location', 'northeast');
grid on; grid minor;

subplot(2,2,3);
plot(Encode1_x1_ccw_wrapping_time_run3, Encode1_x1_ccw_wrapping_data_run3,'r','LineWidth',2,'DisplayName','EncoderX1');
hold on;
plot(Encode1_x2_ccw_wrapping_time_run3, Encode1_x2_ccw_wrapping_data_run3,'m','LineWidth',2,'DisplayName','EncoderX2');
hold on;
plot(Encode1_x4_ccw_wrapping_time_run3, Encode1_x4_ccw_wrapping_data_run3,'b','LineWidth',2,'DisplayName','EncoderX4');
xlabel('Time (s)', 'FontSize',14);
ylabel('Angular Position (Degs)', 'FontSize', 14);
title('AMT103-V Angular Position in Counterclockwise', 'FontSize', 15);
legend('Location', 'northeast');
grid on; grid minor;

subplot(2,2,2);
plot(Encode2_x1_cw_wrapping_time_run3, Encode2_x1_cw_wrapping_data_run3,'r','LineWidth',2,'DisplayName','EncoderX1');
hold on;
plot(Encode2_x2_cw_wrapping_time_run3, Encode2_x2_cw_wrapping_data_run3,'m','LineWidth',2,'DisplayName','EncoderX2');
hold on;
plot(Encode2_x4_cw_wrapping_time_run3, Encode2_x4_cw_wrapping_data_run3,'b','LineWidth',2,'DisplayName','EncoderX4');
xlabel('Time (s)', 'FontSize',14);
ylabel('Angular Position (Degs)', 'FontSize', 14);
title('BOURNS PEC11R-4220F-N0024 Angular Position in Clockwise', 'FontSize', 15);
legend('Location', 'northeast');
grid on; grid minor;

subplot(2,2,4);
plot(Encode2_x1_ccw_wrapping_time_run3, Encode2_x1_ccw_wrapping_data_run3,'r','LineWidth',2,'DisplayName','EncoderX1');
hold on;
plot(Encode2_x2_ccw_wrapping_time_run3, Encode2_x2_ccw_wrapping_data_run3,'m','LineWidth',2,'DisplayName','EncoderX2');
hold on;
plot(Encode2_x4_ccw_wrapping_time_run3, Encode2_x4_ccw_wrapping_data_run3,'b','LineWidth',2,'DisplayName','EncoderX4');
xlabel('Time (s)', 'FontSize',14);
ylabel('Angular Position (Degs)', 'FontSize', 14);
title('BOURNS PEC11R-4220F-N0024 Angular Position in Clockwise', 'FontSize', 15);
legend('Location', 'northeast');
grid on; grid minor;