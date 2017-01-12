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
    m = 8;                          % Number of bits per symbol
    k = ceil(length(data)/m)       % Number of symbols to encode
    n = k + 2;                      % Number of symbols in the code word. n must be equal to or greater than k + 2
    rs_data = [];
    
    %% Encoding %%
    % Convert data to integer
    data
    for i = 1 : k
        int_data(i)  = bi2de(data((i-1)*m + 1 : i*m), 'left-msb');
    end

    % Create message based on GF(2^m) from int_info
    msg = gf(int_data, m);

    % Generate RS(n, k) codeword.
    codeword = rsenc(msg, n, k);
    codeword = codeword.x;
    % Convert codeword from integer to binary vector
    for i = 1 : n
        rs_data = [rs_data de2bi(codeword(i), m, 'left-msb')];
    end
end
