function spec = spec(signal, fs, window_length, hop_size, plot_title, fig_number)

% Built by Rob Salino
% inputs are signal, fs, window length, hop size, title of spectrogram, and
% figure number, if necessary, for placement in MATLAB script
% automatically uses 2049 frequency bins and a Hamming window

% Example use in a MATLAB script: 
% spec(song, 44100, 512, 256, 'Spectrogram of Song', 2);

bins = 2049;
frames = floor(length(signal)/window_length);
x = (linspace(0, fs/2, bins))';
for i=1:frames*(window_length/hop_size) - 1
    signal_frame(:,i) = signal((((i-1)*hop_size) + 1):window_length+((i-1)*hop_size));
    hamming_window = hamming(window_length);
    signal_frame_hamming = signal_frame .* hamming_window;
end
for i = 1:frames*(window_length/hop_size) - 1
    signal_frame_hamming_fft(:,i) = fft(signal_frame_hamming(:,i));
    signal_frame_hamming_magnitude(:,i) = 20*log10(abs(signal_frame_hamming_fft(:,i)));
end
signal_frame_hamming_magnitude = signal_frame_hamming_magnitude(1:(end-(end/2)+1),:);
signal_frame_hamming_magnitude(1,:)=0;

figure(fig_number)
[numRows,numCols] = size(signal_frame_hamming_magnitude);
y_scale_signal = linspace(0, fs/2, bins);
x_scale_signal = linspace(0, (length(signal)/fs), 1000);
imagesc(x_scale_signal, y_scale_signal, signal_frame_hamming_magnitude);
set(gca,'ydir','normal')
h = colorbar;
ylabel(h, 'Power/Frequency (dB/Hz)')
xlabel('Time (seconds)','FontSize', 14), ylabel('Frequency (Hz)','FontSize', 14)
title(sprintf('%s',plot_title),'FontSize', 14)
end