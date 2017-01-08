%% Test Frame Building %%

% input_fast_data         = random_digital_signal(3, 0.5)
% input_interleaved_data  = random_digital_signal(2, 0.5)
% 
% f = frame(input_fast_data, input_interleaved_data);
% 
% [ofd, oid] = deframe(f, 3, 2);
% 
% sframe = random_digital_signal(48*68, 0.5);
% crc_sframe = crcenc(sframe');
% deccrc_sframe = crcdec(crc_sframe);

sframe_duration = 0.017
rate = 4000 * 69 / 68 %bauds
sframe_size = sframe_duration * rate

frame_duration = 0.00025
rate = 4000 * 69 / 68 %bauds
frame_size = frame_duration * rate