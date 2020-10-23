% File: SpectrogramDemo.m
% Created by: M.Heinz
% Created on: Mar 20, 2006
% Modified on: Oct 17, 2016
%
% This script generate a signal and calculates and plots a spectrogram.

clear  % clears the workspace

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Generate the signal
%%%%%%%%%%%%%%%%%%%%%%%%%%

[signal,SamplingRate_Hz]=audioread('fivewo.wav');

BW_Hz = 300;  % bandwidth to use in the spectrogram analysis  % 300 Hz typical for broadband (good temporal resolution; 50 Hz typical for narrowband (good spectral resolution)
DynamicRange_dB = 60;  % limits the dynamic range of Sgram to improve visualization of amplitude differences

[Sgram,SG_Freq_Hz,SG_Time_sec] = spectrogram_BW_DR(signal, BW_Hz, SamplingRate_Hz, DynamicRange_dB);

print -dtiff SpectrogramDemo
