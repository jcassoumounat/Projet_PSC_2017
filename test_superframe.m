%% emission %%
script_allocation;
data_to_send = [];
nb_superframe    = 2;

data_size        = nb_superframe *(68 * (sum(log2(alloc)) - 32)) %32 = FEC * 2
input_data       = random_digital_signal(data_size, 0.5);
temp = input_data;

while ~isequal(temp, [])
    [superframe1, remain1] = superframe(temp, alloc);
    data_to_send = [data_to_send superframe1];
    temp = remain1;
end

%% reception %%
output_data = [];
while ~isequal(data_to_send, [])
    [desuperframe1, remain2] = desuperframe(data_to_send, alloc);
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