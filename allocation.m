function alloc=allocation(ber, gains, bruits, ptot)
    
    alloc 		= zeros([256, 1]);	% Vecteur contenant le type de modulation qu'il faudra appliquer pour chaque sous-canal
    alphas 		= zeros([256, 1]);	% Vecteur des rapports bruit à canal
    R			= ones([256, 1]);	% Vecteur des pourcentages de la puissance totale
    
    %--- Construction de alphas ---
    % for i = 1:256
    % 	alphas(i)	= bruits(i) / (abs(gains(i))^2 * ptot);
    % end
    alphas = bruits ./ (ptot * abs(gains) .* abs(gains));
    % On trie alphas pour obtenir A et I, le tableau des index qu'on utilisera ensuite pour réordonner les sous-canaux.
    [A, I] = sort(alphas);

    %--- Construction de R ---
    i = 1;
    alpha_sum = 0;
	while(i <= 255 && alpha_sum <= 1)
		R(i) = 1/A(i+1) - A(i);

		for j = 1:i
			alpha_sum = alpha_sum + R(j);
		end
		i = i + 1;
	end

	if (i <= 256)
		inu = 1;

		for j = 1:(i-1)
			inu = inu + A(j);
		end

		for j = 1:(i-1)
			R(j) = 1/inu - A(j);
		end

		for j = i:256
			R(j) = 0;
		end
	end

	% On récupère le vecteur des SNR dont le i-ème élément correspond au i-ème sous-canal.
	SNR = ptot * R(I) .* abs(gains) .* abs(gains) ./ bruits;

	% On associe le type de modulation correspondant à chaque sous-canal.
	for i = 1:256
		for j = 1:3
			if (SNR(i) > ber(j))
				alloc(i) = 2^(j + 1);
			end
		end
	end

	% Si jamais il n'est pas possible de trouver un seuil correspondant, alors on met la modulation la plus basse possible en ADSL ie une 4-QAM.
	for i = 1:256
		if (alloc(i) == 0)
			alloc(i) = 4;
		end
	end
end
