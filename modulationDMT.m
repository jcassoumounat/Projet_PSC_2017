function [suite_symboles_out] = modulationDMT(tableau_complexe_N_dim, nb_bits_to_process, nombre_sous_canaux)

    for i=1:nombre_sous_canaux
        
        %% Transformer le tableau à N dimensions en un vecteur %%
        for j=1:nb_bits_to_process
            data(j) = tableau_complexe_N_dim(j,i);
        end
        data_ifft = ifft(data);
        
        %% Ajouter complexe conjugué %%
        
        %% Regroupement des signaux modulés dans un tableau global %%
        for f=1:length(data_ifft)
            suite_symboles_out(f,i) = data_ifft(f);        
        end      
        
    end
    
end

