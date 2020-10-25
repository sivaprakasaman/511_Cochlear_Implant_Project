function [toPlay_60, toPlay_160, Fs,tfs_filt_sum] = get_Stimuli(env_sig,tfs_sig,Fs,bands,chimera)


% Fs = 44.1e3;

% filename = '102.wav'


%Signal for envelope extraction

%full-wave rectification at 60Hz and 160Hz

%NOTE: Accidentally used 60 Hz filter first time around, so changing to 16
%here. 

[b_60,a_60] = butter(3, 16/(Fs/2),'low');
[b_160,a_160] = butter(3, 160/(Fs/2),'low');
[b_4k,a_4k] = butter(3, 4e3/(Fs/2),'low');

% noise = randn(1,length(wav_file));

% bands = [1,2,4,8,16]

for i = 1:length(bands)
    
    Fco = equal_xbm_bands(0,4000,bands(i));
    B = quad_filt_bank(Fco, Fs);
    
    
    env_filt = fftfilt(real(B),env_sig);
    tfs_filt = fftfilt(real(B),tfs_sig);
   
    if i > 1
        tfs_filt_sum(:,i) = sum(tfs_filt,2);
    else
        tfs_filt_sum(:,i) = tfs_filt;
    end
    %envelope extraction
    env_abs = abs(env_filt);
    env_60 = filter(b_60, a_60, env_abs);
    env_160 = filter(b_160, a_160, env_abs);
    
    %get tfs envelope and remove
%     tfs_abs = abs(tfs_filt);
%     tfs_60 = filter(b_60, a_60, tfs_abs);
%     tfs_160 = filter(b_160, a_160, tfs_abs);
    
    %allows for quick hilbert tfs extraction if it's chimera for Part B
    %otherwise will just assume tfs has no envelope
    
    if chimera 
          tfs_sig = cos(angle(hilbert(tfs_sig)));
    end
    
    all_bands_60 = env_60.*tfs_sig;
    all_bands_160 = env_160.*tfs_sig;

    env60_combined = zeros(length(all_bands_60),1); 
    env160_combined = zeros(length(all_bands_60),1); 

    if i ==1 
        env60_combined(end:-1:1,1) = fftfilt(real(B),all_bands_60(end:-1:1,:));
        env160_combined(end:-1:1,1) = fftfilt(real(B),all_bands_160(end:-1:1,:));
    else
        env60_combined(end:-1:1,1) = sum(fftfilt(real(B),all_bands_60(end:-1:1,:)),2);
        env160_combined(end:-1:1,1) = sum(fftfilt(real(B),all_bands_160(end:-1:1,:)),2);
    end
    
    env60_combined = filter(b_4k,a_4k,env60_combined)';
    env60_out(i,:) = env60_combined/max(abs(env60_combined));
    
    env160_combined = filter(b_4k,a_4k,env160_combined)';
    env160_out(i,:) = env160_combined/max(abs(env160_combined));    
end


toPlay_60 = env60_out';
toPlay_160 = env160_out';

end

