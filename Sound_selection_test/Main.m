 %%
clc
clear
close all
%Stier til mapper hvor der ligger andre mat filer
addpath(genpath('lib/rir')); %Sti til RIR-generatoren
addpath(genpath('lib')); %Alle filer i lib mappen er lavet af jesper & usama
addpath(genpath('functions')); %Alle filer i functions mappen er lavet af os
addpath(genpath('sound')); %Lydfiler som kan bruges. 'continuous' er støj indtil videre
%% Setup
%Setup til rum dimensioner, signal variabler osv..
setup=defaultMiscSetup([]); 
setup=defaultSetup(setup);

%% Plot Room
plotRoom(setup); %Plot af rum baseret på setup værdierne

%% Rirs
rirs=generateRirs(setup); %Genererer et room impulse response (Kommer fra RIR-generator)
plotRIRs(rirs); %Plot af room impulse responsen (Jespers funktion)

%% Generate Signals
for index=1:1
%White Gaussian noise
    %playback = [wgn(setup.signal.lengthBurst,1,0);... %Første del genererer et random signal
    %        zeros(setup.signal.lengthSignal-setup.signal.lengthBurst,1)]; % Genererer et White Gaussian Noise signal
%ego-noise
    playback = loadWav('Turtlebot2_motorSound.wav', setup, 1); %Loader en fil som bruges til playback... Random=0->tager første 1500 samples, Random=1->tager 1500 sammenhængende samples tilfældigt

 %IMPORTANT: Playback skal være lengthSignalx1 

signals = generateSignals(rirs, [], setup, playback); %Genererer den lyd som mikrofonen hører (udfra RIR) (Jespers funktion)

%% Extract Clean and Observed
[clean, observed] = ExtractCleanAndObserved(signals); %Vi extracter de signaler vi har brug for (Clean = Playback lyden, Observed = Den lyd som mikrofonen hører)

%% Distance calc
[dist, tau, MaxIndex] = DistanceCalc(clean, observed, setup, index) %Udregner distancen og tau (i samples) (Vores egen funktion)
    filename = sprintf('ego-noise_at%dSNR.csv',setup.signal.snr);
fileID = fopen(filename, 'a');
fprintf(fileID, 'Test number: ;%d; Distance = ;%4.2f; tau = ;%d; MaxIndex = ;%d;\n',index,dist,tau,MaxIndex);
fclose(fileID);

end

