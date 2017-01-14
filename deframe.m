function [output_data] = deframe(output_frame)
%%
% Returns the data inside the frame :
% - the data from the fast path
% - the data from the interleaving path
% To do so, the first half of the frame is RS decoded while the second is
% deinterleaved then RS decoded.
%gains
% Parameters :
% - Inputs :
%   * output_frame  :   binary vector received
% 
% - Outputs :
%   * output_fast_data        :    binary vector for the data that were 
%                                  inside the fast path half.
%   * output_interleaved_data :    binary vector for the data that were
%                                  inside the interleaving path half.
%%
    L = length(output_frame);
    depth = 3;
    
    output_data = [decoderRS(output_frame(1 : L/2)) decoderRS(deinterleaver(output_frame((L/2)+1 : L), depth))];
    %output_data = [decoderRS(output_frame(1 : L/2)) decoderRS(output_frame((L/2)+1 : L))];
end
