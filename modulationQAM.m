function [suite_symboles] = modulationQAM(data, type_QAM_bits_allocation, i)

% Return the symbols QAM

%% Parameters %
% - Inputs :
%   * data : vector containing bits
%   * type_QAM_bits_allocation : vector containing types of QAM by canal
%   * i : number of the sub-canal treating
%
% - Outputs :
%   * dataOut : symbols QAM for every sub-canal
    %% Modulation %%

    nb_bits_symbole = log2(type_QAM_bits_allocation(i)); 
    dataInMatrix    = reshape(data, length(data)/nb_bits_symbole, nb_bits_symbole);
    dataSymbolsIn   = bi2de(dataInMatrix);
    suite_symboles  = qammod(dataSymbolsIn, type_QAM_bits_allocation(i));

end
