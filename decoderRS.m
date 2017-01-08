function [data] = decoderRS(rs_data, data_size)
%%
% Return the binary RS(3, 1)-codeword that matches binary data.
% Parameters :
% - Inputs :
%   * data  :   binary vector to encode on 8 bits (ADSL standard)
%
% - Outputs :
%   * rs_data   : binary codeword

    %% Encoding parameters %%
    k = 1;     % Number of symbols to encode
    m = 8;     % Number of bits per symbol
    n = k + 2; % Number of symbols in the code word. n must be equal to or greater than k + 2
    
    %% Encoding %%
    % Convert data to integer
    rs_data_reshaped = reshape(rs_data, n, m);
    int_rs_data  = [    bi2de(rs_data_reshaped(1, :), 'left-msb');
                        bi2de(rs_data_reshaped(2, :), 'left-msb');
                        bi2de(rs_data_reshaped(3, :), 'left-msb');
                   ];

    % Create codeword based on GF(2^m) from int_rs_data
    codeword = gf(int_rs_data', m);

    % Generate decoded message.
    msg = rsdec(codeword, n, k);
    
    % Convert message from integer to binary vector
    data  = reshape(de2bi(msg.x, data_size, 'left-msb'), 1, data_size);
end