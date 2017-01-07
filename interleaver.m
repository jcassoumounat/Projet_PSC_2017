function [interleaved_vector] = interleaver(bit_vector, period)
%mix the bits (coordinates) of a 1-dim vector according to a period
    %inputs :
    %bit_vector : vector we want to interleave
    %period : interval for which the roerdering used algorithm used by the
    %interleaver repeats
    %
    %output :
    %interleaved_vector : 1-dim bit vector with mixed coordinates
    

%----------------------------------------------------%
%Creation of the interleaver table (2-dim vector)

[nb_column, bit_vect_len] = size(bit_vector);

if period > bit_vect_len
    Warning = 'The period chosen is greater than the frame'
end

if period <= bit_vect_len
    for vect_bits_index = 1:bit_vect_len
        %interleaver(row, column)
        %Here are the index of the vector in the interleaver table (ex with period = 5) :
        %1 2 3 4 5
        %6 7 8 9 10
        %11 ..
        [Q,R] = quorem(sym(vect_bits_index-1), sym(period));
        interleaver_table(Q+1, R+1)=bit_vector(vect_bits_index);
    end

    %complete empty coordinates of the table with -1
    [nb_i_t_row, nb_i_t_column] = size(interleaver_table);
    if R+1 < nb_i_t_column
        for i_table_index = R+2 : nb_i_t_column
            interleaver_table(Q+1,i_table_index)=-1;
        end
    end

    interleaver_table;

    %--------------------------------------------------------%


    %---------------------------------------------%
    %-create 1-dim interleaved vector (ex with period = 5 : 1 6 11 16...) 

    i_vect_index = 1;
    for i_t_column = 1:nb_i_t_column
        for i_t_row = 1:nb_i_t_row
            if (interleaver_table(i_t_row, i_t_column) > -1)
                interleaved_vector(i_vect_index) = interleaver_table(i_t_row, i_t_column);
                i_vect_index = i_vect_index + 1;
            end 
        end
    end

end
    

%-----------------------------------------------------%