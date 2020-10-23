clear all
close all

addpath("Delgutte_Code/")
addpath("Chimera code and WAV files/SPINsents")
addpath("Heinz_Spectrogram/")

filename = 'fivewo.wav';
bands = [1,2,4,8,16];

[toPlay_60, toPlay_160, toPlay_Hilb, Fs] = get_Stimuli(filename, bands);

%spectrogram(toPlay_60(:,1))

signal = toPlay_Hilb(:,1);
BW_Hz = 30;
DynamicRange_dB = 45;

[Sgram,SG_Freq_Hz,SG_Time_sec] = spectrogram_BW_DR(signal, BW_Hz, Fs, DynamicRange_dB);
