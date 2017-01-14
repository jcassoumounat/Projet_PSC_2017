function [crossTalkedSignal] = SignalCrossTalk(H, InputSignal)
%% 
% Return the input signal with added CrossTalk.
% Parameters :
% - Inputs :
%   * InputSignal : Real vector
%
% - Outputs :
%   * SignalWithAWGN : Real vector with crosstalk signal added

    %% Parameters %%
    N       = length(InputSignal);      % Number of subchannels
    Fmax    = 1104000;                  % Maximum Frequency in Hz    
    f       = (0:Fmax/(N - 1):Fmax);    % Frequencies range
    f0      = 2208000;                  % Hz
    fh1     = 1104000;                  % Hz
    fh2     = 25875;                    % Hz
    fl      = 4000;                     % Hz
    Vp      = 2.5;                      % Volts
    R       = 135;                      % Ohms
    n       = 49;                       % Number of disturbing beams, < 50
    K991    = 0.1104;                   % Watts
    alpha1  = 36 / (10 * log10(2))
    alpha2  = 57.5 / (10 * log10(fh2 / fl))
    k       = 8 * 10^(-20) * (n / 49)^0.6; 
    L       = 2744;                     % meters, length of the line
    p       = 3.28;                     % feet/meters
    
    LPF = fh1^alpha1 * ones(size(f)) ./ (f.^alpha1 + fh1.^alpha1);
    HPF = (f.^alpha2 + fl^alpha2 * ones(size(f))) ./ (f.^alpha2 + fh2.^alpha2);
    %% Compute the DSP for disturbing signals %%
    % DSP of disturbing signals %
    DSP_G9921 = K991 * 2 * sinc(pi * f / f0).^2 .* LPF .* HPF /f0;
    
    % DSP of FEXT
    HFEXT       = k * L * p * f.^2 .* abs(H).^2; 
    DSP_FEXT    = DSP_G9921 .* HFEXT;
    FEXT        = sqrt(DSP_FEXT .* f);
    
    % DSP of NEXT
    DSP_NEXT    = DSP_G9921 * 0.8536 * 10^(-14) * n^0.6;
    NEXT        = sqrt(DSP_NEXT .* f);
    
    crossTalkedSignal = InputSignal + NEXT + FEXT;
end