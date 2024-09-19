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
T = 1/Fs; % Sampling period
L = length(acc_x); % Length of signal
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

% Calculate y-axis limits separately for each plot
max_amplitude_x = max(P1_x);
max_amplitude_y = max(P1_y);
max_amplitude_z = max(P1_z);

% Plot the acceleration in time domain for X-axis
figure;
plot(t, acc_x);
title('Acceleration in Time Domain - X-axis');
xlabel('Time (s)');
ylabel('Acceleration - X-axis');
grid on;

% Plot the acceleration in time domain for Y-axis
figure;
plot(t, acc_y);
title('Acceleration in Time Domain - Y-axis');
xlabel('Time (s)');
ylabel('Acceleration - Y-axis');
grid on;

% Plot the acceleration in time domain for Z-axis
figure;
plot(t, acc_z);
title('Acceleration in Time Domain - Z-axis');
xlabel('Time (s)');
ylabel('Acceleration - Z-axis');
grid on;

% Plot the single-sided amplitude spectrum for X-axis
figure;
plot(f, P1_x);
title('Single-Sided Amplitude Spectrum of X-axis Acceleration');
xlabel('Frequency (Hz)');
ylabel('|P1(f)|');
ylim([0 max_amplitude_x * 1.1]);
grid on;

% Plot the single-sided amplitude spectrum for Y-axis
figure;
plot(f, P1_y);
title('Single-Sided Amplitude Spectrum of Y-axis Acceleration');
xlabel('Frequency (Hz)');
ylabel('|P1(f)|');
ylim([0 max_amplitude_y * 1.1]);
grid on;

% Plot the single-sided amplitude spectrum for Z-axis
figure;
plot(f, P1_z);
title('Single-Sided Amplitude Spectrum of Z-axis Acceleration');
xlabel('Frequency (Hz)');
ylabel('|P1(f)|');
ylim([0 max_amplitude_z * 1.1]);
grid on;

% --- Calculation of Natural Frequency, Damping Ratio, Spring Constant, and Damping Coefficient using Y-axis data ---

% Find the natural frequency (peak in FFT) for the Y-axis
[~, idx_y] = max(P1_y);
natural_frequency_y = f(idx_y);
fprintf('Natural frequency: %.3f Hz\n', natural_frequency_y);

% Prompt for mass input
mass = input('Enter the mass (kg): ');

% Calculate the spring constant (k)
k = mass * (2 * pi * natural_frequency_y)^2;
fprintf('Spring constant: %.3f N/m\n', k);

% Calculate the damping ratio (ζ) using the half-power bandwidth method
% Assuming FWHM (Full Width at Half Maximum) method is used
bandwidth_y = sum(P1_y >= (max(P1_y)/sqrt(2))) * (Fs/L);
damping_ratio_y = bandwidth_y / (2 * natural_frequency_y);
fprintf('Damping ratio: %.10f\n', damping_ratio_y);

% Calculate the damping coefficient (c)
damping_coefficient_y = 2 * damping_ratio_y * sqrt(k * mass);
fprintf('Damping coefficient: %.3f Ns/m\n', damping_coefficient_y);

% --- Calculation of Dynamic Viscosity η ---

% Prompt for piston diameter input
piston_diameter = input('Enter the piston diameter (m): ');

% Calculate the effective piston area A
A = pi * (piston_diameter/2)^2;

% Calculate the dynamic viscosity η
eta = damping_coefficient_y / A;
fprintf('Dynamic viscosity η: %.6f Pa.s\n', eta);

% --- Calculation of Wire Diameter d ---

% Prompt for inputs related to spring design
D = input('Enter the mean coil diameter (m): ');
G = input('Enter the shear modulus (Pa): ');
n = input('Enter the number of active coils: ');

% Calculate the wire diameter d
d = ((8 * k * D^3 * n) / G)^(1/4);
fprintf('Wire diameter d: %.6f m\n', d);
