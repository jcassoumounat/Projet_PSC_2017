function C=convB2I(A,B)
    
    % input
    % A: an array of bits
    % B: an array of the sizes of bits by which each integer is converted
    % output
    % C: an array of integers converted
    
    S=sum(B);
    L=length(A);
    
    if (S==L) % if the sum of B equals the length of A
        j=1; % indice for traversing A
        for i=1:length(B)
            T=A(j:j+B(i)-1);
            T=fliplr(T);
            C(i)=bi2de(T);
            j=j+B(i);
        end
    end
end