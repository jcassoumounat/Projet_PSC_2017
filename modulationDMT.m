function [data_dmt] = modulationDMT(data_qam)

% Return the symboles DMT for every sub-canal

%% Parameters %
% - Inputs :
%   * data_qam : symbols received after the QAM modulation
%
% - Outputs :
%   * data_reel : symbols DMT real ([Real;Imaginary;Real;Imaginary...])

%% IFFT %%

%On ajoute les conjugués
data_qam = data_qam(1:255); %on supprime la valeur du 256ème canal
data_qam = data_qam';
data_dmt_conj = conj(data_qam);
data_dmt_conj_flip = flipud(data_dmt_conj);
data_conj = [0;data_qam; 0; data_dmt_conj_flip];
data_conj = data_conj';

data_dmt = ifft(data_conj);

end

