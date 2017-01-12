function [data] = deinterleaver(interleaved_data, Ncols)
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
   L = length(interleaved_data);
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
   
   %% Writing matrix' cols with interleaved_data(k) %%
   k = 1;
   for j = 1 : Ncols
      for i = 1 : Nrows
           if(temp_mat(i, j) ~= -1)
                temp_mat(i, j) = interleaved_data(k);
                k = k + 1;
           end
       end
   end
   temp_mat
   %% Reading matrix' rows and write in data %%
   k = 1
   for i = 1 : Nrows
       for j = 1 : Ncols
           if(temp_mat(i, j) ~= -1)
               data(k) = temp_mat(i, j);
               k = k + 1;
           end
       end
   end
end