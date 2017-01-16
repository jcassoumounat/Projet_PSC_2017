function  [output_signal, rep_imp, rep_freq] = channel( input_signal )
%This function represents a model of the ADSL channel. 
%for a basic ADSL line, ie: 256 channels
    %INPUT: The frame that needs to be transmitted through the channel
    
    %OUTPUT: output_signal: the signal at the exit of the channel
    %        remp_imp: the impulsionnal response
    %        rep_freq : the frequency response
close all
%%
%Parameters of the line
    % frequency bandwith
    half_bandwidth = [0:1104000/256:1104000-(1104000/256)];
    bandwidth = [0:2208000/512:2208000-(2208000/512)];
    
    tot_channel = 256;                                              %total number of channels
    
    noise_coef = 0.00001;
    %Constants 
    perme_vide = 4*pi*10^-7 ;        %vacuum permeability u0
    permi_vide = 1/(36*pi)*10^-9 ;   %vacuum permitivity e0
    permi_rela = 2;                  %relative permitivity between the two isulators
    Te = 1/1104000;                  %sample time

    %parameters of the line
    d = 0.001           ;            % diameter of the wire
    D = 1.5*d            ;           % distance between the two wires
    permi = 2 * permi_vide ;         % permitivity of the line
    conduct = 5.65*10^7     ;        % conductivity of copper (1/resistivity)
    longueur = 3000;                 %length of the line
    reflex_entree = 1/2;
    reflex_sortie = 1/2;

    %primary parameters of the line
    L = (perme_vide/pi)*log(2*D/d);                                         %Linear Inductance
    C = (pi*permi_vide*permi_rela)/(log(2*D/d));                            %Linear capacity
    G = C*10^-3*2*pi*half_bandwidth;                                        %Linear conductance
    R = sqrt((perme_vide*half_bandwidth)/(pi*conduct))/(d*sqrt(1-(d/D)^2)); %Linear electrical resistance

    %Size of the number of discret samples
    tableau_temps = [1:1:2*tot_channel];   % We need not forget that when we want our impulse response we need the full period of 512 points. We therefor need to perform a hermetian symmetry to obtain a signal on 512 samples.
    tableau_temps2 = [1:1:tot_channel];
    
 %%
 
    %The gamma parameter
    gamma = sqrt(  (R + j*L*2*pi*half_bandwidth).*(G + j*C*2*pi*half_bandwidth)  );

    %Frequency response without reflection
     rep_freq = 1/2*exp(-gamma*longueur);

    %Frequency response with reflexion
%      rep_freq = 0.5 * (1 + reflex_sortie) * exp(- gamma * longueur)  ./ (1 - reflex_entree* reflex_sortie * exp(-2 * gamma * longueur));
    figure; plot(half_bandwidth, abs(rep_freq));
    title('Frequential Response');
   
    %Symetric frequency response
    rep_freq_sym = fliplr(conj(rep_freq));
    

    %Total frequency response
    rep_freq_tot =  [0, rep_freq(2:256),0, rep_freq_sym(1:255)];
     figure; plot(bandwidth, abs(rep_freq_tot));
     title('Total Frequency Response');

    %Impulsionnal response
    rep_imp = ifft(rep_freq_tot);
    
    %% adding noise
    %rep_imp = SignalAWGN(rep_imp, noise_coef);
%      rep_imp = SignalCrossTalk(rep_imp);
%     figure ; plot(abs(fft(rep_imp)));

    %Impulsionnal response 
    figure; plot(tableau_temps*Te, rep_imp);
    title('impulsionnal response');

    %convolution of the input signal with the impulsionnal response
    output_signal = filter(rep_imp, 1 , input_signal);
        

end
