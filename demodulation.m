function [dataOut, demodulate_signal] = demodulation(before_canal, bit_alloc)

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
after_remove_prefix = zeros(256,1);
length_prefixe = 32;

%% Remove the prefix cyclic %%
after_remove_prefix(1:length(before_canal)-length_prefixe) = before_canal(1+length_prefixe:length(before_canal));

%% Demodulation %%
demodulate_signal = demodulationDMT(after_remove_prefix);
for p = 1:nb_channels
    after_canal{p} = demodulate_signal(p);
end
for i = 1:nb_channels
    dataOut{i} = demodulationQAM(after_canal{i},bit_alloc,i);
end
end

