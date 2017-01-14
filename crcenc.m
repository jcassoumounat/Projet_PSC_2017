function [crc_data] = crcenc(data)
%%
% This function computes the CRC code matching the input data and returns
% a binary vector with the form [data crc].
%%
    size = length(data);
    crc = zeros(1, 8);
    crc_data = zeros(1, size + 8);
    
    %transform a row data vector in a colomn vector
    data = data';
    
    % Create a CRC generator object
    gen = comm.CRCGenerator([1 1 1 0 1 0 1 0 1],'ChecksumsPerFrame',1);
    
    % Encoded data (row vector), 8 crc values at the end
    temp_crc_data = step(gen, data)';
    
    %put the 8 coded values at the beginning of the data
    crc = temp_crc_data(size + 1 : size + 8);
    crc_data = [crc data'];
    
end
