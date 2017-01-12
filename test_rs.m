%% Reed Solomon Test Script %%

data        = random_digital_signal(8, 0.5) % 8
rs_data     = encoderRS(data)               % 24
dec_rs_data = decoderRS(rs_data)            % 8 ?