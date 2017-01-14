function [] = main()
%%
    %estimated_channel: represents the average estimated response of 30 responses of the channel to the initialisation frame
    %estimated noise : represents the average estimated noise of 30 responses of the channel to the initialisation frame
%%
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
%     frame = zeros(1, sum(log2(allocation_qam)));
%     frame(50) = 1;
    frame = random_digital_signal(sum(log2(allocation_qam)), 0.001);
    
    %% Processing frame in qam and dmt
    [~, dmt_frame, ~] = modulation(frame, allocation_qam);
    
    figure(1); 
    clf();
    plot(tableau_temps*Te, abs(dmt_frame));
    title('Signal before the channel');
    
    %% Processing the frame through the channel
    [channel_frame, rep_imp] = channel(dmt_frame);
    
    figure(2);
    clf();
    plot(tableau_temps*Te, abs(channel_frame));
    title('Signal after the channel');

%% Noise addition 
%     %% AWGN
    noise_frame = SignalAWGN(channel_frame, 0.001);
        
    figure(4);
    clf();
    plot(tableau_temps*Te, noise_frame);
    title('Signal after the noise');
        
%% CrossTalk
%         noise_frame = SignalCrossTalk(fft(rep_imp), channel_frame);
%         figure;
%         plot(diaphonie);
%         title('signal with noise');
%% SignalDamaged
%         noise_frame = (channel_frame);
%         figure; plot(degat);
        
%% Equalization
    
    with_prefixe = egalisation(abs(rep_imp), noise_frame);
     
    figure(3);
    clf();
    plot(tableau_temps*Te, abs(with_prefixe'));
    title('Signal after equalization');

%% Demodulation
   [bitsOut, demodulation_dmt_frame] = demodulation(dmt_frame, allocation_qam);

end

