function [desframe, err, remaining_cdata] = desuperframe(csframes, allocation_table)
    % Find the data of a superframe
    % - desframes   : data from coded superframe
    % - remaining_data      : [] if all data are decoded; otherwise vector of data which are not in the superframe (superframes length > 1 superframe)
    %
    %   csframe : superframes we want to decode
    %   allocation_table : calculated with water filling
     
    csframe_size = length(csframes);
    CRC_size    = 8;            % first bits of the superframe included in frame0
    FEC_size    = 32;           % � changer en passant � une variable globale de la forme 2 * m * (n - k)
    nb_frames   = 68;           % number of frames in a superframe
    remaining_cdata = [];
    cdesframe = [];             %still CRC encodage
    desframe = [];
    nb_data_treated = 0;

    %% Frame parameters %%
    f_size = sum(log2(allocation_table));   % sum of nb of bits of the bit allocation table

    %% frame 1 -> 68 %%
    for frame_nb = 1 : 68
        cframe = [];
        for j = 1 : f_size
            cframe(j) = csframes((frame_nb-1) * f_size + j);
            nb_data_treated = nb_data_treated + 1;
        end
        cdesframe = [cdesframe deframe(cframe)];
    end
    
    %% CRC decoding %%
    cdesframe = double(cdesframe);
    [desframe err] = crcdec(cdesframe);

     %% remaining data %%
    if nb_data_treated < csframe_size
        remaining_cdata = csframes(nb_data_treated+1 : csframe_size);
    end

end