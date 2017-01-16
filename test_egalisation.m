function [] = main()
%%
    %estimated_channel: represents the average estimated response of 30 responses of the channel to the initialisation frame
    %estimated noise : represents the average estimated noise of 30 responses of the channel to the initialisation frame
%%
    close all;
    
    %% Parameters %%
    tot_channel     = 256;                  %total number of channels
    length_prefixe  = 32;                   %length prefixe
    Te = 1/1104000;                         %sample time
    
    %%
    allocation_qam  = 4*ones(1,tot_channel);
    tableau_temps = (1:1:sum(log2(allocation_qam))+length_prefixe); %Size of the number of discret samples

    %% Compute an estimation of the channel's impulsionnal response %%
    %[estimated_response, estimated_noise] = estimation_test();
    
    %% Build the frame to send for estimation
    frame = zeros(1, sum(log2(allocation_qam)));
    frame(50) = 1;
%     frame = random_digital_signal(sum(log2(allocation_qam)), 0.001);
    
    %% Processing frame in qam and dmt
    [~, dmt_frame, ~] = modulation(frame, allocation_qam);
    
    figure(3);
    clf();
    plot(abs(dmt_frame));
    title('Signal before equalization');
    
    %% Processing the frame through the channel
    [channel_frame, rep_imp] = channel(dmt_frame);
    
    %% Noise addition 
    %% AWGN
    noise_frame = SignalAWGN(channel_frame, 0.0001);
    
    figure(1)
    subplot(511);
%     plot(dmt_frame(33:544));
    plot(abs(fft(dmt_frame(33:544))));
    
    subplot(512);
    plot(abs(fft(rep_imp)));
    
    subplot(513);
%     Y1 = fft(channel_frame(33:544));
    Y1 = fft(channel_frame);
    plot(abs(Y1));
%     plot(noise_frame);
    
    subplot(514);
%     Y2 = fft(channel_frame(33:544)) .* fft(dmt_frame(33:544));
    Y2 = fft(channel_frame) .* fft(dmt_frame(33:544));
    plot(abs(Y2));
    
    subplot(515);
    difference = abs(Y1 - Y2);
    plot(difference);
    

        
%% CrossTalk
%     noise_frame = SignalCrossTalk(fft(rep_imp), channel_frame);
        
%% Equalization
    
%     egal_frame = egalisation(fft(rep_imp), channel_frame);
%    egal_frame = egalisation(fft(rep_imp), noise_frame);
    egal_frame = deconvwnr(noise_frame, rep_imp, 0.0001);
     
    figure(4);
    clf();
    plot(abs(egal_frame));
    title('Signal after equalization');

%% Demodulation
   [bitsOut, demodulation_dmt_frame] = demodulation(egal_frame, allocation_qam);
   
   frame-bitsOut
   

end

