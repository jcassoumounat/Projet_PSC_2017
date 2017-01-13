function [  ] = main()
%%
    %estimated_channel: represents the average estimated response of 30 responses of the channel to the initialisation frame
    %estimated noise : represents the average estimated noise of 30 responses of the channel to the initialisation frame
    
%%
    tot_channel = 256;                                              %total number of channels
    length_prefixe = 32;                                            %length prefixe
    
%     partial_estimated_response = zeros(tot_channel, tot_frames);
%     estimated_response = zeros(1, tot_channel);
%     partial_estimated_noise = zeros(tot_channel, tot_frames);
%     estimated_noise = zeros(1, tot_channel);
%     
%     qam_frame = zeros(1,tot_channel);
%     dmt_frame = zeros(1,sum(allocation_qam) + length_prefixe);
%     channel_frame = zeros (1,sum(allocation_qam) + length_prefixe); 
%     without_prefixe = zeros(1,sum(allocation_qam));
%     length_data = 256*2; 
  
    allocation_qam= 4*ones(1,tot_channel);

    Te = 1/1104000;                  %sample time
    tableau_temps = (1:1:sum(allocation_qam)/2+length_prefixe);       %Size of the number of discret samples

%     tableau_temps2 = [0:1:255]

    
    [estimated_response, estimated_noise] = estimation_test();
    
    frame = zeros(1,sum(allocation_qam/2));
    frame(50) = 1;
    
    %%jesuisDupre
       
    
%% processing frame in qam and dmt
    [bobi , dmt_frame, qam_frame] = modulation(frame, allocation_qam);

%% processing the frame through the channel
%    [channel_frame, rep_imp,rep_freq_tot] = channel(dmt_frame);
%    figure; plot(tableau_temps*Te, abs(channel_frame));
%    title('signal after the channel');

%%Noise addition 

%     %% AWGN
%         noise_frame = zeros(1, sum(allocation_qam)/log2(4)+length_prefixe);
%         noise_frame = SignalAWGN(channel_frame, 0.0000001);

    %% CrossTalk
        %noise_frame = SignalCrossTalk(channel_frame);
        %figure; plot(diaphonie);
%         title('signal with noise');
    %% SignalDamaged
        %noise_frame = (channel_frame);
        %figure; plot(degat);
    
    
%% Eqalisation
%     with_prefixe = egalisation(rep_freq_tot, channel_frame);

     
     
%% Demodulation

   [bitsOut, demodulation_dmt_frame] = demodulation(dmt_frame, allocation_qam);
    
 %%jesuisdéDupre



end

