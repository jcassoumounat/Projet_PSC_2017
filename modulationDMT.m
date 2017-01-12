function [data_dmt] = modulationDMT(data_qam)

%% Concernant les variables %%
% data_qam : symboles QAM en colonne

data_dmt = ifft(data_qam);

%% Ajout complexe conjugué + préfixe cyclique %%


end

