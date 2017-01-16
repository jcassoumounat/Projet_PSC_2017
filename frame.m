function [F] = frame(input_data)
    depth   = 3;
    L       = length(input_data);
    
    
    %% Splitting in fast and interleaving path data %%
    input_fast_data         = input_data(1      : L/2); 
    input_interleaved_data  = input_data(L/2 + 1: L);

    
    %% Fast Path %%
    fast_path = encoderRS(input_fast_data);
    
    %% Interleaved Path %%    
    interleaved_path = encoderRS(input_interleaved_data);
    interleaved_path = interleaver(interleaved_path, depth);
    
    
    %% Concatenation of each path to build the frame %%
    F = [fast_path interleaved_path];
end