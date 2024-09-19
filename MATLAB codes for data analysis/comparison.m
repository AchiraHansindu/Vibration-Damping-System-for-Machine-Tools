% --- Axis Selection ---
axis_to_plot = input('Enter the axis to plot for comparison (x, y, or z): ', 's');

% --- Old Data Import and Processing ---

% Read the table
datatable = readtable('before_shock.csv');

% Convert the table to an array
data = table2array(datatable);

% Separate the data into x, y, and z components
acc_x = data(:, 1);
acc_y = data(:, 2);
acc_z = data(:, 3);

% Convert the time data to seconds
time = data(:, 4)*3600 + data(:, 5)*60 + data(:, 6) + data(:, 7)/1000; % Time in seconds

% Create time vector assuming a constant sampling rate
Fs = 1 / mean(diff(time));  % Mean sampling interval
L = length(acc_x); % Length of signal
T = 1/Fs; % Sampling period
t = (0:L-1)*T; % Time vector

% Function to compute single-sided amplitude spectrum
compute_spectrum = @(signal) abs(fft(signal)/L);
get_single_sided = @(P2) P2(2:floor(L/2) + 1); % Exclude the first element (0 Hz)
adjust_amplitude = @(P1) [2*P1(1:end-1); P1(end)];

% Frequency vector
f = Fs*(1:floor(L/2))/L; % Exclude the first frequency (0 Hz)

% Compute single-sided amplitude spectrum for each axis
P2_x = compute_spectrum(acc_x);
P1_x = adjust_amplitude(get_single_sided(P2_x));

P2_y = compute_spectrum(acc_y);
P1_y = adjust_amplitude(get_single_sided(P2_y));

P2_z = compute_spectrum(acc_z);
P1_z = adjust_amplitude(get_single_sided(P2_z));

% Select the appropriate data based on user input
switch axis_to_plot
    case 'x'
        P1_old = P1_x;
        axis_label = 'X-axis';
    case 'y'
        P1_old = P1_y;
        axis_label = 'Y-axis';
    case 'z'
        P1_old = P1_z;
        axis_label = 'Z-axis';
    otherwise
        error('Invalid input! Please enter x, y, or z.');
end

% --- New Data Import and Processing ---
new_datatable = readtable('after_shock.csv'); % Update with the actual path to your new data
new_data = table2array(new_datatable);

% Separate the new data into x, y, and z components
new_acc_x = new_data(:, 1);
new_acc_y = new_data(:, 2);
new_acc_z = new_data(:, 3);

% Convert the new time data to seconds
new_time = new_data(:, 4)*3600 + new_data(:, 5)*60 + new_data(:, 6) + new_data(:, 7)/1000; % Time in seconds

% Create time vector for new data assuming a constant sampling rate
Fs_new = 1 / mean(diff(new_time));  % Mean sampling interval for new data
L_new = length(new_acc_x); % Length of new signal

% Use the same functions for FFT processing as used for old data
compute_spectrum = @(signal) abs(fft(signal)/L_new);
get_single_sided = @(P2) P2(2:floor(L_new/2) + 1);
adjust_amplitude = @(P1) [2*P1(1:end-1); P1(end)];

% Frequency vector for new data
f_new = Fs_new*(1:floor(L_new/2))/L_new;

% Compute FFT for the selected axis of new data
switch axis_to_plot
    case 'x'
        P2_new = compute_spectrum(new_acc_x);
    case 'y'
        P2_new = compute_spectrum(new_acc_y);
    case 'z'
        P2_new = compute_spectrum(new_acc_z);
end
P1_new = adjust_amplitude(get_single_sided(P2_new));

% Plot the comparison of old and new data as subplots
figure;
subplot(2,1,1);
plot(f, P1_old, 'r');
title(['Single-Sided Amplitude Spectrum Before Damper - ' axis_label]);
xlabel('Frequency (Hz)');
ylabel('|P1(f)|');
xticks(0:50:max(f)); % Ensure consistent tick marks
grid on;

subplot(2,1,2);
plot(f_new, P1_new, 'b');
title(['Single-Sided Amplitude Spectrum After Damper - ' axis_label]);
xlabel('Frequency (Hz)');
ylabel('|P1(f)|');
xticks(0:50:max(f_new)); % Ensure consistent tick marks
grid on;

% --- Calculate Natural Frequency and Amplitude ---

% Find the natural frequency and amplitude for the old data
[~, idx_old] = max(P1_old);
natural_frequency_old = f(idx_old);
amplitude_old = P1_old(idx_old);

% Find the natural frequency and amplitude for the new data
[~, idx_new] = max(P1_new);
natural_frequency_new = f_new(idx_new);
amplitude_new = P1_new(idx_new);

% Display the results
fprintf('Natural frequency (before damper): %.3f Hz\n', natural_frequency_old);
fprintf('Amplitude at natural frequency (before damper): %.3f\n', amplitude_old);
fprintf('Natural frequency (after damper): %.3f Hz\n', natural_frequency_new);
fprintf('Amplitude at natural frequency (after damper): %.3f\n', amplitude_new);

% --- Calculate Overall Improvement ---
improvement_percentage = ((amplitude_old - amplitude_new) / amplitude_old) * 100;
fprintf('Overall improvement in amplitude reduction: %.2f%%\n', improvement_percentage);
