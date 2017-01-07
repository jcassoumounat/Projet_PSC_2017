function [frame_vector, fast_data_size] = frame(data_vector, FEC_size)
%Create a frame of the ADSL with fast data buffer and interleaved data
%buffer
%   frame_vector : a vector compsed of bits. It is what is modulated and
%   sent           [...fast_data(reed_salomon) FEC...data_interleaved]
%   fast_data_size : size of fast data
%
%   data_vector : data we put in the frame
%   FEC_size : size of non data bits in a frame

data_size = size(data_vector, 2);

if data_size < FEC_size*2+2
    WARNING = 'frames will be too small, the rate must be improved'
else

    fast_data_size = round(data_size/2) - FEC_size; % /2 -> arbitrary decision

    %future data (fast and interleaved data)
    future_data = reedSolomon_temp(data_vector);
    
    %fast data
    for i = 1 : fast_data_size
        fast_data(i) = future_data(i);
    end

    %FEC
    for i = 1 : FEC_size
        FEC(i) = 0; %!!!!!!!!!!!!!!!see with the real function of reed solomon code !!!!!!!!!!!!!!!
    end

    %interleaved data
    for i = fast_data_size+1 : data_size
        future_interleaved_data(i-fast_data_size) = future_data(i);
    end
    interleaved_data = interleaver(future_interleaved_data, 6); %6 : period of interleaving
    
    %concatenation
    frame_vector=[fast_data FEC interleaved_data];
end


