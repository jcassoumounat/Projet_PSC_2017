function [data] = decoderRS(rs_data)
%%
% Return the binary RS(3, 1)-codeword that matches binary data.
% Parameters :
% - Inputs :
%   * data  :   binary vector to encode on 8 bits (ADSL standard)
%
% - Outputs :
%   * rs_data   : binary codeword

    %% Encoding parameters %%
    m = 8;                           % Number of bits per symbol
    n = floor(length(rs_data)/m);    % Number of symbols to encode
    k = n - 2;                       % Number of symbols in the code word. n must be equal to or greater than k + 2
    int_rs_data = [];%zeros(1, n);
    data = [];
    
    %% Encoding %%
    % Convert data to integer
    for i = 1 : n
        temp1 = rs_data((i-1)*m + 1 : i*m);
        int_rs_data(i)  = bi2de(temp1, 'left-msb');
    end
    
    % Create codeword based on GF(2^m) from int_rs_data
    codeword = gf(int_rs_data, m);

    % Generate decoded message.
    msg = rsdec(codeword, n, k);
    msg = msg.x;
    
    % Convert message from integer to binary vector
    for i = 1 : k
        data = [data de2bi(msg(i), m, 'left-msb')];
    end
end