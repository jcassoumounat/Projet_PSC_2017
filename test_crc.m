data = random_digital_signal(46367, 0.5)
crc  = crcenc(data')
dec  = crcdec(crc)'