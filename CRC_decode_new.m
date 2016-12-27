%function decoding CRC without corrector
function [DataRecv,indicate]= CRC_decode_new(C,n,G) 
%Input: 
%   C:(1,k) data received
%   n: number bits of output data
%   G:(1,n-k+1) generating polynomial  
%Output: 
%   DataRecv:(1,k) coded data; 
%   indicate: CRC indicator,0:correct,>=1:error; 
len1=length(G); 
k=n-len1+1; 
len2=length(C); 
M=reshape(C,n,len2/n); 
DataRecv=reshape(M(1:k,:),1,k*len2/n); 
indicate=zeros(1,len2/n); 
 
%decoding CRC 
t=M(1:n-k+1,:);%matrix t
GG=[]; 
for ii=1:len2/n 
    GG=[GG,t(1,ii).*G]; 
end 
    t=mod((t+GG),2); 
for jj=n-k+2:n 
    GG=[]; 
    t=[t(2:n-k+1,:);M(jj,:)]; 
    for ii=1:len2/n 
        GG=[GG,t(1,ii).*G]; 
    end 
    t=mod((t+GG),2); 
end 
indicate=sum(t); 
