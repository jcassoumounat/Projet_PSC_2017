data = [1:10]
Ncols= 4;

interleaved_data = interleaver(data, Ncols)
% size(interleaved_data);

deinterleaver_vector = deinterleaver(interleaved_data, Ncols)