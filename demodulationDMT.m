function [suite_symboles_out] = demodulationDMT(signal_recu)

% signal_recu = signal reçu après passage dans le canal
j = 1;

signal_comp = zeros(length(signal_recu)/2,1);

%% Transformation en signal complexe %%
for l = 1:2:length(signal_recu)
    signal_comp(j) = signal_recu(l) +  signal_recu(l+1)*1i;
    j = j+1; 
end

%% FFT %%
suite_symboles_out = fft(signal_comp);
    
end
