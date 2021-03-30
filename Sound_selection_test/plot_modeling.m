function  plot_modeling(titlename,savename, type, minus20, minus10, plus0, plus10, plus20)
    % type = 1, gives the median
    % type = 0, gives the mean
    if type == 1 
        mean_m20 = median(minus20(:));
        max_m20 = max(minus20(:));
        min_m20 = min(minus20(:));

        mean_m10 = median(minus10(:));
        max_m10 = max(minus10(:));
        min_m10 = min(minus10(:));

        mean_0 = median(plus0(:));
        max_0 = max(plus0(:));
        min_0 = min(plus0(:));

        mean_10 = median(plus10(:));
        max_10 = max(plus10(:));
        min_10 = min(plus10(:));

        mean_20 = median(plus20(:));
        max_20 = max(plus20(:));
        min_20 = min(plus20(:));

        figure('Name',titlename);
        x = [-20 -10 0 10 20];
        plot(x(1), mean_m20,'ob',x(2), mean_m10,'db',x(3), mean_0,'*b',x(4), mean_10,'xb',x(5), mean_20,'sb')
        hold on
        y1 = [mean_m20 mean_m10 mean_0 mean_10 mean_20]; 
        yneg1 = [min_m20-mean_m20 min_m10-mean_m10 min_0-mean_0 min_10-mean_10 min_20-mean_20];
        ypos1 = [max_m20-mean_m20 max_m10-mean_m10 max_0-mean_0 max_10-mean_10 max_20-mean_20];
        errorbar(x,y1,yneg1,ypos1,'r')
        xlabel('SNR level');ylabel('Distance [cm]');
        title(titlename);
        legend('Median distance at -20 SNR','Median distance at -10 SNR', 'Median distance at 0 SNR','Median distance at 10 SNR','Median distance at 20 SNR', 'Min and max distance')
        hold off
        savestr = sprintf(savename);
        saveas(gcf,savestr);
    end
    
    if type == 0
        mean_m20 = mean(minus20(:));
        max_m20 = max(minus20(:));
        min_m20 = min(minus20(:));

        mean_m10 = mean(minus10(:));
        max_m10 = max(minus10(:));
        min_m10 = min(minus10(:));

        mean_0 = mean(plus0(:));
        max_0 = max(plus0(:));
        min_0 = min(plus0(:));

        mean_10 = mean(plus10(:));
        max_10 = max(plus10(:));
        min_10 = min(plus10(:));

        mean_20 = mean(plus20(:));
        max_20 = max(plus20(:));
        min_20 = min(plus20(:));

        figure('Name',titlename);
        x = [-20 -10 0 10 20];
        plot(x(1), mean_m20,'ob',x(2), mean_m10,'db',x(3), mean_0,'*b',x(4), mean_10,'xb',x(5), mean_20,'sb')
        hold on
        y1 = [mean_m20 mean_m10 mean_0 mean_10 mean_20]; 
        yneg1 = [min_m20-mean_m20 min_m10-mean_m10 min_0-mean_0 min_10-mean_10 min_20-mean_20];
        ypos1 = [max_m20-mean_m20 max_m10-mean_m10 max_0-mean_0 max_10-mean_10 max_20-mean_20];
        errorbar(x,y1,yneg1,ypos1,'r')
        xlabel('SNR level');ylabel('Distance [cm]');
        title(titlename);
        legend('Mean distance at -20 SNR','Mean distance at -10 SNR', 'Mean distance at 0 SNR','Mean distance at 10 SNR','Mean distance at 20 SNR', 'Min and max distance')
        hold off
        savestr = sprintf(savename);
        saveas(gcf,savestr);
    
    end
end

