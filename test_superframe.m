data = test_bit_vector(1024);
rate = 82000;
[superframe_test, remain] = superframe(data, rate)
[frame0, frame1, frame34, frame35, superframe] = desuperframe(superframe_test)