gains	= ones([256,1]);
bruits  = zeros([256,1]);
ber 	= thresholds;
ptot 	= 100;

alloc = allocation(ber, gains, bruits, ptot)