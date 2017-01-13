function [sframe, remaining_data] = superframe(data, allocation_table)
    % Create a superframe from a given amount of data
    % - sframe   : data transform into a superframe of 17ms.
    % - remaining_data      : [] if all data are in the superframe; otherwise vector of data which are not in the superframe (data > superframe length)
    %
    %   data : data we want to put in a superframe
    %   allocation_table : calculated with water filling
     
    CRC_size    = 8;            % first bits of the superframe included in frame0
    FEC_size    = 32;           % � changer en passant � une variable globale de la forme 2 * m * (n - k)
    nb_frames   = 68;           % number of frames in a superframe
    remaining_data = [];
    nb_data_treated = 0;
    data_size = length(data);
    
    %% Frame parameters %%
    fsize       = sum(log2(allocation_table))   % sum of nb of bits of the bit allocation table
    fdata_size  = fsize - FEC_size              % frame data size 
    
    %% Superframe parameters %%
    crc_sfsize  = fsize * nb_frames;            % bits
    sfdata_size = fdata_size * nb_frames;       % bits, remove CRC_size bits due to frame 0 !!! -CRC_size
      
    %% frame0 %%
    for i = 1 : fdata_size
        fdata(i) = data(i);
        nb_data_treated = nb_data_treated + 1;
    end 
    sframe = frame(fdata);
    
    %% frame 1 -> 67 %%
    for frame_nb = 2 : 68
        fdata = [];
        for i = 1 : fdata_size
            fdata(i) = data((frame_nb-1)*fdata_size + i);
            nb_data_treated = nb_data_treated + 1;
        end
        sframe = [sframe frame(fdata)];
    end
    
    %% remaining data %%
    if nb_data_treated < data_size
        remaining_data = data(nb_data_treated+1 : data_size);
    end
end

% function [superframe_vector, remaining_data] = superframe(data, rate)
%     % Create a superframe from a given amount of data
%     % - superframe_vector   : data transform into a superframe of 17ms.
%     % - remaining_data      : 0 if all data are in the superframe (a superframe has a given size thus it is completed with 0)
%     %; otherwise vector of data which are not in the superframe (data > superframe length)
%     %
%     %   data : data we want to put in a superframe
%     %   rate : rate of the communication, calculated before
% 
%     data_size = size(data, 2);
%     NB_FRAMES_SUPERFRAME = 69; %the 69th frame is the sync frame
%     SUPERFRAME_DURATION = 0.017;
%     FRAME_DURATION = SUPERFRAME_DURATION/NB_FRAMES_SUPERFRAME; %seconds
%     FEC_SIZE = 8; %bits !!!!!!!!!!!!!!!see in function of the CRC salomon code!!!!!!!!!!!!!!!!!
%     end_data = 0; %0 : don't reach the end of data ; 1 : reach the end of data
%     frame_size = round(rate * FRAME_DURATION); %bits
% 
%     %Calculation of the nb of data bits in a frame
%     data_frame_size = frame_size - FEC_SIZE;
%     %Calculation of the nb of data bits in a superframe
% 
%     %initialisation of the returned vector
%     remaining_data = 0;
% 
%     data_treated = 0;
% 
%     %frame 0 and 1
%     superframe_vector = frame0();
% 
%     superframe_vector = [superframe_vector frame1()];
% 
%     %-----------------------------------%
%     %frame 2 to 33
%     for nb_frame = 1 : 32  
%         %(re)set data_frame : temp buffer between data and frames
%         data_frame = zeros(1, data_frame_size);
% 
%         %have not reached the end of data -> put data in output vector
%         if end_data == 0   
%             data_frame_treated = 0;
%             while data_frame_treated < data_frame_size
%                 %write data in a vector
%                 if data_treated < data_size
%                     data_frame(data_frame_treated+1) = data(data_treated+1);
% 
%                 %end of data
%                 else
%                     end_data = 1; %reach the end of data
%                     for i = data_frame_treated+1 : data_frame_size
%                         data_frame(i) = 0;
%                     end 
%                     break
%                 end
% 
%                 data_treated = data_treated + 1;
%                 data_frame_treated = data_frame_treated + 1;        
%             end 
%         end
% 
%         %add data_frame in superframe, if end_data=1 -> only zeros.
%         superframe_vector = [superframe_vector frame(data_frame, FEC_SIZE) ];   
%     end
% 
%     %------------------------------------%
% 
%     %-------------------------------------%
%     %frame 34 and 35
%     superframe_vector = [superframe_vector frame34()];
% 
%     superframe_vector = [superframe_vector frame35()];
% 
%     %-------------------------------------%
% 
%     %-------------------------------------%
%     %frame 36 to 67
%     for nb_frame = 1 : 32  
%         %(re)set data_frame : temp buffer between data and frames
%         data_frame = zeros(1, data_frame_size);
% 
%         %have not reached the end of data -> put data in output vector
%         if end_data == 0   
%             data_frame_treated = 0;
%             while data_frame_treated < data_frame_size
%                 %write data in a vector
%                 if data_treated < data_size
%                     data_frame(data_frame_treated+1) = data(data_treated+1);
% 
%                 %end of data
%                 else
%                     end_data = 1; %reach the end of data
%                     for i = data_frame_treated+1 : data_frame_size
%                         data_frame(i) = 0;
%                     end 
%                     break
%                 end
% 
%                 data_treated = data_treated + 1;
%                 data_frame_treated = data_frame_treated + 1;        
%             end 
%         end
% 
%         %add data_frame in superframe, if end_data=1 -> only zeros.
%         superframe_vector = [superframe_vector frame(data_frame, FEC_SIZE) ];   
%     end
% 
%     %--------------------------------------------------%
% 
%     %remaining data
%     if end_data == 0
%         remaining_data = zeros(1, data_size-data_treated);
%         for i = data_treated+1 : data_size
%             remaining_data(i-data_treated)=data(i);
%         end
%     end
% end

