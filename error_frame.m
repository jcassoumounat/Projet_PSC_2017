function [error_data] = error_frame(data, nb_error_fast, nb_error_interl)
    error_data = data;
    nb_error = nb_error_fast + nb_error_interl;
    size = length(data);
    fast_size = size/2;
    inter_size = size/2;
    wrong_ind = zeros(1, nb_error);
    for i = 1 : nb_error_fast
        wrong_ind(i) = round(fast_size/2) + i*10; % error every 10 bits since the half
    end
    for j = nb_error_fast + 1 : nb_error
        wrong_ind(j) = fast_size + round(inter_size/2) + j*10; % error every 10 bits since the half
    end
    wrong_ind;
    for k = 1 : nb_error
        if data(wrong_ind(k)) == 1
            error_data(wrong_ind(k)) = 0;
        else
            error_data(wrong_ind(k)) = 1;
        end
    end
end