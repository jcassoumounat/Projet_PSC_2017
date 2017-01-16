%% case good data %%

data = random_digital_signal(40001, 0.5);
cdata = crcenc(data);
[dcdata1 err1] = crcdec(cdata);
err_must_be_nil = err1

%% case bad data %%
data2 = random_digital_signal(40001, 0.5);
cdata2 = crcenc(data2);
crc = cdata(9 : length(cdata2));
wrong_data = [crc data]; % we take the data generated in the previous test
[dcdata2 err2] = crcdec(wrong_data);
err_must_be_one = err2