% ADSL project

warning('off','comm:obsolete:qaskdeco')

%%%%%%%%%%%%%%%%%%%%
%  Initialisation  %
%%%%%%%%%%%%%%%%%%%%

nombre_canaux=25; % Nombre de canaux pour la simulation
prefixe_cyclique=4; % Taille du préfixe cyclique
h=[1]; % réponse impulsionnelle du canal

%%%%%%%%%%%%%%%%%%%%
%  Fonctionnement  %
%%%%%%%%%%%%%%%%%%%%
 
% Analyse de la ligne et tab
% [h_iden,h_iden_mod,bruit_iden_carre,SNR] = eval_ligne(nombre_canaux,h,prefixe_cyclique,1); 

% Analyse de la ligne: identification de la fonction de transfert de la ligne (1 coeft par canal), 
% la puissance du bruit (1 valeur par canal), le SNR sur chaque canal
% tab = repartition_bits(nombre_canaux,h_iden_carre,bruit_iden_carre); % création de la TAB


% Création de la suite de symboles à transmettre
% suite_bits_in = generation_bits(sum(tab),0.5); % création de la suite des bits à transmettre
% suite_symb = generation_symb(suite_bits_in,tab); 

% Création des symboles complexes à transmettre sur chaque porteuse

%% Modulation/transmission/démodulation %%

% Modulation DMT (IFFT, mise en série, ajout du CP)
signal_module=modulationDMT(suite_symboles_in,nombre_canaux,prefixe_cyclique); 

% Transmission sur le canal
signal_recu=canal(signal_module,h); 

% Démodulation DMT (suppression du CP, FFT, égalisation,mise en série)
[suite_bits_out,signal_demodule]=demodulationDMT(signal_recu,h_eval_mod,nombre_canaux,prefixe_cyclique,tab); 

 
%% Analyse des données reçues %%
suite_bits_out % Suite de bits reçus
erreurs=sum(xor(suite_bits_in,suite_bits_out)); % nombre d'erreur


