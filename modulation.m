function [dataIn, data_concat, symboles_out] = modulation(bit_In, bit_alloc)

%% Parameters %%
% - Inputs :
%   * bit_In : bits incomming
%   * bit_alloc : vector containing types of QAM by canal
%
% - Outputs :
%   * dataIn : bits dispatch in the canals
%   * data_concat : data before sending to the canal

global j 
j=1;

%% Initialisation of parameters %%
nb_channels = 256;
dataIn = cell(1,nb_channels);
symboles_out = cell(1,nb_channels); 
before_canal = cell(1,nb_channels); 
data_concat = zeros(2*nb_channels,1);
length_prefixe = 32;
symbole = zeros(256,1);

%% Transmitter side %%

for i = 1:nb_channels
    
    if bit_alloc(i) == 4
        data = bit_In(1:log2(4));
        bit_In(1:log2(4)) = [];
    elseif bit_alloc(i) == 8
        data = bit_In(1:log2(8));
        bit_In(1:log2(8)) = [];
    elseif bit_alloc(i) == 16
        data = bit_In(1:log2(16));
        bit_In(1:log2(16)) = [];
    end
    
    dataIn{i} = data;
    symboles_out{i} = modulationQAM(dataIn{i},bit_alloc,i);
    symbole = cell2mat(symboles_out);
end

data_concat = modulationDMT(symbole);

%% Add the prefix cyclic %%
length_data = length(data_concat);
data_concat(1+length_prefixe:length_data+length_prefixe) = data_concat(1:length_data); 
data_concat(1:length_prefixe) = data_concat(1+length_data:length_data+length_prefixe);

end

