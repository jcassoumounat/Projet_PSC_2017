%% Parameters for testing %%
N       = 511;
Tmax    = 10;
t       = (0 : Tmax/N : Tmax);
sigma   = 0.01;

%% Compute signals %%
% Signal entering in the channel
s_in  = sin(t);

% Signal convolved with the channel
[s_out, rep_imp] = channel(s_in);

% Signal with AWGN noise
s_out = SignalAWGN(s_out, sigma);

% Signal convolved with channel's inverse impulsionnal response
s_est = egalisation(abs(rep_imp), s_out);

figure(1);
clf();
subplot(411);
plot(t, s_in);

subplot(412);
plot(t, abs(rep_imp));

subplot(413);
plot(t, s_out);

subplot(414);
plot(t, s_est);