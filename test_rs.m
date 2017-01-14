%% Reed Solomon Test Script %%

data        = random_digital_signal(704, 0.5) ;
rs_data     = encoderRS(data)   ;            
dec_rs_data = decoderRS(rs_data) ;
res = isequal(data, dec_rs_data)