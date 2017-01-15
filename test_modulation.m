%% Bit Allocation %%
bit_alloc = bit_allocation();
nb_bits_a_transmettre = sum(log2(bit_alloc));
bit_In = randi([0 1], nb_bits_a_transmettre, 1);

[dataIn, data_concat, symboles_out] = modulation(bit_In, bit_alloc);

%%%% Transmission into the channel %%%%

[dataOut, after_canal] = demodulation(data_concat, bit_alloc);