%function coding CRC
function C = CRC_code(M,n,G) 
%Input: 
%   M:(1,k) input data
%   n: number bits of output data
%   G:(1,n-k+1) generating polynomial 
%Output: 
%   C:(1,n) coded CRC data; 
len1=length(G); 
k=n-len1+1; 
len2=length(M); 
M1=reshape(M,k,len2/k); 
C1=zeros(n,len2/k); 
C1(1:k,:)=M1; 
t=zeros(n-k+1,1); 
%coding CRC
for ii=1:len2/k 
    t=C1(1:n-k+1,ii);%vector t
    for jj=n-k+2:n 
        if(t(1))
           t=mod((t+G),2); 
        end 
        t=[t(2:n-k+1);C1(jj,ii)]; 
    end 
    if(1==t(1)) 
        t=mod((t+G),2); 
    end 
    C1(k+1:n,ii)=t(2:n-k+1);
end 
C=reshape(C1,1,n*len2/k);