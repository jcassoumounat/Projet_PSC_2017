function [suite_symboles_out] = demodulationQAM(signal_in, nb_bits_to_process , nombre_sous_canaux, type_QAM_bits_allocation)
    
    %% Concernant les variables %%
    % - nb_bits_to_process, un multiple de type_QAM_bits_allocation pour que reshape fonctionne
    % - type_QAM_bits_allocation : vecteur colonne contenant le type de QAM (water-filling)

    for i=1:nombre_sous_canaux
        %% Transformer le tableau à N dimensions en un vecteur %%
        for j=1:nb_bits_to_process
            dataCanal(j) = signal_in(j,i);
        end
        dataCanal = transpose(dataCanal);
        
        %% Demodulation %%
        nb_bits_symbole = log2(type_QAM_bits_allocation(i));
        signal_demod = qamdemod(dataCanal,type_QAM_bits_allocation(i)); 
        dataOutMatrix = de2bi(signal_demod,nb_bits_symbole);
        dataOut = dataOutMatrix(:);
        
        %% Regroupement des signaux modulés dans un tableau global %%
        for f=1:length(dataOut)
            suite_symboles_out(f,i) = dataOut(f);        
        end        
    end  
end
