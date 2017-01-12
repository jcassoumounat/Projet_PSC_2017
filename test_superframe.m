allocation_table = [8 8 16 16 4 4 8 4 16 4 16 2 8 4 4 16 4]
nb_superframe    = 1;
data_size        = nb_superframe *( 68 * sum(log2(allocation_table))) 
input_data       = random_digital_signal(data_size, 0.5);
[superframe1 remain] = superframe(input_data, allocation_table);