% Calibration
calibrate_low_pass = calibrate.V_Lowpass_Mean_V;
calibrate_average  = calibrate.V_AVR_Mean_V;
calibrate_mass     = calibrate.Actual_Weight_g;

% Validation
validate_low_pass = validate.V_Lowpass_V;
validate_average  = validate.V_AVR_V;
validate_mass     = validate.Actual_Weight_g;

% Error
low_pass_error = validate.Case1_Err_LPF_g;
avg_error = validate.Case2_Err_AVR_g;

% Scale Factor
p_cal_lp  = polyfit(calibrate_mass, calibrate_low_pass, 1);
p_cal_avr = polyfit(calibrate_mass, calibrate_average, 1);

p_val_lp  = polyfit(validate_mass, validate_low_pass, 1);
p_val_avr = polyfit(validate_mass, validate_average, 1);

figure(1);
subplot(1,2,1);
plot(calibrate_mass, calibrate_low_pass, 'b', 'LineWidth', 2.5, 'DisplayName', 'Low Pass Filter');
hold on;
plot(calibrate_mass, calibrate_average, 'r--', 'LineWidth', 2.5, 'DisplayName', 'Moving Average');
title('Load Cell Calibration', 'FontSize', 15);
xlabel('Weight(g)', 'FontSize', 15);
ylabel('Average Voltage (V)', 'FontSize', 15);
legend('Location', 'northeast');
xlim([0,7500]);
grid on; grid minor;

% Sensitivity
txt_cal = sprintf('Slope (LP): %.6f V/g\nSlope (AVR): %.6f V/g', p_cal_lp(1), p_cal_avr(1));
text(0.05, 0.82, txt_cal, 'Units', 'normalized', 'FontSize', 10, ...
     'Color','k','BackgroundColor', 'w', 'EdgeColor', 'k');

subplot(1,2,2);
plot(validate_mass, validate_low_pass, 'b', 'LineWidth', 2.5, 'DisplayName', 'Low Pass Filter');
hold on;
plot(validate_mass, validate_average, 'r--', 'LineWidth', 2.5, 'DisplayName', 'Moving Average');
title('Load Cell Validation', 'FontSize', 15);
xlabel('Weight(g)', 'FontSize', 15);
ylabel('Average Voltage (V)', 'FontSize', 15);
legend('Location', 'northeast');
grid on; grid minor;

% Sensitivity
txt_val = sprintf('Slope (LP): %.6f V/g\nSlope (AVR): %.6f V/g', p_val_lp(1), p_val_avr(1));
text(0.05, 0.82, txt_val, 'Units', 'normalized', 'FontSize', 10, ...
    'Color','k','BackgroundColor', 'w', 'EdgeColor', 'k');

figure(2);
plot(validate_mass, low_pass_error,'b-', 'LineWidth', 2.5, 'DisplayName', 'Low Pass Filter');
hold on;
plot(validate_mass, avg_error,'r--', 'LineWidth', 2.5, 'DisplayName', 'Moving Average');
title('Mass Calculation Error Calculated by Linear Regression', 'FontSize', 15);
xlabel('Weight(g)', 'FontSize', 15);
ylabel('Mass Calculation Error', 'FontSize', 15);
legend('Location', 'northeast');
grid on; grid minor;