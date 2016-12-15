function suite_bits=decodage_symboles(suite_symboles,M)

% La fonction decodage_symboles permet de décoder une suite de symboles pour
% obtenir la suite binaire associée.

% suite_symboles est la suite des symboles sous forme décimale.
% M est l'indice de modulation utilisé pour coder cette suite.


%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%

k=log2(M); % k est le nombre de bits par symbole (M=2^k)
longs=length(suite_symboles); % Nombre de symboles en entrée
longb=longs*k; % Nombre de bits en sortie 
string_bits=[]; % Initialisation de la 'string' qui contiendra la suite de bits 


%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Conversion des symboles %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:longs % On parcourt la suite de symboles
    b=dec2bin(suite_symboles(i),k); % Conversion des symboles en binaire
    string_bits=[string_bits b];
end

% Comme la fonction 'dec2bin' renvoie une structure de type 'string' on va
% transformer le résultat en vecteur numérique.
suite_bits=[]; % Initialisation du vecteur qui contiendra la suite de bits 
for j=1:length(string_bits)
    suite_bits(j)=str2num(string_bits(j)); % La fonction dec2bin renvoie une 'string' qu'on transforme en vecteur
end