%% Channel estimation %%
script_allocation; %here is Lelio's test, replace by : Felix's estimation then Lelio's water filling

%% Construction of data %%
nb_superframe = 2;
nb_frames_in_one_superframe = 68;
FEC_size      = 32;
CRC_size      = 8;
Nt            = sum(log2(alloc)); % size of a frame
nb_bits_canal0 = log2(alloc(1));
data_size     = nb_superframe *(68 * (Nt - FEC_size - nb_bits_canal0) - CRC_size);
input_data    = random_digital_signal(data_size, 0.5);            % creates exactly 2 superframes
output_data   = [];
csframe       = [];

tot_channel = 256;                                              %total number of channels
length_prefixe = 32;                                            %length prefixe

allocation_qam = 4*ones(1,tot_channel);

Te = 1/1104000;                  %sample time
tableau_temps = (1:1:sum(allocation_qam)/2+length_prefixe);       %Size of the number of discret samples

%% ADSL %%

remaining_data = input_data;
while ~isequal(remaining_data, [])
    %% Creation of a superframe %%
    [superframe_i, remaining_data] = superframe(remaining_data, alloc);
    
    %% For each frame taken appart %%
    for frame_nb = 1 : nb_frames_in_one_superframe
        
        frame_i = superframe_i((frame_nb-1)*Nt + 1 : frame_nb*Nt);
        
        %% Modulation %%
         [~, dmt_frame, qam_frame] = modulation(frame_i, alloc);
        
        %% Send through channel %%
        
        [channel_frame, rep_imp,rep_freq_tot] = channel(dmt_frame);
        %% Egalization %%
        
        with_prefixe = egalisation(rep_freq_tot, channel_frame);
        %% Demodulation %%
        
        [bitsOut, demodulation_dmt_frame] = demodulation(with_prefixe, alloc);
        %% Reconstruction of the superframe %%
        csframe = [ csframe bitsOut];
    end
    
    %% Get data from superframe %%
    [desuperframe_i, err, remain2] = desuperframe(csframe, alloc);  % replace superframe_i by the superframe we get from channel
    CRC_error_in_a_superframe = err
    csframe = [];
    
    %% Recontruction of data %%
    output_data = [output_data desuperframe_i];
end

%% Test : do we get the same data ? %%
perfect_transmission_1____At_least_one_mistake_0 = isequal(input_data, output_data)


