% function [X_egal] = egalisation(H, x, N0)
% %% Description %%
% % This functions applies an equalization by convolving the input signal
% % with a Wiener's filter.
%   
%     %% Operations in frequencies domain %%
%     X       = fft(x);
%     H_conj  = conj(H);
%     
%     %% Compute the PSD of the signal %%
%     PSD_X = periodogram(X);
%     PSD_X = PSD_X';
%     
%     %% Compute the PSD of the Gaussian Noise %%
%     PSD_N = N0^2 * ones(size(PSD_X));
%  
%     %% Build the Wiener filter
%     G = (H_conj .* PSD_X) / (abs(H).^2 .* PSD_X + PSD_N);
%     X_egal = X .* G;
% end

function [X_egal] = egalisation(H, x)
%     X           = fft(x(L_cyclic + 1 : L_x)); 
    X = fft(x);
    X_egal      = X ./ H;
end







