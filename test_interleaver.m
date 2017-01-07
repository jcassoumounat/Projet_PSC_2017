vector_size=128;

period = 12;

test_vector_bit = test_bit_vector(vector_size)

interleaved_vector = interleaver(test_vector_bit, period)

size(interleaved_vector);

deinterleaver_vector = deinterleaver(interleaved_vector, period)