function [data] = deinterleaver(interleaved_data, Nrows)
%%
% De-interleave data by writing sequentially data's bit in an internal matrix
% according to its columns and read its rows to obtain the de-interleaved data
% Parameters :
% - Input :
%   *   interleaved_data    :   binary vector to de-interleave
%   *   Nrows               :   number of rows of the internal matrix, same as the
%                               interleaving length
% - Output :
%   * data  :   binary vector built from the data interleaved
%%
    %% Initialization %%
    temp_matrix         = [];
    data_length         = length(interleaved_data);
    data                = -ones(data_length, 1);
    Ncols               = ceil(data_length/Nrows);
    
    %% Writing the matrix' columns %%
    k = 1;
    for j = 1 : Ncols
        for i = 1 : Nrows
            if(k <= data_length)
                temp_matrix(i, j) = interleaved_data(k);
                k = k + 1;
            else
                temp_matrix(i, j) = -1;
            end
        end
    end
    
    %% Reading the matrix' rows %%
    k = 1;
    for i = 1 : Nrows
        for j = 1 : Ncols
            if(temp_matrix(i, j) ~= -1)
                data(k) = temp_matrix(i, j);
                k = k + 1;
            end
        end
    end
end