function [dataOutMat, demodulate_signal] = demodulation_signal(before_canal, bit_alloc, rep_freq)

%% Parameters %%
% - Inputs :
%   * before_canal : real symbols received after the transmission into the canal
%   * bit_alloc : vector containing types of QAM by canal
%
% - Outputs :
%   * dataOut : bits out

%% Variables %%

nb_channels = 256;
after_canal = cell(1,256); 
dataOut = cell(1,256);
% after_remove_prefix = zeros(256,1);
% length_prefixe = 32;
indice = 1;

% %% Remove the prefix %%
% after_remove_prefix(1:length(before_canal)-length_prefixe) = before_canal(1+length_prefixe:length(before_canal));

%% Demodulation %%
demodulate_signal = egalisation(rep_freq, before_canal);

for p = 1:nb_channels
    after_canal{p} = demodulate_signal(p);
end

for p = 1:nb_channels
    dataOut{p} = demodulationQAM(after_canal{p},bit_alloc,p);
end

for y = 1:length(dataOut)
    for j = 1:length(dataOut{y})
        dataOutMat(indice) = dataOut{y}(j);
        indice = indice + 1;
    end
end

end

