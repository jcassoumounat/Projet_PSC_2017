gains	= randi(10, 256, 1);
bruits  = -randi(5, 256, 1);
ber 	= thresholds;
ptot 	= 10;

alloc = allocation(ber, gains, bruits, ptot);
alloc'
