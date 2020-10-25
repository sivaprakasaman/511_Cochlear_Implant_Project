clear all
close all

nsubj = 2;
nfilesA = 2;
nfilesB = 1;

folders = ["Data_Andrew"];

%Part A:

for i = 1:length(folders)
    cd(folders(i))
    %data for A"
    for j = 1:nfilesA
        clear bands60 bands60_total bands160 bands160_total bandsHilb bandsHilb_total rxntime60 rxntime160 rxntimeHilb
        load(['test',num2str(j),'.mat'])
        subj_bands60(j,:) = bands60;
        subj_bands60_total(j,:) = bands60_total;
        subj_bands160(j,:) = bands160;
        subj_bands160_total(j,:) = bands160_total;
        subj_bandsHilb(j,:) = bandsHilb;
        subj_bandsHilb_total(j,:) = bandsHilb_total;
        
        subj_rxntime60(j,:) = rxntime60;
        subj_rxntime160(j,:) = rxntime160;
        subj_rxntimeHilb(j,:) = rxntimeHilb;
    end
    
    subj_avg_bands60(i,:) =  sum(subj_bands60,1)./(sum(subj_bands60_total,1));
    subj_avg_bands160(i,:) =  sum(subj_bands160,1)./(sum(subj_bands160_total,1));
    subj_avg_bandsHilb(i,:) =  sum(subj_bandsHilb,1)./(sum(subj_bandsHilb_total,1));
    
    subj_avg_rxntime60(i,:) = sum(subj_rxntime60,1)./(sum(subj_bands60_total,1));
    subj_avg_rxntime160(i,:) = sum(subj_rxntime160,1)./(sum(subj_bands60_total,1));
    subj_avg_rxntimeHilb(i,:) = sum(subj_rxntimeHilb,1)./(sum(subj_bands60_total,1));
    
    cd ../
end

partA_bands60_mean = mean(subj_avg_bands60,1);
partA_bands60_std = std(subj_avg_bands60);

partA_bands160_mean = mean(subj_avg_bands160,1);
partA_bands160_std = std(subj_avg_bands160);

partA_bandsHilb_mean = mean(subj_avg_bandsHilb,1);
partA_bandsHilb_std = std(subj_avg_bandsHilb);

partA_rxntime60_mean = mean(subj_avg_rxntime60,1);
partA_rxntime160_mean = mean(subj_avg_rxntime160,1);
partA_rxntimeHilb_mean = mean(subj_avg_rxntimeHilb,1);



%% Part B - Sentences:

clear subj_bands60_total subj_bands160_total subj_bandsHilb_total subj_rxntime60 subj_rxntime160 subj_rxntimeHilb subj_avg_rxntime60 subj_avg_rxntime160 subj_avg_rxntimeHilb
 
for i = 1:length(folders)
    cd(folders(i))
    %data for A"
    for j = 1:nfilesB
        clear bands60_env bands60_tfs bands60_total bands160_env bands160_tfs bands160_total bandsHilb_env bandsHilb_tfs bandsHilb_total rxntime60 rxntime160 rxntimeHilb
        load(['sentence',num2str(j),'.mat'])
        
        subj_bands60_env(j,:) = bands60_env;
        subj_bands60_tfs(j,:) = bands60_tfs;
        subj_bands60_total(j,:) = bands60_total;

        subj_bands160_env(j,:) = bands160_env;
        subj_bands160_tfs(j,:) = bands160_tfs;
        subj_bands160_total(j,:) = bands160_total;
        
        subj_bandsHilb_env(j,:) = bandsHilb_env;
        subj_bandsHilb_tfs(j,:) = bandsHilb_tfs;
        subj_bandsHilb_total(j,:) = bandsHilb_total;
        
        
        subj_rxntime60(j,:) = rxntime60;
        subj_rxntime160(j,:) = rxntime160;
        subj_rxntimeHilb(j,:) = rxntimeHilb;
    end
    
    subj_avg_bands60_env(i,:) =  sum(subj_bands60_env,1)./(sum(subj_bands60_total,1));
    subj_avg_bands60_tfs(i,:) =  sum(subj_bands60_tfs,1)./(sum(subj_bands60_total,1));
    
    subj_avg_bands160_env(i,:) =  sum(subj_bands160_env,1)./(sum(subj_bands160_total,1));
    subj_avg_bands160_tfs(i,:) =  sum(subj_bands160_tfs,1)./(sum(subj_bands160_total,1));
    
    subj_avg_bandsHilb_env(i,:) =  sum(subj_bandsHilb_env,1)./(sum(subj_bandsHilb_total,1));
    subj_avg_bandsHilb_tfs(i,:) =  sum(subj_bandsHilb_tfs,1)./(sum(subj_bandsHilb_total,1));
    
    subj_avg_rxntime60(i,:) = sum(subj_rxntime60,1)./(sum(subj_bands60_total,1));
    subj_avg_rxntime160(i,:) = sum(subj_rxntime160,1)./(sum(subj_bands60_total,1));
    subj_avg_rxntimeHilb(i,:) = sum(subj_rxntimeHilb,1)./(sum(subj_bands60_total,1));

    cd ../    
