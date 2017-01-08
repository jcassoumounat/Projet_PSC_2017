function [rs_data] = encoderRS(data)
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
    int_data  = bi2de(data, 'left-msb');

    % Create message based on GF(2^m) from int_info
    msg = gf(int_data, m);

    % Generate RS(n, k) codeword.
    codeword = rsenc(msg, n, k);
    
    % Convert codeword from integer to binary vector
    rs_data  = reshape(de2bi(codeword.x, m, 'left-msb'), 1, n*m);
end
