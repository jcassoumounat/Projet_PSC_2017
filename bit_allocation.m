function [alloc] = bit_allocation()

% SNR seuils à partir desquels on peut garantir un BER inférieur à 10^(-7).
% Ces SNRs ont été déterminé à l'aide des courbes BER tracées avec bertool.

threshold_snrQAM4 	=    7.8000;	% Seuil pour une 4-QAM
threshold_snrQAM8 	=   10.6000;	% Seuil pour une 8-QAM
threshold_snrQAM16 	=   11.4000;	% Seuil pour une 16-QAM
thresholds = [threshold_snrQAM4, threshold_snrQAM8, threshold_snrQAM16];	% Vecteur des seuils

gains	= randi(10, 256, 1);
bruits  = -randi(5, 256, 1);
ber 	= thresholds;
ptot 	= 10;

alloc = allocation(ber, gains, bruits, ptot);
alloc';

end

