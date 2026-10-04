[file, path] = uigetfile('*.mat', 'Select a File');

% Check if the user cancelled the dialog box
if isequal(file, 0)
    disp('User selected Cancel');
else
    f = figure('Color','w','Position',[80 60 900 620]);
    % Construct the full file path
    fullPath = fullfile(path, file);
    fprintf('User selected: %s\n', fullPath);
    loadedData = load(fullPath);
    variableNames = fieldnames(loadedData);
    fprintf('Loaded %d variable(s): %s\n', numel(variableNames), strjoin(variableNames, ', '));

    hold on
    plot(loadedData.data{1}.Values,'b','LineWidth',1.5) % plot

    grid on; grid minor;
    ax = gca;
    ax.XMinorGrid = 'on'; % Minor grid on X-axis only
    ax.YMinorGrid = 'on'; % Minor grid on Y-axis only

    
    ylabel('Weight (grams)'); xlabel('Time (seconds)');

    matches = regexp(file, '\d+\.?\d*', 'match')

    target_value= str2double(matches{1}) % เส้นแนวนอน

    title(target_value + "g") % ชืิ่อหัวแผนภูมิ

   yline(target_value, '--r', 'Target Value', 'LineWidth', 2,'LabelHorizontalAlignment', 'left'); % เส้นแนวนอน
    

    ylim([0 3000])
    hold off;
    % Your file loading logic goes here (e.g., readtable, load, imread)
end