end

partB1_bands60_env_mean = mean(subj_avg_bands60_env,1);
partB1_bands60_env_std = std(subj_avg_bands60_env);

partB1_bands60_tfs_mean = mean(subj_avg_bands60_tfs,1);
partB1_bands60_tfs_std = std(subj_avg_bands60_tfs);

partB1_bands160_env_mean = mean(subj_avg_bands160_env,1);
partB1_bands160_env_std = std(subj_avg_bands160_env);

partB1_bands160_tfs_mean = mean(subj_avg_bands160_tfs,1);
partB1_bands160_tfs_std = std(subj_avg_bands160_tfs);

partB1_bandsHilb_env_mean = mean(subj_avg_bandsHilb_env,1);
partB1_bandsHilb_env_std = std(subj_avg_bandsHilb_env);

partB1_bandsHilb_tfs_mean = mean(subj_avg_bandsHilb_tfs,1);
partB1_bandsHilb_tfs_std = std(subj_avg_bandsHilb_tfs);

partB1_rxntime60_mean = mean(subj_avg_rxntime60,1);
partB1_rxntime160_mean = mean(subj_avg_rxntime160,1);
partB1_rxntimeHilb_mean = mean(subj_avg_rxntimeHilb,1);



%% Part B - Music 



clear subj_bands60_total subj_bands160_total subj_bandsHilb_total subj_rxntime60 subj_rxntime160 subj_rxntimeHilb subj_avg_rxntime60 subj_avg_rxntime160 subj_avg_rxntimeHilb
 
for i = 1:length(folders)
    cd(folders(i))
    %data for A"
    for j = 1:nfilesB
        clear bands60_env bands60_tfs bands60_total bands160_env bands160_tfs bands160_total bandsHilb_env bandsHilb_tfs bandsHilb_total rxntime60 rxntime160 rxntimeHilb
        load(['music',num2str(j),'.mat'])
        
        subj_bands60_env(j,:) = bands60_env;
        subj_bands60_tfs(j,:) = bands60_tfs;
        subj_bands60_total(j,:) = bands60_total;

        subj_bands160_env(j,:) = bands160_env;
        subj_bands160_tfs(j,:) = bands160_tfs;
        subj_bands160_total(j,:) = bands160_total;
        
        subj_bandsHilb_env(j,:) = bandsHilb_env;
        subj_bandsHilb_tfs(j,:) = bandsHilb_tfs;
        subj_bandsHilb_total(j,:) = bandsHilb_total;
        
        
        subj_rxntime60(j,:) = rxntime60;
        subj_rxntime160(j,:) = rxntime160;
        subj_rxntimeHilb(j,:) = rxntimeHilb;
    end
    
    subj_avg_bands60_env(i,:) =  sum(subj_bands60_env,1)./(sum(subj_bands60_total,1));
    subj_avg_bands60_tfs(i,:) =  sum(subj_bands60_tfs,1)./(sum(subj_bands60_total,1));
    
    subj_avg_bands160_env(i,:) =  sum(subj_bands160_env,1)./(sum(subj_bands160_total,1));
    subj_avg_bands160_tfs(i,:) =  sum(subj_bands160_tfs,1)./(sum(subj_bands160_total,1));
    
    subj_avg_bandsHilb_env(i,:) =  sum(subj_bandsHilb_env,1)./(sum(subj_bandsHilb_total,1));
    subj_avg_bandsHilb_tfs(i,:) =  sum(subj_bandsHilb_tfs,1)./(sum(subj_bandsHilb_total,1));
    
    subj_avg_rxntime60(i,:) = sum(subj_rxntime60,1)./(sum(subj_bands60_total,1));
    subj_avg_rxntime160(i,:) = sum(subj_rxntime160,1)./(sum(subj_bands60_total,1));
    subj_avg_rxntimeHilb(i,:) = sum(subj_rxntimeHilb,1)./(sum(subj_bands60_total,1));

    cd ../    
end

partB2_bands60_env_mean = mean(subj_avg_bands60_env,1);
partB2_bands60_env_std = std(subj_avg_bands60_env);

partB2_bands60_tfs_mean = mean(subj_avg_bands60_tfs,1);
partB2_bands60_tfs_std = std(subj_avg_bands60_tfs);

