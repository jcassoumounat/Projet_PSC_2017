function [desframe, remaining_cdata] = desuperframe(csframe, allocation_table)

csframe_size = length(csframe);
CRC_size    = 8;            % first bits of the superframe included in frame0
FEC_size    = 32;           % � changer en passant � une variable globale de la forme 2 * m * (n - k)
nb_frames   = 68;           % number of frames in a superframe
remaining_cdata = [];
desframe = [];
nb_data_treated = 0;

%% Frame parameters %%
f_size       = sum(log2(allocation_table))   % sum of nb of bits of the bit allocation table

%% frame 1 -> 68 %%
for frame_nb = 1 : 68
    cframe = [];
    for j = 1 : f_size
        cframe(j) = csframe((frame_nb-1) * f_size + j);
        nb_data_treated = nb_data_treated + 1;
    end
    desframe = [desframe deframe(cframe)];
end

 %% remaining data %%
if nb_data_treated < csframe_size
    remaining_cdata = csframe(nb_data_treated+1 : csframe_size);
end

end