% Testing Script for adc.m

t = [0:0.1:10];
sa = 5 + sin(t);
subplot(211);
plot(t, s);

sd = adc(sa, 5);
subplot(212);
plot(t, sd);
