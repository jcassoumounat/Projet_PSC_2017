function [data, err] = crcdec(crc_data)
%%
% This function decode CRC-encoded data and returns the data with the
% error.
%%
    % Create a CRC decoder object
    detect = comm.CRCDetector([1 1 1 0 1 0 1 0 1],'ChecksumsPerFrame', 1);
    
    % Encoded data
    [data, err] = step(detect, crc_data);
end
