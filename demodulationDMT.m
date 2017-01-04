function [suite_symboles_out] = demodulationDMT(signal_recu)

% signal_recu = signal reçu après passage dans le canal
   
%% Suppression complexe conjugué + préfixe cyclique %%
%signal_recu=signal_recu(v+1:2*N+v);
 
%% FFT %%
suite_symboles_out = fft(signal_recu);
    
%% Egalisation %%
%signal_fft = x./h_eval_mod; % égalisation
    

end
