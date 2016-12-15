function signal_recu=canal(signal_module,h)

% La fonction canal permet de simuler un canal réel, intégrant du bruit et de la diaphonie.
% Tous les échantillons sortant du modulateur DMT traverseront
% ce canal pour finalement être envoyées au démodulateur.

% x_mod est le vecteur sorti du modulateur DMT.
% h est la réponse impulsionnelle en temps du canal.


signal_recu=signal_module; 