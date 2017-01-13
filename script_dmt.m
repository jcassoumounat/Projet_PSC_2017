tab = [0;1+i;2+i;3+i];
tab;

tab_conj = flipud(tab);
tab_conj = [tab;0;tab_conj];
tab_conj = tab_conj(1:(length(tab_conj)-1));

tab_ifft = ifft(tab_conj)

%%% Transmission %%%

fft(tab_ifft)