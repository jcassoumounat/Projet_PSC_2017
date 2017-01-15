% function [signal_convolved] = egalisation(h, signal_in, N0)
% %% Description %%
% % This functions applies an equalization by convolving the input signal
% % with a Wiener's filter.
% %%
% 
%     size(h)
%     size(signal_in)
% 
%     %% Parameters %%
%     L_h = length(h);
%     L_x = length(signal_in);
%     
%     %% Operations in frequencies domain %%
%     H       = fft(h);
%     H_conj  = conj(H(1: L_h));
%     size(H_conj)
%     
%     %% Compute the PSD of the signal %%
%     PSD_X = periodogram(signal_in);
%     PSD_X = PSD_X';
%     size(PSD_X)
%     
%     %% Compute the PSD of the Gaussian Noise %%
%     PSD_N = N0^2 * ones(size(PSD_X));
%     
%  
%     %% Build the Wiener filter, first in frequencies then in time
%     G = (H_conj .* PSD_X) / (abs(H(1: L_h/2 + 1)).^2 .* PSD_X + PSD_N);
%     G_conj = flipr(conj(G));
%     G_tot = [G, G_conj];
%     g = ifft(G_tot);
%     L_g = length(g);
%     
%     %% Operations in time domain %%
%     signal_convolved = conv(abs(g), signal_in, 'full');
%     signal_convolved = signal_convolved(L_g : L_g + L_x - 1); %match signal_in size (512 + 32);
% end

function [signal_convolved] = egalisation(H, signal_in)

    L_H = length(H);
    L_X = length(signal_in);
    
   
%     H_tot = [H, fliplr(conj(H))];
%     H_tot_conj = conj(H_tot)./(abs(H_tot).^2);
%     H_ifft = ifft(H_tot_conj,'symmetric');
%     signal_convolved = filter(H_ifft, 1, signal_in);


L_cyclic = 32;
L_h = length(H);
L_x = length(signal_in);
H_inv = conj(H)./(abs(H).^2);
H_inv_sym = fliplr(conj(H_inv));
H_inv_tot = [0, H_inv(1:255), 0 , H_inv_sym(2:256)];
H_ifft = ifft(H_inv_tot);


% signal_convolved = conv(signal_in, H_ifft, 'same')
signal_convolved = conv(H_ifft, signal_in, 'full');
signal_convolved = signal_convolved(L_h*2  : L_h*2 + L_x - 1);
% signal_convolved = [0 , signal_convolved(1 : 255), signal_convolved(257 : 544)];
% signal_convolved(L_x-L_cyclic:L_x) = signal_convolved(1:L_cyclic+1); 
plot(signal_convolved);

end

