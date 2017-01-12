function [signal_after_egalisation] = egalisation(rep_freq)
    signal_after_egalisation = zeros(length(rep_freq),1);
    for i =1:length(rep_freq)
        signal_after_egalisation(i) = rep_freq(i);
    end
end

