function [suite_symboles_out] = demodulationDMT(signal_received)

% Return the symboles for every sub-canal

%% Parameters %
% - Inputs :
%   * signal_received : signal received after the transmission into the canal
%
% - Outputs :
%   * suite_symboles_out : symboles QAM

j = 1;
signal_comp = zeros(length(signal_received)/2,1);


%% FFT %%
suite_symboles_out = fft(signal_received);
    
end
