
function signals=generateSignals(rirs,signals,setup, playback, spkrIR,spkrDelay)
%     rng(0);
    %Playback sound
%     signals.clean=[randn(setup.signal.lengthBurst,1);...
%         zeros(setup.signal.lengthSignal-setup.signal.lengthBurst,1)]; %Add empty sound
    

    signals.clean = playback;
    
%     rng('shuffle');
    if nargin>4 %Hvis antallet af argumneter er over 4 (er den ikke)
        signals.clean=circshift(fftfilt(spkrIR(1,:),signals.clean),-spkrDelay(1));
        if size(spkrIR,1)==2
            signals.cleanTrue=circshift(fftfilt(spkrIR(2,:),signals.clean),-spkrDelay(2));
        else
            signals.cleanTrue=signals.clean;
        end
        signals.direct=fftfilt(rirs.direct',signals.cleanTrue);
        signals.received=fftfilt(rirs.all',signals.cleanTrue);
        signals.reflec=fftfilt(rirs.reflec',signals.cleanTrue);
    else
        signals.direct=fftfilt(rirs.direct',signals.clean);
        signals.received=fftfilt(rirs.all',signals.clean);
        signals.reflec=fftfilt(rirs.reflec',signals.clean);
%         figure(68); %Kan plottes hvis i vil visualisere det
%         subplot(3, 1, 1);
%         plot(signals.direct);
%         subplot(3, 1, 2);
%         plot(signals.received);
%         subplot(3, 1, 3);
%         plot(signals.reflec);
    end

    
    
% %     add speaker response, assuming one reflector only
%     if nargin>3       
%         signals.direct=circshift(fftfilt(spkrIR,signals.direct),-spkrDelay);
%         signals.received=circshift(fftfilt(spkrIR,signals.received),-spkrDelay);
%         signals.reflec=circshift(fftfilt(spkrIR,signals.reflec),-spkrDelay);
%     end
    
%   Add sensor noise
    for kk=1:setup.array.micNumber
        if length(setup.signal.snr)==1
            signals.noise(:,kk)=sqrt(var(signals.received(:,kk))...
                /10^(setup.signal.snr/10))*randn(length(signals.received(:,kk)),1);
        else
            signals.noise(:,kk)=sqrt(var(signals.received(:,kk))...
                /10^(setup.signal.snr(kk)/10))*randn(length(signals.received(:,kk)),1);
        end
    end
    %plot(signals.noise);
    
    %% DIFFUSE NOISE

    signals.diffNoise=generateMultichanBabbleNoise(setup.signal.lengthSignal,...
        setup.array.micNumber,...
        setup.array.micPos,...
        setup.room.soundSpeed,...
        'spherical',...
        setup.signal.diffNoiseStr);

    for kk=1:setup.array.micNumber
        signals.diffNoise(:,kk)=sqrt(var(signals.received(:,kk))...
            /10^(setup.signal.sdnr/10))*signals.diffNoise(:,kk)...
            /sqrt(var(signals.diffNoise(:,kk)));
    end
    
    %%    
    signals.observ=signals.received+signals.noise+signals.diffNoise;
    signals.observRefl=signals.reflec+signals.noise+signals.diffNoise;
end
