% function [signal_convolved] = egalisation(h, signal_in)
%     L_h = length(h);
%     L_x = length(signal_in);
%     H = fft(h);
%     H_inv = conj(H)./(abs(H).^2);
% %     H_inv = ones(size(H)) ./ H;
% %     signal_convolved = filter(ifft(H_inv), 1, fliplr(signal_in));
%     signal_convolved = conv(abs(ifft(H_inv)), signal_in, 'full');
%     signal_convolved = signal_convolved(L_h : L_h + L_x - 1); %match signal_in size (512 + 32);
% end

function [signal_convolved] = egalisation(h, signal_in, N0)
%% Description %%
% This functions applies an equalization by convolving the input signal
% with a Wiener's filter.
%%
    %% Parameters %%
    L_h = length(h);
    L_x = length(signal_in);
    
    %% Operations in frequencies domain %%
    H       = fft(h);
    H_conj  = conj(H(1: L_h/2 + 1));
    
    %% Compute the PSD of the signal %%
    PSD_X = periodogram(signal_in);
    PSD_X = PSD_X';
    
    %% Compute the PSD of the Gaussian Noise %%
    PSD_N = N0^2 * ones(size(PSD_X));
    
 
    %% Build the Wiener filter, first in frequencies then in time
    G = (H_conj .* PSD_X) / (abs(H(1: L_h/2 + 1)).^2 .* PSD_X + PSD_N);
    g = ifft(G);
    L_g = length(g);
    
    %% Operations in time domain %%
    signal_convolved = conv(abs(g), signal_in, 'full');
    signal_convolved = signal_convolved(L_g : L_g + L_x - 1); %match signal_in size (512 + 32);
end