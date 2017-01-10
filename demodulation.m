function [dataOut] = demodulation(before_canal, bit_alloc)

nb_channels = 256;
after_canal = cell(1,256); 
dataOut = cell(1,256);
after_remove_prefix = zeros(256,1);
indice1 = 1;
indice2 = 2;
length_prefixe = 32;


%% Remove the prefix cyclic %%  
length_data = length(before_canal) - length_prefixe;

for j = 1:length_data
     after_remove_prefix(j) = before_canal(j);  
end

%% Dispatch the 256 canals %%

for l = 1:length(after_remove_prefix)/2
    after_canal{l} = after_remove_prefix(indice1:indice2);
    indice1 = indice1+2;
    indice2 = indice2+2;
end

%% Demodulation %%

for i = 1:nb_channels
    after_canal{i} = demodulationDMT(after_canal{i});
    dataOut{i} = demodulationQAM(after_canal{i},bit_alloc,i);
    
end
end

