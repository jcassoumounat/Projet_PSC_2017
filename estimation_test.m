function [ estimated_channel, estimated_noise ] = estimation_test()
%UNTITLED6 Summary of this function goes here
%   ouput values:
    %estimated_channel: represents the average estimated response of 30 responses of the channel to the initialisation frame
    %estimated noise : represents the average estimated noise of 30 responses of the channel to the initialisation frame
    
%%
    tot_frames = 30;                                                %total number of initialisation frames
    tot_channel = 256;                                              %total number of channels
    length_prefixe = 32;                                            %length prefixe
    
    partial_estimated_response = zeros(tot_channel, tot_frames);
    estimated_response = zeros(1, tot_channel);
    partial_estimated_noise = zeros(tot_channel, tot_frames);
    estimated_noise = zeros(1, tot_channel);
    
    allocation_qam= 4*ones(1,tot_channel);
    qam_frame = zeros(1,tot_channel);
    dmt_frame = zeros(1,tot_channel * 2 + length_prefixe);
    channel_frame = zeros (1,tot_channel *2 + length_prefixe); 
    without_prefixe = zeros(1,256*2);
    length_data = 256*2; 
    
    Te = 1/1104000;                  %sample time
    tableau_temps = [1:1:544];       %Size of the number of discret samples
    tableau_temps2 = [0:1:255]
    
    
%% Creating the initialisation frame
    init_frame = zeros(1,512);
    init_frame(1) = 1;
%     init_frame = zeros(1,512);
%     for i= 1 : 9
%         init_frame(i) = 1;
%     end
%     for i= 10 : 512
%         init_frame(i) = init_frame(i-4) + init_frame(i-9);
%         if (init_frame(i) >= 2)
%             init_frame(i) = 0;
%         end
%     end
    
%% %processing frame in qam and dmt
    [~ , dmt_frame, qam_frame] = modulation(init_frame, allocation_qam);

%% processing the frame through the channel
    [channel_frame, rep_imp] = channel(dmt_frame);
%   figure; plot(tableau_temps*Te, channel_frame);
%   title('signal after the channel');
    

%% CrossTalk
    %noise_frame = SignalCrossTalk(channel_frame);
    %figure; plot(diaphonie);
%     title('signal with noise');
%% SignalDamaged
    %noise_frame = (channel_frame);
    %figure; plot(degat);
    
   
%% processing the frame through the dmt demodulator
%     for m = 1 : tot_channel
%        demodulation_dmt_frame = demodulationDMT(without_prefixe);
%     end
        
 %% estimation of the coefficients of the channel's impulsionnal response
 
     for frame_number = 1 : tot_frames
    %% AWGN
        noise_frame = zeros(1, 544);
        noise_frame = SignalAWGN(channel_frame, 0.001);
        %figure; plot(tableau_temps*Te,noise_frame);
        %title('signal with noise');
        
    %% Demodulation

        [demodulation_qam_frame, demodulation_dmt_frame] = demodulation(channel_frame, allocation_qam);
        
        
        for channel_number = 1 : tot_channel
            real_demod = real(demodulation_dmt_frame(channel_number));
            imag_demod = imag(demodulation_dmt_frame(channel_number));
            real_qam = real(qam_frame(channel_number));
            imag_qam = imag(qam_frame(channel_number));
            partial_estimated_response(channel_number,frame_number) = partial_estimated_response(channel_number, frame_number) + ((real_demod*real_qam + imag_demod*imag_qam + complex(0 , imag_demod*real_qam - real_demod*imag_qam)) ./ (real_qam*real_qam + imag_qam*imag_qam)) ./ tot_frames;
        end
    end
    for channel_number = 1 : tot_channel
        for frame_number = 1 : tot_frames
            estimated_response(channel_number) = estimated_response(channel_number) + partial_estimated_response(channel_number,frame_number);
        end
    end
 %% estimation of the coefficients of the channel's impulsionnal response
    for frame_number = 1 : tot_frames
%% AWGN
        noise_frame = zeros(1, 544);
        noise_frame = SignalAWGN(channel_frame, 0.0001);
        %figure; plot(tableau_temps*Te,noise_frame);
        
        
        for channel_number = 1 : tot_channel
            partial_estimated_noise(channel_number,frame_number) = partial_estimated_noise(channel_number, frame_number) + (demodulation_dmt_frame(channel_number) - estimated_response(channel_number).*qam_frame(channel_number)) ./tot_frames; 
        end
    end
    for channel_number = 1 : tot_channel
        for frame_numbre = 1 : tot_frames
            estimated_noise(channel_number) = estimated_noise(channel_number) + partial_estimated_noise(channel_number,frame_number);
        end
    end
    
    
    estimated_response
%     figure; plot(tableau_temps2*Te, estimated_response);
    estimated_noise
%     figure; plot(tableau_temps2*Te, estimated_noise);
    
end

