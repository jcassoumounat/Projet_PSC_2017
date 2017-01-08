function [F] = frame(input_fast_data, input_interleaved_data)
    depth = 3;
    
    %% Fast Path %%
    fast_path = encoderRS(input_fast_data);
    
    %% Interleaved Path %%
    
    interleaved_path = encoderRS(input_interleaved_data);
    interleaved_path = interleaver(interleaved_path, depth)';
    
    %% Concatenation of each path to build the frame %%
    F = [fast_path, interleaved_path];
end