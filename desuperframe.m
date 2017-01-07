function [frame0, frame1, frame34, frame35, decoded_superframe] = desuperframe (superframe_vector)
%get data from an ADSL superframe
%   frame0 : 1st byte of the frame containing info about transmission -> SIZE = 8 bits
%   frame1 : 2nd byte of the frame containing info about transmission -> SIZE = 8 bits
%   frame34 : 34th frame containig info on the channel -> SIZE = 8 bits
%   frame35 : 35th frame containig info on the channel -> SIZE = 8 bits
%   frame : decoded data 
%
%   superframe : vector of bits we want to decode

INFO_FRAME_SIZE = 8; %size of frame0,1,34,35
NB_FRAMES_SUPERFRAME = 68; %do not count the last one for the desuperframe
FEC_SIZE = 8;
superframe_size = size(superframe_vector,2);
coded_data_size = superframe_size - 4*INFO_FRAME_SIZE; %4 info frames
frame_size = coded_data_size / (NB_FRAMES_SUPERFRAME-4); %4 info frames

decoded_superframe=[];

%frame0
for j = 1 : INFO_FRAME_SIZE
    frame0(j) = superframe_vector(j);
end

%frame1
for j = 1 : INFO_FRAME_SIZE
    frame1(j) = superframe_vector(j + INFO_FRAME_SIZE);
end

%frame 2 to 33
nb_treated_frames = 0;
for i = 1 : 32
    for j = 1 : frame_size
        temp_frame(j) = superframe_vector(2*INFO_FRAME_SIZE+nb_treated_frames*frame_size + j);
    end
    decoded_superframe = [decoded_superframe deframe(temp_frame, FEC_SIZE)];
    nb_treated_frames = nb_treated_frames + 1; 
end

%frame34
for j = 1 : INFO_FRAME_SIZE
    frame34(j) = superframe_vector(2*INFO_FRAME_SIZE+nb_treated_frames*frame_size + j);
end

%frame35
for i = j : INFO_FRAME_SIZE
    frame35(j) = superframe_vector(2*INFO_FRAME_SIZE+nb_treated_frames*frame_size + INFO_FRAME_SIZE  + j);
end

%frame 36 to 68
for i = 1 : 32
    for j = 1 : frame_size
        temp_frame(j) = superframe_vector(4*INFO_FRAME_SIZE+nb_treated_frames*frame_size + j);
    end
    decoded_superframe = [decoded_superframe deframe(temp_frame, FEC_SIZE)];
    nb_treated_frames = nb_treated_frames + 1; 
end