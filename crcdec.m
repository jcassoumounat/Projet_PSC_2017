function [data, err] = crcdec(crc_data)
%%
% This function decode CRC-encoded data and returns the data with the
% error.
%%
    size = length(crc_data);
    temp_crc_data = zeros(size, 1);

    %put the 8 coded values at the end of the crc_data
    crc = crc_data(1 : 8);
    temp_crc_data = crc_data(9 : size);
    crc_data = [temp_crc_data crc];

    %transform a row crc_data vector in a colomn vector
    crc_data = crc_data';
    
    % Create a CRC decoder object
    detect = comm.CRCDetector([1 1 1 0 1 0 1 0 1],'ChecksumsPerFrame', 1);
    
    % Decoded data (row vector), err=0 if no error, err=1 if error(s)
    [data, err] = step(detect, crc_data);
    data = data';
end
