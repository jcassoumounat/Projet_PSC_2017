test_vector_bit = random_digital_signal(176, 0.5);

period = 3;

interleaved_vector   = interleaver(test_vector_bit, period);
length(interleaved_vector)
deinterleaver_vector = deinterleaver(interleaved_vector, period);
length(deinterleaver_vector)

res = isequal(test_vector_bit, deinterleaver_vector)