%function coding CRC
function C = CRC_code_new(M,n,G)  
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
%t=zeros(n-k+1,1); 
%coding CRC 
t=C1(1:n-k+1,:);% matrix t
for jj=n-k+2:n 
    GG=[]; 
    for ii=1:len2/k 
        GG=[GG,t(1,ii).*G]; 
    end 
    t=mod((t+GG),2); 
    t=[t(2:n-k+1,:);C1(jj,:)]; 
end 
GG=[]; 
for ii=1:len2/k 
    GG=[GG,t(1,ii).*G]; 
end 
t=mod((t+GG),2); 
C1(k+1:n,:)=t(2:n-k+1,:);
C=reshape(C1,1,n*len2/k);
