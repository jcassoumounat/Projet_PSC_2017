% Analog to Digital Converter
function [digital_signal]=adc(analog_signal, thresh, )
    digital_signal = zeros(size(analog_signal));    %initialisation of the digital signal
    for i = 1 : length(analog_signal)
        %When the analog signal is greater than the thresh, we consider
        %that the corresponding bit will be a 1 else it will be a 0.
        if(analog_signal(i) > thresh)
            digital_signal(i) = 1;
        else
            digital_signal(i) = 0;
        end
    end
    
end