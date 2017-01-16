function [digital_signal]=random_digital_signal(n, p)
    digital_signal = zeros(1, n);
    for i=1:n
        digital_signal(i) = random('bino', 1, p);
    end
end