function [suite_symboles_out] = demodulationDMT(signal_recu,nb_symbs_to_process,nombre_canaux)

% signal_recu = signal reçu après passage dans le canal
% h_eval_mod = module de la réponse impulsionnelle du canal, identifiée
% nombre_canaux = nombre de canaux utilisés
% prefixe_cyclique = longueur du CP
% tab = vecteur table allocation des bits

for i=1:nombre_canaux
    %% Transformer le tableau à N dimensions en un vecteur %%
    for j=1:nb_symbs_to_process
        dataDemod(j) = signal_recu(j,i);
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%% Suppression du CP         %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %signal_recu=signal_recu(v+1:2*N+v);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % FFT et égalisation du signal %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    signal_before_egalisation = fft(dataDemod);
    
    %signal_fft = x./h_eval_mod; % égalisation
    
    
    %% Regroupement des signaux modulés dans un tableau global %%
    
    for f=1:length(signal_before_egalisation)
        suite_symboles_out(f,i) = signal_before_egalisation(f);
    end
end
end
