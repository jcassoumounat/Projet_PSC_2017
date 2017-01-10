function [dataOut] = demodulationQAM(dataCanal, type_QAM_bits_allocation,i)

% Return the bits for every sub-canal

%% Parameters %%
% - Inputs :
%   * dataCanal : symboles received after demodulation DMT
%   * type_QAM_bits_allocation : vector containing types of QAM by canal
%   * i : number of the sub-canal treating
%
% - Outputs :
%   * dataOut : bits for every sub-canal


%% Demodulation %%
nb_bits_symbole = log2(type_QAM_bits_allocation(i));
signal_demod = qamdemod(dataCanal,type_QAM_bits_allocation(i));
dataOutMatrix = de2bi(signal_demod,nb_bits_symbole);
dataOut = dataOutMatrix(:);


end
