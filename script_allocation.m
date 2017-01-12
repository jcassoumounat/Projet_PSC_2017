% SNR thresholds which grant a probability of error lower than 10^(-7)
% They have been determined with Matlab's bertool
threshold_snrQAM4       =    7.8000;    % threshold for a 4-QAM

threshold_snrQAM8       =   10.6000;    % threshold for a 8-QAM

threshold_snrQAM16      =   11.4000;    % threshold for a 16-QAM

thresholds = [threshold_snrQAM4, threshold_snrQAM8, threshold_snrQAM16];

gains	= randi(10, 256, 1);
bruits  = -randi(5, 256, 1);
ber 	= thresholds;
ptot 	= 10;

alloc = allocation(ber, gains, bruits, ptot);
alloc';
