%% Reed Solomon Test Script %%

data        = random_digital_signal(2, 0.5)
rs_data     = encoderRS(data)
dec_rs_data = decoderRS(rs_data, 2)