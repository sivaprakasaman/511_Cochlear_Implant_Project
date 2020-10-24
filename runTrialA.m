close all
clear all

toRun = 60;

stims = 10;
conds = 3;
bands = 5;
Fs = 44.1e3;

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

randoms = randperm(bands*conds*stims);

random_trials = all_trials(randoms(1:toRun),:);

addpath("PartA_Stim")

files = ["101.mat","102.mat","103.mat","104.mat","105.mat","106.mat","107.mat","108.mat","109.mat","110.mat"];
sentences = ('1- His plan meant taking a big risk, 2- Stir your coffee with a spoon, 3- Miss White wont think about the crack, 4- He would think about the rag, 5- The plow was pulled by an ox, 6- The old train was powered by steam.');
sentences2 = ('7- The Old man talked about the lungs, 8- I was considering the crook, 9- Lets decide by tossing a coin, 10- The doctor prescribed the drug');

bands60 = zeros(1,bands);
bands160 = zeros(1,bands);
bandsHilb = zeros(1,bands);

bands60_total = zeros(1,bands);
bands160_total = zeros(1,bands);
bandsHilb_total = zeros(1,bands);

rxntime60 = zeros(1,bands);
rxntime160 = zeros(1,bands);
rxntimeHilb = zeros(1,bands);

for k = 1:length(random_trials)
    
    clear toPlay_60 toPlay_160 toPlay_Hilb 
    load(files(random_trials(k,1)));
    
    disp(['Trial: ', num2str(k)])
    disp(sentences);
    disp(sentences2);

    correct = random_trials(k,1);
    condition = random_trials(k,2);
    band = random_trials(k,3);
    
    if condition == 1
        sound(toPlay_60(:,band),Fs);
        tic
        answer = input('Which did you hear? ');
        x = toc;
        rxntime60(1,band) = rxntime60(1,band) + x;
        bands60_total(1,band) = bands60_total(1,band) + 1;
        
        if answer == correct
            bands60(1,band) = bands60(1,band) + 1;
        end
    elseif condition == 2
        sound(toPlay_160(:,band),Fs);
        tic
        answer = input('Which did you hear? ');
        x = toc;
        rxntime160(1,band) = rxntime160(1,band) + x;
        bands160_total(1,band) = bands160_total(1,band) + 1;

        if answer == correct
            bands160(1,band) = bands160(1,band) + 1;
        end
        
    elseif condition == 3
        sound(toPlay_Hilb(:,band),Fs);
        tic
        answer = input('Which did you hear? ');
        x = toc;
        rxntimeHilb(1,band) = rxntimeHilb(1,band) + x;
        bandsHilb_total(1,band) = bandsHilb_total(1,band) + 1;

        if answer == correct
            bandsHilb(1,band) = bandsHilb(1,band) + 1;
        end
    else
        disp('error')
    end

end

bandv = [1,2,4,8,16];

hold on 
plot(bandv,bands60./bands60_total)
plot(bandv,bands160./bands160_total)
plot(bandv,bandsHilb./bandsHilb_total)
hold off
title('Percent Correct vs Number of Bands');
ylabel("%Correct")
xlabel("# of Bands");
legend('60 Hz LPF', '160 Hz LPF', 'Hilbert');


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

cd PartA_Results
num = str2num(input('Test Number? '));
save(['test',num,'.mat'],'bands60','bands60_total','bands160','bands160_total','bandsHilb','bandsHilb_total','rxntime60','rxntime160','rxntimeHilb');