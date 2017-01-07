function [frame_vector] = frame(data_vector, FEC_size)
%Create a frame of the ADSL with fast data buffer and interleaved data
%buffer
%   frame_vector : a vector compsed of bits. It is what is modulated and
%   sent
%   [...fast_data(reed_salomon) FEC...data_interleaved]
%
%   data_vector : data we put in the frame

data_size = size(data_vector, 2);

if data_size < FEC_size*2+2
    WARNING = 'frames will be too small, the rate must be improved'
else

    fast_data_size = round(data_size/2) - FEC_size; % /2 -> arbitrary decision
    interlaved_data_size = data_size - (fast_data_size + FEC_size);

    future_data=[];
    future_fast_data=[];
    future_interleaved_data=[];

    %future data (fast and interleaved data)
    future_data = reedSolomon_temp(data_vector);
    
    %fast data
    for i = 1 : fast_data_size
        fast_data(i) = future_data(i);
        %future_fast_data(i)=data_vector(i);
    end
    %fast_data = reedSolomon_temp(future_fast_data);

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


