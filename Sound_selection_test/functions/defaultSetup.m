%% SETUP
function [setup] = defaultSetup(setup)
    setup.misc.trueToaDim=2;
    setup.misc.trueToaOrder=1;

    setup.signal.lengthBurst=1500; %Længden af den signal vi sender ud
    setup.signal.lengthSignal=10000; %Længden af hele signalet
    setup.signal.snr=20;
    setup.signal.sdnr=80;
    % setup.signal.sampFreq=44100/2;
    setup.signal.sampFreq=44100;
   
    setup.signal.diffNoiseStr='Turtlebot2_motorSound.wav'; %Baggrundstøj wav fil

    setup.array.micOffset=0;
    setup.array.micNumber=1;
    setup.array.micSpacing=360/setup.array.micNumber;
    setup.array.micAngles=setup.array.micOffset...
        +setup.array.micSpacing*(0:(setup.array.micNumber-1))';
    setup.array.micRadius=0.2;
    setup.array.micPos=setup.array.micRadius...
        *[cosd(setup.array.micAngles),sind(setup.array.micAngles)];

    setup.rirGen.length=[];
    setup.rirGen.micType='omnidirectional';
    setup.rirGen.order=-1;

    setup.room.dimensions=[6,4,3];
    setup.room.T60=0.6;
    setup.room.soundSpeed=343;
    setup.room.distSourceToReceiv=0;
    Dest=setup.room.distSourceToReceiv/setup.room.soundSpeed...
        *setup.signal.sampFreq;
    setup.room.distToWall=1;
    setup.room.sourcePos=[3, .5, 1];
    setup.room.receivPos=[3, .4, 1];
    %IMPORTANT: Når positionen ændres skal vi være sikker på at distance
    %intervallet 
    
    
end