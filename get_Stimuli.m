function [toPlay_60, toPlay_160, toPlay_Hilb, Fs] = get_Stimuli(filename,bands)


% Fs = 44.1e3;

% filename = '102.wav'

[wav_file,Fs] = audioread(filename);

%Signal for envelope extraction

%full-wave rectification at 60Hz and 160Hz
env1_sig = wav_file(:,1);
sig_abs = abs(env1_sig);

[b_60,a_60] = butter(3, 60/(Fs/2),'low');
[b_160,a_160] = butter(3, 160/(Fs/2),'low');
[b_4k,a_4k] = butter(3, 4e3/(Fs/2),'low');

noise = randn(1,length(wav_file));

% bands = [1,2,4,8,16]

for i = 1:length(bands)
    
    Fco = equal_xbm_bands(0,4000,bands(i));
    B = quad_filt_bank(Fco, Fs);
    
    
    wav_filt = fftfilt(real(B),env1_sig);
    
    %envelope extraction
    sig_abs = abs(wav_filt);
    env_60 = filter(b_60, a_60, sig_abs);
    env_160 = filter(b_160, a_160, sig_abs);
    
    all_bands_60 = env_60.*noise';
    all_bands_160 = env_160.*noise';

    if i ==1 
        env60_combined = fftfilt(real(B),all_bands_60);
        env160_combined = fftfilt(real(B),all_bands_160);
    else
        env60_combined = sum(fftfilt(real(B),all_bands_60),2);
        env160_combined = sum(fftfilt(real(B),all_bands_160),2);
    end
    
    env60_combined = filter(b_4k,a_4k,env60_combined)';
    env60_out(i,:) = env60_combined/max(abs(env60_combined));
    
    env160_combined = filter(b_4k,a_4k,env160_combined)';
    env160_out(i,:) = env160_combined/max(abs(env160_combined));    
end


toPlay_60 = env60_out';
toPlay_160 = env160_out';

toPlay_Hilb = make_band_chimeras_modified(filename, 'noise', bands);

end

