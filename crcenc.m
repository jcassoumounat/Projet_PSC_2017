function [crc_data] = crcenc(data)
%%
% This function computes the CRC code matching the input data and returns
% a binary vector with the form [data crc].
%%
    % Create a CRC generator object
    gen = comm.CRCGenerator([1 1 1 0 1 0 1 0 1],'ChecksumsPerFrame',1);
    
    % Encoded data
    crc_data = step(gen, data);
end
