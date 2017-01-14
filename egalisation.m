function [signal_convolved] = egalisation(h, signal_in)
    L_h = length(h);
    L_x = length(signal_in);
    H = fft(h);
    H_inv = conj(H)./(abs(H).^2);
%     H_inv = ones(size(H)) ./ H;
%     signal_convolved = filter(ifft(H_inv), 1, fliplr(signal_in));
    signal_convolved = conv(abs(ifft(H_inv)), signal_in, 'full');
    signal_convolved = signal_convolved(L_h : L_h + L_x - 1); %match signal_in size (512 + 32);
end