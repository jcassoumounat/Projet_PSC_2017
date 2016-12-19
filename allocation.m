function alloc=allocation(ber, gains, bruits, ptot)
    
    alloc 	= zeros([256, 1]);	% Vecteur contenant le type de modulation qu'il faudra appliquer pour chaque sous-canal
    alphas 	= zeros([256, 2]);	% Vecteur des rapports bruit à canal
    R		= ones([256, 2]);	% Vecteur des pourcentages de la puissance totale
    SNR		= zeros([256, 2]);	% Vecteur des SNR de chaque sous-canal
    
    %--- Construction de alphas ---
    for i = 0:256
    	alphas[i][2]	= bruits[i] / (abs(gains[i])^2 * ptot);
    end

    % On trie alphas pour obtenir A
    [A, I] = sort(alphas);

    %--- Construction de R ---
    i = 1
	while(i <= N && sum <= 1)
		R[i] = 1/A[i+1][2] - A[i][2]

		for j = 1:i
			sum = sum + R[j]
		end
		i = i + 1
	end

	if (i <= N)
		inu = 1

		for j = 1:(i-1) do
			inu = inu + A[j][2]
		end

		for j = 1:(i-1) do
			R[j] = 1/inu - A[j][2]
		end

		for j = i:N do
			R[j] = 0	
		end
	end

	SNR = ptot * R(I) .* abs(gains) .* abs(gains) ./ bruits;

	for i = 1:3
		if (SNR[i] > ber[i])
			alloc[i] = 2^(i + 1)
		end
	end
end
