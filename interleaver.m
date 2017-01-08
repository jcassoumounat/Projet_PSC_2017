function [interleaved_data] = interleaver(data, Nrows)
%%
% Interleave data by writing sequentially data's bit in an internal matrix
% according its rows and read its column to obtain the interleaved data
% Parameters :
% - Input :
%   *   data    :   binary vector to interleave
%   *   Nrows   :   number of rows of the internal matrix, same as the
%                   interleaving length
% - Output :
%   * interleaved_data  :   binary vector built from the data

    %% Initialization %%
    temp_matrix         = [];
    data_length         = length(data);
    interleaved_data    = -ones(data_length, 1);
    Ncols               = ceil(data_length/Nrows);
    
    %% Writing the rows of the internal matrix %%
    k = 1;
    for i = 1 : Nrows
        for j = 1 : Ncols
            if(k <= data_length)
                temp_matrix(i, j) = data(k);
                k = k + 1;
            else
                temp_matrix(i, j) = -1;
            end
        end
    end
    
    %% Reading the matrix' columns %%
    k = 1;
    for j = 1 : Ncols
        for i = 1 : Nrows
            if(temp_matrix(i, j) ~= -1)
                interleaved_data(k) = temp_matrix(i, j);
                k = k + 1;
            end
        end
    end
end