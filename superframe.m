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
    sframe = [];
    
    %% Frame parameters %%
    fsize       = sum(log2(allocation_table));   % sum of nb of bits of the bit allocation table
    fdata_size  = fsize - FEC_size;              % frame data size 
    
    %% Superframe parameters %%
    sfdata_size = fdata_size * nb_frames;       % bits, remove CRC_size bits due to frame 0 !!! -CRC_size
    
    %% CRC encoding %%
    cdata = crcenc(data(1 : sfdata_size - CRC_size));
    
    %% frame 1 -> 68 %%
    for frame_nb = 1 : 68
        fdata = [];
        for i = 1 : fdata_size
            fdata(i) = cdata((frame_nb-1)*fdata_size + i);
            nb_data_treated = nb_data_treated + 1;
        end
        sframe = [sframe frame(fdata)];
    end
    
    %% remaining data %%
    if nb_data_treated < data_size
        remaining_data = data(nb_data_treated+1 - CRC_size : data_size);
    end
end