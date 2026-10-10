function [BPM, instantaneousBPM, peakTimes] = heart_rate(filename, sampleRate, peakHeight)
%HEART_RATE Plot ECG diagnostics and compute peak instantaneous heart rate.
% Defaults preserve the original ECG6 experiment: 200 Hz and 2400 threshold.
if nargin < 1, filename = fullfile(fileparts(mfilename('fullpath')), 'ECG6.dat'); end
if nargin < 2, sampleRate = 200; end
if nargin < 3, peakHeight = 2400; end
validateattributes(sampleRate, {'numeric'}, {'scalar', 'finite', '>=', 2});
validateattributes(peakHeight, {'numeric'}, {'scalar', 'finite'});
ecg = load(filename);
validateattributes(ecg, {'numeric'}, {'vector', 'finite', 'nonempty'});
ecg = ecg(:);
figure(1);
plot(ecg);

figure(2);
plot(ecg);
axis([3000 3800 1500 3300]);  % x axis range and y axis range

peaks_1 = ecg > 2500; % returns 1 or 0 depending on the y axis values in ecg
figure(3);
plot(1:numel(ecg), ecg, 'b', 1:numel(ecg), 2500*(ecg>2500), 'ro'); % numel returns the number of elements in ecg
% all y axis values over 2500 are marked and circled
axis([3000 3800 1500 3300]);

time = (1:numel(ecg))/sampleRate; % as there are 200 samples per second
figure(4)
[peaks_2, pos_peaks] = findpeaks(ecg); % finds all peaks in ecg 
plot(time, ecg, 'b', pos_peaks/sampleRate, (peaks_2), 'ro')
axis([15 19 1500 3300]);

figure(5)
[peaks_2, pos_peaks] = findpeaks(ecg, 'MINPEAKHEIGHT', 2400); % finds all peaks in ecg 
plot(time, ecg, 'b', pos_peaks/sampleRate, (peaks_2), 'ro')
axis([15 19 1500 3300]);

% For 120 BPM, time = 60/120 = 0.5 seconds for each heart beat
figure(6)
[peaks_2, pos_peaks] = findpeaks(ecg, 'MINPEAKDISTANCE', round(sampleRate/2), 'MINPEAKHEIGHT', peakHeight); % minimum peak distance = 100 samples = 0.5 seconds 
plot(time, ecg, 'b', pos_peaks/sampleRate, (peaks_2), 'ro')
axis([15 19 1500 3300]);

if numel(pos_peaks) < 2
    error('heart_rate:InsufficientPeaks', 'At least two detected peaks are required.');
end
figure(7)
subplot(211)
plot(time, ecg, 'b', pos_peaks/sampleRate, (peaks_2), 'ro')
grid on
axis tight
ylabel('ECG', 'fontsize', 16)

subplot(212)
plot(time(pos_peaks(2:end)),60./(diff(pos_peaks/sampleRate))); 
axis tight
x = 60./diff(pos_peaks/sampleRate); % diff returns an arry of differences between consecutive elements of pos_peaks/sampleRate
grid on
axis tight
ylabel('Heart Rate', 'fontsize', 16)
xlabel('Time (seconds)', 'fontsize', 16)
BPM = max(x);
instantaneousBPM = x;
peakTimes = pos_peaks/sampleRate;





end
