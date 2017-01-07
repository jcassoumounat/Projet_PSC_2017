function output=encoderRS(A,B,m,k)
    
    % input
    % A: an array of bits
    % B: an array of the sizes of bits by which each integer is converted
    %    the length of B must be an integer multiple of k
    %    the maximum of B must equal or be smaller than m
    % m: number of bits per symbol
    % k: message length
    % output
    % output: an array of bits encoded
    
    C=convB2I(A,B); % convert A to an array of integers
    l=length(C); % the length of data for encoding
    n=2^m-1; % codeword length
    
    % convert a 1D array into a 2D array with k-elements each line
    for i=1:l
        t(floor((i-1)/k)+1,mod(i-1,k)+1)=C(i);
    end
    
    % encoder Reed-Solomon
    msg=gf(t,m);
    enc=rsenc(msg,n,k); 
    
    % convert a Golois Field into an array of integers
    [a,b]=size(enc);
    enc=reshape(enc',1,a*b); 
    enc=enc.x;
    
    % convert integers into bits
    output=[];
    for i=1:a*b
       output=[output,fliplr(de2bi(enc(i),m))]; 
    end
    
    
end
