function [dataIn, data_concat] = modulation(bit_In, bit_alloc)

global j
j=1;

%% Initialisation of parameters %%
nb_channels = 256;
dataIn = cell(1,256);
symboles_out = cell(1,256); 
before_canal = cell(1,256); 
data_concat = [0;0];

%% Transmitter side %%

for i = 1:nb_channels
    
    if bit_alloc(i) == 4
        data = bit_In(1:2);
        bit_In(1:2) = [];
    elseif bit_alloc(i) == 8
        data = bit_In(1:3);
        bit_In(1:3) = [];
    elseif bit_alloc(i) == 16
        data = bit_In(1:4);
        bit_In(1:4) = [];
    end
    
    dataIn{i} = data;
    symboles_out{i} = modulationQAM(dataIn{i},bit_alloc,i);
    before_canal{i} = modulationDMT(symboles_out{i});
        
    % Concatenate the 512 values
    data_concat(j) = before_canal{i}(1);
    data_concat(j+1) = before_canal{i}(2);
    j = j+2;
end

%% Add the prefix cyclic %%
length_prefixe = 32;
length_data = length(data_concat);
for l = 1:length_prefixe
     data_concat(length_data+l) = data_concat(l);  
end

end

