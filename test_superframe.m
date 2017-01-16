%% emission %%
script_allocation;
data_to_send = [];
nb_superframe    = 2;
Nt = sum(log2(alloc));
nb_frames_in_one_superframe = 68;
data_size        = nb_superframe *(nb_frames_in_one_superframe * (Nt - 32 - 2) - 8) %32 = FEC * 2 and 8 = CRC_size and 2 = nb of bits on the first channel
input_data       = random_digital_signal(data_size, 0.5);
temp = input_data;
nb_error_frame_fast = 1;
nb_error_frame_interl = 1;
wrong_superframe1 = [];

while ~isequal(temp, [])
    [superframe1, remain1] = superframe(temp, alloc);
    
    %% add error %%
    for frame_nb = 1 : nb_frames_in_one_superframe  
        frame_i = superframe1((frame_nb-1)*Nt + 1 : frame_nb*Nt);
        wrong_superframe1 = [wrong_superframe1 error_frame(frame_i, nb_error_frame_fast, nb_error_frame_interl)];
    end
    data_to_send = [data_to_send wrong_superframe1];
    wrong_superframe1 = [];
    temp = remain1;
end



%% reception %%
output_data = [];
while ~isequal(data_to_send, [])
    [desuperframe1, err, remain2] = desuperframe(data_to_send, alloc);
    err
    output_data = [output_data desuperframe1];
    data_to_send = remain2;
end

equal = isequal(input_data, output_data)



%index_error = [];
% if dsf_size == data_size
%     for i = 1 : data_size
%         dif = input_data(i) - desuperframe1(i);
%         if dif == 1
%             index_error = [index_error i];
%         end
%     end
%     index_error
% else
%     WARNING = 'data length of input data is diff from output data'
% end