function playback = loadWav(fileName, setup, random)

    [y, fs] = audioread(fileName);    
    y=y(:,1);
    playback=0;

    if(random == 0)
        for i = 1:setup.signal.lengthBurst
           playback(i) = y(i); 
        end

        for i = setup.signal.lengthBurst:setup.signal.lengthSignal
           playback(i) = 0; 
        end
        playback = playback'; %Transpose
    end

    if(random == 1)
        r = randi([1 (length(y)-setup.signal.lengthBurst)],1,1);%Generates a number to start the mapping from y to playback
            j=0;   
        for i = r:setup.signal.lengthBurst+r
            j=j+1;
       playback(j) = y(i); 
        end

        for i = setup.signal.lengthBurst:setup.signal.lengthSignal
           playback(i) = 0; 
        end
        playback = playback'; %Transpose
    end
end