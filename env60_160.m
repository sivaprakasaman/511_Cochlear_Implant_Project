addpath("Delgutte_Code/")
addpath("Chimera code and WAV files/SPINsents")

%Creating the Filter bands (Part A)
clear all
close all

Fs = 44.1e3;
% Fco1 = equal_xbm_bands(0,4000,1);
% b1 = quad_filt_bank(Fco1, Fs);
%
% Fco2 = equal_xbm_bands(0,4000,2);
% b2 = quad_filt_bank(Fco2, Fs);
%
% Fco4 = equal_xbm_bands(0,4000,4);
% b4 = quad_filt_bank(Fco4, Fs);
%
% Fco8 = equal_xbm_bands(0,4000,8);
% b8 = quad_filt_bank(Fco8, Fs);

Fco16 = equal_xbm_bands(0,4000,16);
b16 = quad_filt_bank(Fco16, Fs);

%Envelope Extractions (Part B)



%CAN MODIFY THIS LINE SO CAN EASILY SWITCH SENTENCES OUT/MAKE INTO A FXN
filename = '101.wav'

[wav_file Fs2] = audioread(filename);

%Signal for envelope extraction

%full-wave rectification at 60Hz and 160Hz
env1_sig = wav_file(:,1);
sig_abs = abs(env1_sig);

[b_60,a_60] = butter(3, 60/(Fs/2),'low');
[b_160,a_160] = butter(3, 160/(Fs/2),'low');
[b_4k,a_4k] = butter(3, 4e3/(Fs/2),'low');

noise = randn(1,length(wav_file));

bands = [1,2,4,8,16]

for i = 1:length(bands)
    
    Fco = equal_xbm_bands(0,4000,bands(i));
    B = quad_filt_bank(Fco, Fs);
    
    %     if i == 1
    wav_filt = fftfilt(real(B),env1_sig);
    %     else
    %       wav_file = sum(fftfilt(real(B),env1_sig),2);
    %     end
    
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


toPlay_60 = env60_out;
toPlay_160 = env160_out;

%sound(toPlay_60(5,:),Fs);

