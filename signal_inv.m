function [signal_convolved] = signal_inv(h_freq, signal_in)

h_inv = zeros(1, length(h_freq));
for i = 1:length(h_freq)
    h_inv(i) = 1/h_freq(i);
end
signal_convolved = filter(h_inv, 1, signal_in);

end

