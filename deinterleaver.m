function [deinterleaved_vector] = deinterleaver(interleaved_vector, period)
%reorganise the bits (coordinates) of a 1-dim vector according to a period
    %inputs :
    %-interleaved_vector : vector we want to deinterleave
    %-period : interval for which the roerdering used algorithm used by the
    %interleaver repeats
    %
    %output :
    %-deinterleaved_vector : 1-dim bit vector with coordinates in the right
    %order

[nb_column, bit_vect_len] = size(interleaved_vector);

if period > bit_vect_len
    Warning = 'The period chosen is greater than the frame'
end

if period <= bit_vect_len

%----------------------------------------------------%
%Creation of the deinterleaver table (2-dim vector)

    [Q,R] = quorem(sym(bit_vect_len), sym(period));
    nb_empty_coord = period - R;
    pbl_row = period - nb_empty_coord +1; %special treatment from this row
    i_vect_index = 1;
    for i_t_row = 1:period
        %all column exept th last one
        for i_t_column = 1:Q
            deinterleaver_table(i_t_row, i_t_column) = interleaved_vector(i_vect_index);
            i_vect_index = i_vect_index + 1;
        end
        %last column : column Q+1
        if i_t_row >=pbl_row
            deinterleaver_table(i_t_row, Q+1) = -1;
        end
        if i_t_row < pbl_row
            deinterleaver_table(i_t_row, Q+1) = interleaved_vector(i_vect_index);
            i_vect_index = i_vect_index + 1;
        end

    end

    deinterleaver_table;

    %--------------------------------------------------------%


    %---------------------------------------------%
    %-create 1-dim deinterleaved vector (ex with period = 5 : 1 2 3 4 5 6...) 

    [nb_i_t_row, nb_i_t_column]=size(deinterleaver_table);
    i_vect_index = 1;
    for i_t_column = 1:nb_i_t_column
        for i_t_row = 1:nb_i_t_row
            if (deinterleaver_table(i_t_row, i_t_column) > -1)
                deinterleaved_vector(i_vect_index) = deinterleaver_table(i_t_row, i_t_column);
                i_vect_index = i_vect_index + 1;
            end 
        end
    end

end
    

%-----------------------------------------------------%