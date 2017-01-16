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
   %% Reading matrix' cols and write in interleaved_data %%
   k = 1;
   for j = 1 : Ncols
       for i = 1 : Nrows
           if(temp_mat(i, j) ~= -1)
               interleaved_data(k) = temp_mat(i, j);
               k = k + 1;
           end
       end
   end
end


% function [interleaved_vector] = interleaver(bit_vector, period)
% %mix the bits (coordinates) of a 1-dim vector according to a period
%     %inputs :
%     %bit_vector : vector we want to interleave
%     %period : interval for which the roerdering used algorithm used by the
%     %interleaver repeats
%     %
%     %output :
%     %interleaved_vector : 1-dim bit vector with mixed coordinates
%     
% 
% %----------------------------------------------------%
% %Creation of the interleaver table (2-dim vector)
% 
% [nb_column, bit_vect_len] = size(bit_vector);
% 
% if period > bit_vect_len
%     Warning = 'The period chosen is greater than the frame'
% end
% 
% if period <= bit_vect_len
%     for vect_bits_index = 1:bit_vect_len
%         %interleaver(row, column)
%         %Here are the index of the vector in the interleaver table (ex with period = 5) :
%         %1 2 3 4 5
%         %6 7 8 9 10
%         %11 ..
%         [Q,R] = quorem(sym(vect_bits_index-1), sym(period));
%         interleaver_table(Q+1, R+1)=bit_vector(vect_bits_index);
%     end
% 
%     %complete empty coordinates of the table with -1
%     [nb_i_t_row, nb_i_t_column] = size(interleaver_table);
%     if R+1 < nb_i_t_column
%         for i_table_index = R+2 : nb_i_t_column
%             interleaver_table(Q+1,i_table_index)=-1;
%         end
%     end
% 
%     interleaver_table;
% 
%     %--------------------------------------------------------%
% 
% 
%     %---------------------------------------------%
%     %-create 1-dim interleaved vector (ex with period = 5 : 1 6 11 16...) 
% 
%     i_vect_index = 1;
%     for i_t_column = 1:nb_i_t_column
%         for i_t_row = 1:nb_i_t_row
%             if (interleaver_table(i_t_row, i_t_column) > -1)
%                 interleaved_vector(i_vect_index) = interleaver_table(i_t_row, i_t_column);
%                 i_vect_index = i_vect_index + 1;
%             end 
%         end
%     end
% 
% end
    

%-----------------------------------------------------%
% function [interleaved_data] = interleaver(data, Nrows)
% %%
% % Interleave data by writing sequentially data's bit in an internal matrix
% % according its rows and read its column to obtain the interleaved data
% % Parameters :
% % - Input :
% %   *   data    :   binary vector to interleave
% %   *   Nrows   :   number of rows of the internal matrix, same as the
% %                   interleaving length
% % - Output :
% %   * interleaved_data  :   binary vector built from the data
% 
%     %% Initialization %%
%     temp_matrix         = [];
%     data_length         = length(data);
%     interleaved_data    = -ones(data_length, 1);
%     Ncols               = ceil(data_length/Nrows);
%     
%     %% Writing the rows of the internal matrix %%
%     k = 1;
%     for i = 1 : Nrows
%         for j = 1 : Ncols
%             if(k <= data_length)
%                 temp_matrix(i, j) = data(k);
%                 k = k + 1;
%             else
%                 temp_matrix(i, j) = -1;
%             end
%         end
%     end
%     
%     %% Reading the matrix' columns %%
%     k = 1;
%     for j = 1 : Ncols
%         for i = 1 : Nrows
%             if(temp_matrix(i, j) ~= -1)
%                 interleaved_data(k) = temp_matrix(i, j);
%                 k = k + 1;
%             end
%         end
%     end
% end