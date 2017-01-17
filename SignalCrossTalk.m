function [SignalWithCrossTalk] = SignalCrossTalk(InputSignal)
%% 
% Return the input signal with added CrossTalk.
% Parameters :
% - Inputs :
%   * InputSignal : Input Signal vector
%
% - Outputs :
%   * SignalWithAWGN : Signal with added white gaussian noise

    %% Encoding parameters %%
    N=length(InputSignal);      %Signal Length(255)
    Fmax=2208000;               %Maximum Frequency
    Fpas=4312.5;                %Frequency step
    f=[Fpas:Fpas:Fmax];         %Frequency tab
    f0=270000;                  %Specific Frequency used fot this formula
    
    %% Encoding %%
    %Calculate the K[i] coefficients
    for i=1:N
        if f(i)<28000
            K(i)=0;
        elseif f(i)<=138000
            K(i)=-38;
        else
            K(i)=-38-24*(f(i)-138000)/4312,5;
        end
    end
    
    %Applicate the formula in order to calculate cross talk
    for i=1:N
        %Power Spectral Density of CrossTalk (dBm/Hz)
        PSD(i)=K(i)*(sin(pi*f(i)/f0)/(pi*f(i)/f0))^2;
        %Power of chanel i (dBm)
        PChanneldBm(i)=PSD(i)*4312.5;
        %Power of chanel i (W)
        PChannelW(i)=10^(PChanneldBm(i)/10-3);
        %Standard Deviation of Channel i
        sigma(i)=sqrt(PChannelW(i));
        %White Gaussian Noise
        WhiteNoise=0.1*randn(1,N);
        %CrossTalk calculated proportionnaly to sigma
        CrossTalk(i)= sigma(i)*WhiteNoise(i);
        %add the WGN 
        SignalWithCrossTalk(i)= InputSignal(i)+ sigma(i)*WhiteNoise(i);
    end
end