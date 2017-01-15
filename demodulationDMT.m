function [suite_symboles_out] = demodulationDMT(signal_received)

% Return the symboles for every sub-canal

%% Parameters %
% - Inputs :
%   * signal_received : signal received after the transmission into the canal
%
% - Outputs :
%   * suite_symboles_out : symboles QAM

%% FFT %%
suite_symboles_out = fft(signal_received);
    
end
