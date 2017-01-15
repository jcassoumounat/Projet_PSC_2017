% This script allows the recuperation of the SNRs which grant a bit-error-rate lower than 10^(-7)

i = 1;
while ((i <= length(berQAM4)) && (berQAM4(i) > 10^(-7)))
    i = i + 1;
end
threshold_snrQAM4 = snrQAM4(i)

i = 1;
while ((i <= length(berQAM8)) && (berQAM8(i) > 10^(-7)))
    i = i + 1;
end
threshold_snrQAM8 = snrQAM8(i)

i = 1;
while ((i <= length(berQAM16)) && (berQAM16(i) > 10^(-7)))
    i = i + 1;
end
threshold_snrQAM16 = snrQAM16(i);
