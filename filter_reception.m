function [X] = filter_reception(H,Y)

%% Parameters %%
% - Inputs :
%   * H : Impulsional response
%   * Y : bits after the canal
%
% - Outputs :
%   * X : bits after the filter

X = filter(inv(H),1,Y);


end

