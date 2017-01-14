%% Test CrossTalk %%
%% Parameters for testing %%
N       = 511;
Tmax    = 10;
t       = (0 : Tmax/N : Tmax);

x       = sin(t);
[y, h]  = channel(x);
H       = fft(h);

y_ct    = SignalCrossTalk(H, y);
est_x   = egalisation(h, y);

figure(1);
clf();
plot(t, x);

figure(2);
clf();
plot(abs(y_ct));

figure(3);
clf();
plot(t, est_x);