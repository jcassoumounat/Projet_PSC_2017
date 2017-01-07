data = test_bit_vector(1024);
rate = 164000;
[superframe_test, remain] = superframe(data, rate)
[frame0, frame1, frame34, frame35, superframe_decoded_test] = desuperframe(superframe_test)