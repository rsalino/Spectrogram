# Spectrogram
Built spectrogram from scratch in MATLAB by Rob Salino

inputs are signal, fs, window length, hop size, title of spectrogram, and
figure number, if necessary, for placement in MATLAB script
automatically uses 2049 frequency bins and a Hamming window

Example use in a MATLAB script: 
spec(song, 44100, 512, 256, 'Spectrogram of Song', 2);
