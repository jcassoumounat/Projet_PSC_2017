function [suite_symboles_out] = modulationQAM(tableau_bits_N_dim, nb_bits_to_process , nombre_sous_canaux, type_QAM_bits_allocation)
    
    %% Concernant les variables %%
    % - tableau_bits_N_dim : dataIn = randi([0 1],nb_bits_to_process,nombre_sous_canaux);
    % - nb_bits_to_process, un multiple de type_QAM_bits_allocation pour que reshape fonctionne
    % - type_QAM_bits_allocation : vecteur colonne contenant le type de QAM (water-filling)

    for i=1:nombre_sous_canaux
        %% Transformer le tableau à N dimensions en un vecteur %%
        for j=1:nb_bits_to_process
            dataIn(j) = tableau_bits_N_dim(j,i);
        end
        
        %% Transformation du tableau de bits en tableau de symboles %%
        nb_bits_symbole = log2(type_QAM_bits_allocation(i)); %nombre de bits par symboles
        dataInMatrix = reshape(dataIn,length(dataIn)/nb_bits_symbole,nb_bits_symbole);   
        dataSymbolsIn = bi2de(dataInMatrix);  
        
        %% Modulation %%
        suite_symboles = qammod(dataSymbolsIn, type_QAM_bits_allocation, 0); 
    
        %% Plot des modulations %%
        sPlotFig = scatterplot(suite_symboles,1,0,'g.');
        
        %% Regroupement des signaux modulés dans un tableau global %%
        for f=1:length(suite_symboles)
            suite_symboles_out(f,i) = suite_symboles(f);        
        end        
    end  
end
