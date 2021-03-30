%% extract Clean and observed
function [clean, observed] = ExtractCleanAndObserved(signals)
clean = signals.clean(:,1);
observed = signals.observRefl(:,1);
end