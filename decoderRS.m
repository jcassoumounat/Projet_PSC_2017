function msg=decoderRS(A,B,m,k)
    
    % input
    % A: an array of bits received
    % B: an array of the sizes of bits by which each integer is converted
    % m: number of bits per symbol
    % k: message length
    % output
    % msg: an array of bits decoded

    n=2^m-1; % codeword length
    l=length(A); % length of the input data
    
    % convert the array of bits into an array of integers by each m bits
    AA=[];
    for i=1:l/m
        T=A((i-1)*m+1:i*m);
        AA=[AA,bi2de(fliplr(T))];
    end
    
    % convert a 1D array into a 2D array with n-elements each line
    for i=1:length(AA)
        C(floor((i-1)/n)+1,mod(i-1,n)+1)=AA(i); 
    end
    
    % decoder Reed-solomon
    C=gf(C,m);
    dec=rsdec(C,n,k);
    dec=dec.x;
    
    [a,b]=size(dec);
    dec=reshape(dec',1,a*b);
    
    % convert integers into bits
    msg=[];
    for i=1:a*b
       msg=[msg,fliplr(de2bi(dec(i),B(i)))]; 
    end
    
end