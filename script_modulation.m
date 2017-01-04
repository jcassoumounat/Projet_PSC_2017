%% Initialisation of parameters %%
nb_channels = 256;
dataIn = cell(1,256);
symboles_out = cell(1,256); 
symboles_out_ifft = cell(1,256); 
after_canal = cell(1,256); 
dataOut = cell(1,256); 

%% Bit Allocation %%
bit_alloc = bit_allocation();

%% Transmitter side %%
for i = 1:nb_channels
    if bit_alloc(i) == 4
        nb_bits = 24;
    elseif bit_alloc(i) == 8
        nb_bits = 48;
    elseif bit_alloc(i) == 16
        nb_bits = 72;
    end
    
    data = randi([0 1], nb_bits, 1);
    dataIn{i} = data;
    symboles_out{i} = modulationQAM(dataIn{i},bit_alloc,i);
    symboles_out_ifft{i} = modulationDMT(symboles_out{i});
end
    
%%%% Transmission into the channel %%%%

%% Receiver side %%

for i = 1:nb_channels
    if bit_alloc(i) == 4
        nb_bits = 24;
    elseif bit_alloc(i) == 8
        nb_bits = 48;
    elseif bit_alloc(i) == 16
        nb_bits = 72;
    end
    
    after_canal{i} = demodulationDMT(symboles_out_ifft{i});
    dataOut{i} = demodulationQAM(after_canal{i},bit_alloc,i);
end
