N_bruit = 0.001;

%% Channel estimation %%
display('Estimation du canal et allocation');
[estimated_channel_tot, estimated_channel, estimated_noise] = estimation_test(N_bruit);
script_allocation;


%% Construction of data %%
nb_superframe    = 2;
nb_frames_in_one_superframe = 68;
FEC_size         = 32;
CRC_size         = 8;
Nt               = sum(log2(alloc)); % size of a frame
nb_bits_canal0   = log2(alloc(1));   %number of bits allocated to the first channel
sframe_data_size = nb_frames_in_one_superframe * (Nt - FEC_size - nb_bits_canal0) - CRC_size;
data_size        = nb_superframe * sframe_data_size;
input_data       = random_digital_signal(data_size, 0.5);
output_data      = [];
encoded_sframe   = [];

tot_channel = 256;    %total number of channels
length_prefixe = 32;  %length prefixe

%% Transmission %%

remaining_data = input_data;

while ~isequal(remaining_data, [])
    %% Creation of a superframe %%
    [superframe_i, remaining_data] = superframe(remaining_data, alloc);
    
    %% For each frame taken appart %%
    for frame_nb = 1 : nb_frames_in_one_superframe
        
        display('Numéro de frame en cours de traitement = ');
        display(frame_nb);
        frame_i = superframe_i((frame_nb-1)*Nt + 1 : frame_nb*Nt);
        
        

        %% Modulation %%
        [~, dmt_frame, qam_frame] = modulation(frame_i, alloc);
        
        %% Send through channel %%alloscript_allocation; %here is Lelio's test, replace by : Felix's estimation then Lelio's water filling

        [channel_frame, rep_imp, rep_freq_tot] = channel(dmt_frame);
        % with noise AWGN
        noise_frame = SignalAWGN(channel_frame, N_bruit);
        
        %% Plot
        
%         figure(1)
%         subplot(511);
%         plot(dmt_frame(33:544));
%         
%         subplot(512);
%         plot(abs(fft(rep_imp)));
%         
%         subplot(513);
%         Y1 = channel_frame;
%         plot(abs(Y1));
%         
%         subplot(514);
%         %     Y2 = fft(channel_frame(33:544)) .* fft(dmt_frame(33:544));
%         Y2 = fft(channel_frame) .* fft(dmt_frame(33:544));
%         plot(abs(Y2));
%         
%         subplot(515);
%         difference = abs(Y1 - Y2);
%         plot(difference);
%         
 
        %% Demodulation + Egalisation %%
        [bitsOut, demodulation_dmt_frame] = demodulation_signal(noise_frame, alloc, estimated_channel_tot); 


        
        %% Reconstruction of the superframe %%
        encoded_sframe = [encoded_sframe bitsOut];
    end
    
    %% Get data from superframe %%
    [desuperframe_i, err, remain2] = desuperframe(encoded_sframe, alloc);  % replace superframe_i by csframe (the superframe we get from channel)
    CRC_error_in_a_superframe = err
    encoded_sframe = [];
    
    %% Recontruction of data %%
    output_data = [output_data desuperframe_i];
end

%% Test : do we get the same data ? %%
perfect_transmission_1____At_least_one_mistake_0 = isequal(input_data, output_data)

%% Rate %%
rate = (nb_frames_in_one_superframe * Nt)/0.017
useful_rate = sframe_data_size/0.017
bit_error = sum(xor(input_data, output_data))
bit_error_rate = bit_error/useful_rate


