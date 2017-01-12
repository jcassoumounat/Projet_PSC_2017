function [interleaved_data] = interleaver(data, Ncols)
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
   L = length(data);
   [Q, R] = quorem(sym(L), sym(Ncols));
   Q = double(Q);
   R = double(R);
   Nrows = Q + 1;
   
   %% Set useless matrix' coefficients for interleaving to -1 %%
   temp_mat = zeros(Nrows, Ncols);
   for j = (R + 1) : Ncols
       temp_mat(Nrows, j) = -1;
   end
   temp_mat
   
   %% Writing matrix' rows with datat(k) %%
   k = 1;
   for i = 1 : Nrows
       for j = 1 : Ncols
           if(temp_mat(i, j) ~= -1)
                temp_mat(i, j) = data(k);
                k = k + 1;
           end
       end
   end
   temp_mat
   %% Reading matrix' cols and write in interleaved_data %%
   k = 1
   for j = 1 : Ncols
       for i = 1 : Nrows
           if(temp_mat(i, j) ~= -1)
               interleaved_data(k) = temp_mat(i, j);
               k = k + 1;
           end
       end
   end
end