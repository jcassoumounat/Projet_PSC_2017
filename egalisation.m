function [signal_convolved] = egalisation(h_freq, signal_in)

h_inv = zeros(1, length(h_freq));
for i = 1:length(h_freq)
    h_inv(i) = conj(h_freq(i))/(real(h_freq(i))^2+imag(h_freq(i))^2);
end
signal_convolved = filter(h_inv, 1, signal_in);

end

