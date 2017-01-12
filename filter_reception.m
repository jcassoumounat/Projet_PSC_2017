function [vec, A] = filter_reception(H)

%% Parameters %%
% - Inputs :
%   * H : Impulsional response
%   * Y : bits after the canal
%
% - Outputs :
%   * X : bits after the filter

numA = 5;
A = zeros(numA,numA);
vec = [H  zeros(1,numA-numel(H))];
for i=0:size(A,1)
    A(i+1,:) = circshift(vec,[1 i]);
end

%X = filter(inv(H),1,Y);


end

