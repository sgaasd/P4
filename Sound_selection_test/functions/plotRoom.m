function plotRoom(setup)

    x = setup.room.dimensions(1);
    y = setup.room.dimensions(2);
    z = setup.room.dimensions(3);

    figure(69);
    title('Room');
    xlabel('Distance [m]');ylabel('Distance [m]');

    
    %% Lines
    l = line([0, x], [0, 0]); %Bottom line
    line([0, x], [y, y]); %Top line
    line([0, 0], [0, y]); %Left line
    line([x, x], [0, y]); %Right line
    
    %% Limits
    xlim([-1, x+1]);
    ylim([-1, y+1]);
    grid on
    
    %% Mic & Speaker
    hold on
    mic = plot(setup.room.receivPos(1), setup.room.receivPos(2), '.', 'MarkerSize', 20); %Mic
    speaker = plot(setup.room.sourcePos(1), setup.room.sourcePos(2), 'sr', 'MarkerSize', 15,'MarkerFaceColor','r'); %Speaker

    legend([l, mic speaker], {'Wall', 'Mic', 'Speaker'});
    
end