%% Channel estimation %%
script_allocation; %here is Lelio's test, replace by : Felix's estimation then Lelio's water filling

%% Construction of data %%
nb_superframe = 2;
nb_frames_in_one_superframe = 68;
FEC_size      = 32;
CRC_size      = 8;
Nt            = sum(log2(alloc));                                               % size of a frame
data_size     = nb_superframe *(68 * (Nt - FEC_size) - CRC_size);
input_data    = random_digital_signal(data_size, 0.5);            % creates exactly 2 superframes

remaining_data = input_data;
while ~isequal(remaining_data, [])
    %% Creation of a superframe %%
    [superframe_i, remaining_data] = superframe(remaining_data, alloc);
    
    %% For each frame taken appart %%
    for frame_nb = 1 : nb_frames_in_one_superframe
        
        frame_i = superframe_i((frame_nb-1)*Nt + 1 : frame_nb*Nt);
        
        %% DMT Modulation %%

        %% Send through channel %%

        %% Egalization %%
        
        %% Demodulation %%
        
        %% Reconstruction of the superframe %%
        
    end
    
    %% Get data from superframe %%
    [desuperframe_i, err, remain2] = desuperframe(superframe_i, alloc);  % replace superframe_i by the superframe we get from channel
    CRC_error_in_a_superframe = err
    
    %% Recontruction of data %%
    output_data = [output_data desuperframe_i];
end

%% Test : do we get the same data ? %%
perfect_transmission_0____At_least_one_mistake_1 = isequal(input_data, output_data)