partB2_bands160_env_mean = mean(subj_avg_bands160_env,1);
partB2_bands160_env_std = std(subj_avg_bands160_env);

partB2_bands160_tfs_mean = mean(subj_avg_bands160_tfs,1);
partB2_bands160_tfs_std = std(subj_avg_bands160_tfs);

partB2_bandsHilb_env_mean = mean(subj_avg_bandsHilb_env,1);
partB2_bandsHilb_env_std = std(subj_avg_bandsHilb_env);

partB2_bandsHilb_tfs_mean = mean(subj_avg_bandsHilb_tfs,1);
partB2_bandsHilb_tfs_std = std(subj_avg_bandsHilb_tfs);

partB2_rxntime60_mean = mean(subj_avg_rxntime60,1);
partB2_rxntime160_mean = mean(subj_avg_rxntime160,1);
partB2_rxntimeHilb_mean = mean(subj_avg_rxntimeHilb,1);


%% Plotting 

% Part A figure 

bandv = [1,2,4,8,16];

hold on 
plot(bandv,partA_bands60_mean*100,'r','Linewidth',2)
plot(bandv,partA_bands160_mean*100,'b','Linewidth',2)
plot(bandv,partA_bandsHilb_mean*100,'g','Linewidth',2)
hold off
title('Percent Correct vs Number of Bands');
ylabel("%Correct")
xlabel("# of Bands");
legend('60 Hz LPF', '160 Hz LPF', 'Hilbert');


figure;
hold on 
plot(bandv,partA_rxntime60_mean,'r','Linewidth',2)
plot(bandv,partA_rxntime160_mean,'b','Linewidth',2)
plot(bandv,partA_rxntimeHilb_mean,'g','Linewidth',2)
hold off
title('Reaction Time vs Number of Bands');
ylabel("Time (s)")
xlabel("# of Bands");
legend('60 Hz LPF', '160 Hz LPF', 'Hilbert');


% Part B - Sentences figure

bandv = [1,2,4,8,16,24,32,48,64];
figure;
hold on 
plot(bandv,partB1_bands60_env_mean*100,'r','Linewidth',2)
plot(bandv,partB1_bands160_env_mean*100,'b','Linewidth',2)
plot(bandv,partB1_bandsHilb_env_mean*100,'g','Linewidth',2)

plot(bandv,partB1_bands60_tfs_mean*100,'r--','Linewidth',2)
plot(bandv,partB1_bands160_tfs_mean*100,'b--','Linewidth',2)
plot(bandv,partB1_bandsHilb_tfs_mean*100,'g--','Linewidth',2)
hold off
legend('60 Hz\_Env', '160 Hz\_Env', 'Hilbert\_Env','60 Hz\_Tfs', '160 Hz\_Tfs', 'Hilbert\_Tfs');
title('Sentences | Feature Identified vs Number of Bands');
ylabel("%Identified")
xlabel("Bands")
xticks(bandv);

figure;
hold on 
plot(bandv,partB1_rxntime60_mean,'r','Linewidth',2)
plot(bandv,partB1_rxntime160_mean,'b','Linewidth',2)
plot(bandv,partB1_rxntimeHilb_mean,'g','Linewidth',2)
hold off
title('Sentences | Reaction Time vs Number of Bands');
ylabel("Time (s)")
xlabel("# of Bands");
legend('60 Hz LPF', '160 Hz LPF', 'Hilbert');


% Part B - Music figure
figure;
hold on 
plot(bandv,partB2_bands60_env_mean*100,'r','Linewidth',2)
plot(bandv,partB2_bands160_env_mean*100,'b','Linewidth',2)
plot(bandv,partB2_bandsHilb_env_mean*100,'g','Linewidth',2)

plot(bandv,partB2_bands60_tfs_mean*100,'r--','Linewidth',2)
plot(bandv,partB2_bands160_tfs_mean*100,'b--','Linewidth',2)
plot(bandv,partB2_bandsHilb_tfs_mean*100,'g--','Linewidth',2)
hold off
legend('60 Hz\_Env', '160 Hz\_Env', 'Hilbert\_Env','60 Hz\_Tfs', '160 Hz\_Tfs', 'Hilbert\_Tfs');
title('Music | Feature Identified vs Number of Bands');
ylabel("%Identified")
xlabel("Bands")
xticks(bandv);

figure;
hold on 
plot(bandv,partB2_rxntime60_mean,'r','Linewidth',2)
plot(bandv,partB2_rxntime160_mean,'b','Linewidth',2)
plot(bandv,partB2_rxntimeHilb_mean,'g','Linewidth',2)
hold off
title('Music | Reaction Time vs Number of Bands');
ylabel("Time (s)")
xlabel("# of Bands");
legend('60 Hz LPF', '160 Hz LPF', 'Hilbert');

