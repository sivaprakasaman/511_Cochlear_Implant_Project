clear all
close all

addpath("Chimera code and WAV files/Delgutte_Code")
addpath("Chimera code and WAV files/Chimera WAV files")
addpath("Chimera code and WAV files/SPINsents")
addpath("Heinz_Spectrogram/")
addpath("PartA_Stim")


files = ["101","102","103","104","105","106","107","108","109","110"];
%files = ["101"];

%files = ["Mt10","Mt190"];

for i = 1:length(files)

    env = strcat(files(i),'.wav'); %risk
    tfs = 'noise'; % For part A
    %tfs = strcat(files(2),'.wav'); %For part B
    chimera = 1;
    
    bands = [1,2,4,8,16]; %part A
    %bands = [1,2,4,8,16,24,32,48,64];
    
    [env_sig,Fs] = audioread(env);
    env_sig = env_sig(:,1);
    
    if ~strcmp(tfs,'noise')
        [tfs_sig,Fs2] = audioread(tfs); %assume Fs are matched
        tfs_sig = tfs_sig(:,1);
        
        if length(tfs_sig) < length(env_sig)
            tfs_sig = [tfs_sig; zeros(length(env_sig)-length(tfs_sig),1)];
        elseif length(tfs_sig) > length(env_sig)
            env_sig = [env_sig; zeros(length(tfs_sig)-length(env_sig),1)];
        end
        
    end
    
    %enable this for part A
    if strcmp(tfs,'noise')
        noise = psd_matched_noise(env_sig);
        noise = noise/max(abs(noise(:)));
        tfs_sig = noise;
        chimera = 0;
    end
    
    [toPlay_60, toPlay_160, Fs, tfs_filt_sum] = get_Stimuli(env_sig,tfs_sig,Fs,bands,chimera);
    
    %spectrogram(toPlay_60(:,1))
    toPlay_Hilb = make_band_chimeras_modified(env, tfs, bands);
    
    %plotting
%     signal = toPlay_Hilb(:,5);
%     BW_Hz = 30;
%     DynamicRange_dB = 45;
%     [Sgram,SG_Freq_Hz,SG_Time_sec] = spectrogram_BW_DR(signal, BW_Hz, Fs, DynamicRange_dB);

    cd PartA_Stim
    save(strcat(files(i),'.mat'),'toPlay_Hilb', 'toPlay_160','toPlay_60'); %part A
    
    save(strcat(files(1),'env',files(2),'tfs.mat'),'toPlay_Hilb', 'toPlay_160','toPlay_60')
    
    cd ../
 end