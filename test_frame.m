%% Test Frame Building %%

input_data = random_digital_signal(48, 0.5)

f = frame(input_data);

output_data = deframe(f)

% sframe = random_digital_signal(48*68, 0.5)
% crc_sframe = crcenc(sframe')
% deccrc_sframe = crcdec(crc_sframe)
% sframe - 

% sframe_duration = 0.017
% rate = 4000 * 69 / 68 %bauds
% sframe_size = sframe_duration * rate
% 
% frame_duration = 0.00025
% rate = 4000 * 69 / 68 %bauds
% frame_size = frame_duration * rate