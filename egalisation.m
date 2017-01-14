function [signal_convolved] = egalisation(h, signal_in)
    H = fft(h);
    H_inv = conj(H)./(abs(H).^2);
%     H_inv = ones(size(H)) ./ H;
%     signal_convolved = filter(ifft(H_inv), 1, fliplr(signal_in));
    signal_convolved = conv(abs(ifft(H_inv)), signal_in, 'full');
    signal_convolved = signal_convolved(512:1055); %match signal_in size (512 + 32);
end

% function [signal_convolved] = egalisation(h_freq, signal_i_freq)
%     h_inv = zeros(1, length(h_freq));
%     for i = 1:length(h_freq)
% %         h_inv(i) = conj(h_freq(i))/(real(h_freq(i))^2 + imag(h_freq(i))^2);
%         h_inv(i) = 1 / h_freq(i);
%     end
%     signal_convolved = ifft(signal_i_freq ./ h_inv) + conj(ifft(signal_i_freq ./ h_inv));
% end

