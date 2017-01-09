function [ ht, wt ] = estimation_test()
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
%%
    tot_channel = 256;
    partial_estimated_response = zeros(tot_channel, tot_frames);
    estimated_response = zeros(tot_channel);
    tot_frames = 30;  % total number of initialisation frames
    for frame_number = 1 : 30
    
    %Creating the initialisation frame
        init_frame = zeros(1,512);
        for i=1 : 9
            init_frame(1,i) = 1;
        end
        for i=10 : 512
            init_frame(1,i) = init_frame(1,i-4) + init_frame(1,i-9);
            if (init_frame(1,i) >= 2)
                init_frame(1,i) = 0;
            end
        end

%%
%processing the frame through the transmission chaine

%processing the frame through the QAM modulator
        qam_frame = modulationQAM(init_frame,?? , ??)

%processing the frame through the DMT modulator
        dmt_frame = modulationDMT(qam_frame);

%processing the frame through the channel
        channel_frame = channel(DMT_frame);

%processing the frame through the dmt demodulator
        demodulationdmt_frame = demodulationDMT(channel_frame, ??, ??);
 
 %%
 %estimation of the coefficients of the channel's impulsionnal response
        for channel_number = 1 : 256
            partial_estimated_response(channel_number,frame_number) = partial_estimated_response(channel_number, frame_number) + (demodulationdmt_frame(channel_number) ./ modulation_frame(channel_number)) ./ tot_frame;
        end
    end
    for channel_number = 1 : 256
        for frame_numbre = 1 : 30
            estimated_response(channel_number) = estimated_response(channel_number) + partial_estimated_response(channel_number,frame_number)
        end
    end
    
    
    
 %%
 
    tot_channel = 256;
    partial_estimated_noise = zeros(tot_channel, tot_frames);
    estimated_noise = zeros(tot_channel);
    tot_frames = 30;  % total number of initialisation frames
    for frame_number = 1 : 30
    
    %Creating the initialisation frame
        init_frame = zeros(1,512);
        for i=1 : 9
            init_frame(1,i) = 1;
        end
        for i=10 : 512
            init_frame(1,i) = init_frame(1,i-4) + init_frame(1,i-9);
            if (init_frame(1,i) >= 2)
                init_frame(1,i) = 0;
            end
        end

%%
%processing the frame through the transmission chaine

%processing the frame through the QAM modulator
        qam_frame = modulationQAM(init_frame,?? , ??)

%processing the frame through the DMT modulator
        dmt_frame = modulationDMT(qam_frame);

%processing the frame through the channel
        channel_frame = channel(DMT_frame);

%processing the frame through the dmt demodulator
        demodulationdmt_frame = demodulationDMT(channel_frame, ??, ??);
 
 %%
 %estimation of the coefficients of the noise response
        for channel_number = 1 : 256
            partial_estimated_noise(channel_number,frame_number) = partial_estimated_noise(channel_number, frame_number) + (demodulationdmt_frame(channel_number) - estimated_response(channel_number).*modulation_frame(channel_number)) ./tot_frame; 
        end
    end
    for channel_number = 1 : 256
        for frame_numbre = 1 : 30
            estimated_noise(channel_number) = estimated_response(channel_number) + partial_estimated_response(channel_number,frame_number)
        end
    end
    
    
    
    

            
            



end

