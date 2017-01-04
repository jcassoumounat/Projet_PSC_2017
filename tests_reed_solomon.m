n       =   255;
k       =   8;                          % Codeword and message word lengths
m       =   8;                          % Number of bits per symbol
msg     =   gf([5 2 3; 0 1 7],m)        % Two k-symbol message words
code    =   rsenc(msg,n,k)              % Two n-symbol codewords
 
genpoly =   rsgenpoly(n,k)              % Default generator polynomial
code2   =   rsenc(msg,n,k,genpoly)      % code and code1 are the same codewords
 