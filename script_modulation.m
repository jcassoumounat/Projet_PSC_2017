dataIn = randi([0 1],960,3);
symboles_out = modulationQAM(dataIn,960,3,[4;16;4]);
symboles_out_ifft = modulationDMT(symboles_out, 480, 3);