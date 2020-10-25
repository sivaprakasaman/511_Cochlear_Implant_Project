addpath("PartB_Stim");

clc;
close all
clear all

files = ["s01envs02tfs.mat","s02envs01tfs.mat"];
%01 ferer jaquer
%02 twinkle

stims = 2;
conds = 3;
bands = 9;
Fs = 22050;
trials = 2;

all_trials = zeros(bands*conds*stims,3);
i = 0;

for s = 1:stims
    
    for c = 1:conds
        
        for b = 1:bands
            i = i+1;
            all_trials(i,1:3) = [s,c,b];
            
        end 
    end
    
end

sentences = ('1 - Frere Jacuqes, 2 - Twinkle, Twinkle');

bands60_env = zeros(1,bands);
bands60_tfs = zeros(1,bands);

bands160_env = zeros(1,bands);
bands160_tfs = zeros(1,bands);

bandsHilb_env = zeros(1,bands);
bandsHilb_tfs = zeros(1,bands);

bands60_total = zeros(1,bands);
bands160_total = zeros(1,bands);
bandsHilb_total = zeros(1,bands);

rxntime60 = zeros(1,bands);
rxntime160 = zeros(1,bands);
rxntimeHilb = zeros(1,bands);

for t = 1:trials
    
    randoms = randperm(bands*conds*stims);
    random_trials = all_trials(randoms,:);
    
    for k = 1:length(random_trials)
        
        clear toPlay_60 toPlay_160 toPlay_Hilb
        load(files(random_trials(k,1)));
        
        disp(['Round: ',num2str(t), ' Trial: ', num2str(k)])
        disp(sentences);
        
        env = random_trials(k,1);
        condition = random_trials(k,2);
        band = random_trials(k,3);
        
        if condition == 1
            sound(toPlay_60(:,band),Fs);
            tic
            answer = input('Which sound did you hear? ');
            x = toc;
            rxntime60(1,band) = rxntime60(1,band) + x;
            bands60_total(1,band) = bands60_total(1,band) + 1;
            
            if answer == env
                bands60_env(1,band) = bands60_env(1,band) + 1;
            else
                bands60_tfs(1,band) = bands60_tfs(1,band) + 1;
            end
        elseif condition == 2
            sound(toPlay_160(:,band),Fs);
            tic
            answer = input('Which sound did you hear? ');
            x = toc;
            rxntime160(1,band) = rxntime160(1,band) + x;
            bands160_total(1,band) = bands160_total(1,band) + 1;
            
            if answer == env
                bands160_env(1,band) = bands160_env(1,band) + 1;
            else
                bands160_tfs(1,band) = bands160_tfs(1,band) + 1;
            end
            
        elseif condition == 3
            sound(toPlay_Hilb(:,band),Fs);
            tic
            answer = input('Which sound did you hear? ');
            x = toc;
            rxntimeHilb(1,band) = rxntimeHilb(1,band) + x;
            bandsHilb_total(1,band) = bandsHilb_total(1,band) + 1;
            
            if answer == env
                bandsHilb_env(1,band) = bandsHilb_env(1,band) + 1;
            else
                bandsHilb_tfs(1,band) = bandsHilb_tfs(1,band) + 1;
            end
        else
            disp('error')
        end
        
    end
    
end
bandv = [1,2,4,8,16,24,32,48,64];
figure;
hold on 
plot(bandv,bands60_env*100./bands60_total,'r','Linewidth',2)
plot(bandv,bands160_env*100./bands160_total,'b','Linewidth',2)
plot(bandv,bandsHilb_env*100./bandsHilb_total,'g','Linewidth',2)

plot(bandv,bands60_tfs*100./bands60_total,'r--','Linewidth',2)
plot(bandv,bands160_tfs*100./bands160_total,'b--','Linewidth',2)
plot(bandv,bandsHilb_tfs*100./bandsHilb_total,'g--','Linewidth',2)
hold off
legend('60 Hz\_Env', '160 Hz\_Env', 'Hilbert\_Env','60 Hz\_Tfs', '160 Hz\_Tfs', 'Hilbert\_Tfs');
title('Feature Identified vs Number of Bands');
ylabel("%Identified")
xlabel("Bands")
xticks(bandv);

figure;
hold on 
plot(bandv,rxntime60./bands60_total)
plot(bandv,rxntime160./bands160_total)
plot(bandv,rxntimeHilb./bandsHilb_total)
hold off
title('Reaction Time vs Number of Bands');
ylabel("Time (s)")
xlabel("# of Bands");
legend('60 Hz LPF', '160 Hz LPF', 'Hilbert');

cd PartB_Results
num = (input('Test Number? '));
save(['music',num2str(num),'.mat'],'bands60_env','bands60_tfs','bands60_total','bands160_env','bands160_tfs','bands160_total','bandsHilb_env','bandsHilb_tfs','bandsHilb_total','rxntime60','rxntime160','rxntimeHilb');