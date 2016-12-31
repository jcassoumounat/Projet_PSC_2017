nombre_bits = 640;
dataIn = randi([0 1],nombre_bits,3);
symboles_QAM = modulationQAM(dataIn,3,nombre_bits,[4;4;4]);
dataOut = demodulationQAM(symboles_QAM,3,floor(nombre_bits/2),[4;4;4]);