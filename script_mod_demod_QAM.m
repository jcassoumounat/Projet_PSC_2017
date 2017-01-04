nombre_bits = 9600;
dataIn = randi([0 1],nombre_bits,3);
symboles_QAM = modulationQAM(dataIn,nombre_bits,3,[32;32;32]);
dataOut = demodulationQAM(symboles_QAM,floor(nombre_bits/log2(32)),3,[32;32;32]);