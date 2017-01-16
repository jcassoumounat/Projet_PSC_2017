function [SignalWithAWGN] = SignalAWGN(InputSignal, N0)
%% 
% Return the input signal with added white gaussian noise.
% Parameters :
% - Inputs :
%   * InputSignal : Input Signal vector
%   * s : Standard deviation
%
% - Outputs :
%   * SignalWithAWGN : Signal with added white gaussian noise

    %% Parameters %%
    N    = length(InputSignal); %Input Signal vector's length
    AWGN = N0*randn(1, N);        %Added White Gaussian Noise
    
    %% Add the noise to the signal %%
    SignalWithAWGN = AWGN + InputSignal;   
end