test_vect = test_bit_vector(32);
[sent_vector, fast_data_size] = frame(test_vect, 8)
decoded_vector = deframe(sent_vector, 8)