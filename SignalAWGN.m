function [SignalWithAWGN] = SignalAWGN(InputSignal, s)
%% 
% Return the input signal with added white gaussian noise.
% Parameters :
% - Inputs :
%   * InputSignal : Input Signal vector
%   * s : Standard deviation
%
% - Outputs :
%   * SignalWithAWGN : Signal with added white gaussian noise

    %% Encoding parameters %%
    N       = length(InputSignal);  %Input Signal vector's length
    AWGN    = s*randn(1,N);         %Added White Gaussian Noise
    SignalWithAWGN = zeros(1,N);
    
    %% Encoding %%
    %add white noise to the input signal
    for i=1:N
        SignalWithAWGN(i)=AWGN(i)+InputSignal(i) ;   
    end
end