function [deframe] = deframe(frame, FEC_size)
%Get data from an ADSL frame
%   deframe : a vector compsed of bits of decoded data
%
%   frame : frame of ADSL
%   data_vector_size : size of fast data we put in the frame
%   FC_size : size of non data bits

frame_size = size(frame, 2);
fast_data_size = round((frame_size-FEC_size)/2) - FEC_size;

%interleaved data
for i = fast_data_size+FEC_size+1 : frame_size
    interleaved_data(i-(fast_data_size+FEC_size)) = frame(i);
end
deinterleaved_data = deinterleaver(interleaved_data, 6); %6 : period of interleaving : MUST BE the same as in frame.m

%fast data
for i = 1 : fast_data_size
    fast_data(i) = frame(i);
end

%all reed solomon coded data
coded_data = [fast_data deinterleaved_data];

deframe = dereed_solomon_temp(coded_data);