%% Script Modulation/Demodulation DMT %%

nb_bits = 960;
nb_channels = 3;
mod_util = 4;
dataIn = randi([0 1],nb_bits,nb_channels);

%%%% Bit Allocation %%%%
bit_alloc = bit_allocation();

symboles_out = modulationQAM(dataIn,nb_bits,nb_channels,[mod_util;mod_util;mod_util]);
symboles_out_ifft = modulationDMT(symboles_out,nb_bits/log2(mod_util),nb_channels);

%%%% Transmission dans le canal %%%%

after_canal = demodulationDMT(symboles_out_ifft,nb_bits/log2(mod_util),nb_channels);
dataOut = demodulationQAM(after_canal,nb_bits/log2(mod_util),nb_channels,[mod_util;mod_util;mod_util]);