function [bit_vector_full] = test_bit_vector(vector_size)
%Make a test bit vector.
%   Coordinates are equal to their index, easier to see resluts for tests

for i = 1:vector_size
    bit_vector_full(i)=i; 
end

end

