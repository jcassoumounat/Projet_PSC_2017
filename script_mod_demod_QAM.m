nombre_bits = 960;
dataIn = randi([0 1],nombre_bits,3);
symboles_QAM = modulationQAM(dataIn,nombre_bits,3,[4;4;4]);
dataOut = demodulationQAM(symboles_QAM,floor(nombre_bits/2),3,[4;4;4]);