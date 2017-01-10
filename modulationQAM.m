function [suite_symboles] = modulationQAM(data, type_QAM_bits_allocation, i)

%% Concernant les variables %%
% dataIn : vecteur colonne contenant les bits à transmettre
% type_QAM_bits_allocation : vecteur colonne contenant le type de QAM donné par bit-allocation
% i : numéro du canal que l'on traite

nb_bits_symbole = log2(type_QAM_bits_allocation(i)); 

dataInMatrix = reshape(data,length(data)/nb_bits_symbole,nb_bits_symbole);
dataSymbolsIn = bi2de(dataInMatrix);

%% Modulation %%
suite_symboles = qammod(dataSymbolsIn, type_QAM_bits_allocation(i), 0);

end
