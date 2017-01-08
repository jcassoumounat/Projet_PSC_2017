%% ADSL Project                                                         %%

%% 4TC - 1 gr. 3                                                        %%

%% INSA Lyon                                                            %%

%% Developpers                                                          %%
% Félix Bosche
% Jean Cassou-Mounat 
% Lélio Chetot
% Martin Delbecque
% Hugo Dupré
% Jingmin Guan
% Fengyu Yang

%% Random generation of a 1024-length binary signal %%
digital_signal = random_digital_signal(1024, 0.5);

%% Framing %%
sframe = superframe(digital_signal, 164000);

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
    
    data        = randi([0 1], nb_bits, 1);
    dataIn{i}   = data;
    symboles_out{i} = modulationQAM(dataIn{i},bit_alloc,i);
    before_canal{i} = modulationDMT(symboles_out{i});
end
    
%% Transmission into the channel %%

%% Receiver side %%
for i = 1:nb_channels
    if bit_alloc(i) == 4
        nb_bits = 24;
    elseif bit_alloc(i) == 8
        nb_bits = 48;
    elseif bit_alloc(i) == 16
        nb_bits = 72;
    end
    
    after_canal{i}  = demodulationDMT(before_canal{i});
    dataOut{i}      = demodulationQAM(after_canal{i},bit_alloc,i);
end

%% De-Framing
sframe_out = 

