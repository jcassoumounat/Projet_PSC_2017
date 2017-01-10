function [SignalWithPerturbation] = SignalDamaged (InputSignal)
%% 
% Return the input signal with added intensity peak.
% Parameters :
% - Inputs :
%   * InputSignal : Input Signal vector
%
% - Outputs :
%   * SignalWithPerturbation : Signal with added Perturbation

    %% Encoding parameters %%
    N=length(InputSignal);              %Signal Length
    peak=floor(rand()*N);               %center of the peak of added intensity
    bound=floor(rand()*6);              %bound of the peak of added intensity
    SignalWithPerturbation=InputSignal; %Signal with perturbation
    
    %% Encoding %%
    %low probability of happening
    if rand()<0.05
        %add a random peak of intensity
        SignalWithPerturbation(peak-bound:peak+bound)=InputSignal(peak-bound:peak+bound)+rand()*10+10;
    end
end
