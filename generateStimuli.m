clear all
close all

addpath("Delgutte_Code/")
addpath("Chimera code and WAV files/Chimera WAV files")
addpath("Chimera code and WAV files/SPINsents")
addpath("Heinz_Spectrogram/")

env = '101.wav'; %risk
tfs = '120.wav'; %gin
chimera = 1;

bands = [1,2,4,8,16];

[env_sig,Fs] = audioread(env);
[tfs_sig,Fs2] = audioread(tfs); %assume Fs are matched

tfs_sig = tfs_sig(:,1);
env_sig = env_sig(:,1);

	if length(tfs_sig) < length(env_sig)
	    tfs_sig = [tfs_sig; zeros(length(env_sig)-length(tfs_sig),1)];
	elseif length(tfs_sig) > length(env_sig)
	    env_sig = [env_sig; zeros(length(tfs_sig)-length(env_sig),1)];
	end




%enable this for part A

% noise = psd_matched_noise(env_sig);
% noise = noise/max(abs(noise(:)));
% tfs_sig = noise;
% tfs = 'noise';
% chimera = 0;

[toPlay_60, toPlay_160, Fs] = get_Stimuli(env_sig,tfs_sig,Fs,bands,chimera);

%spectrogram(toPlay_60(:,1))
toPlay_Hilb = make_band_chimeras_modified(env, tfs, bands);

%plotting

signal = toPlay_Hilb(:,5);
BW_Hz = 30;
DynamicRange_dB = 45;
[Sgram,SG_Freq_Hz,SG_Time_sec] = spectrogram_BW_DR(signal, BW_Hz, Fs, DynamicRange_dB);

