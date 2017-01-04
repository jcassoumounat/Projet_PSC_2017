function [] = DMT(N,v,h1)
%N = No. of sub-channels
%v = Cyclic prefix length
%h1 = channel impulse response
h=[1];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Bit Allocation and data generation %%%%%%%%%%%%%%

for i=1:N-1,
    %A REVOIR AVEC LE BIT SWAPPING DE LELIO
    bit_channel(i)=ceil(rand*15);
end

% Data assignment in each channel
for i=1:N-1
    data_channel=[];
    for j=1:bit_channel(i),
        val=round(rand);
        data_channel=[data_channel val]
    end
    data{i}=data_channel;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% CONSTELLATION ENCODING %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:N-1
    type_QAM_bits_allocation(i) = ?
    complex_symbol = modulationQAM(data, bit_channel(i), type_QAM_bits_allocation(i));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Calcuate the IFFT of the encoded complex symbol%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x_mod = ifft([1 complex_symbol 1 fliplr(conj(complex_symbol))], 2*N);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define a cyclic prefix length and add the cyclic prefix to the serailized %%
%%%%%%%%%%%%%%%%%%%%%   data stream   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = [x_mod(2*N+1-v:2*N) x_mod];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% Transmission across the channel %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% Convolution with the channel impulse response.%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y=conv(x,h); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Receiver Side %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y_mod = y(v+1:2*N+v); % remove cyclic prefix

% Due to the cyclic prefix the convolution is translated to a circular convolution
% and hence the encoded complex symbol with its conjugate is received after FFT demodulation

x_recd = fft(y_mod)./fft(h,2*N);

% removing the conjugate parts
complex_recd_symbol=x_recd(2:N);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% DECODER %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:N-1,
    i_comp(i)=real(complex_recd_symbol(i));
    q_comp(i)=imag(complex_recd_symbol(i));
    %Calculate the intersymbol spacing (based on a transmit
    % symbol energy of 1).
    d = sqrt (6/((2^bit_channel(i))-1));
    
    % The number of bits sent to the top and bottom DACs
    l_top = ceil(bit_channel(i)/2);
    l_bot = floor(bit_channel(i)/2);
    
    d_top = i_comp(i);
    d_bot = q_comp(i);
    
    v_top = round((d_top/d)+((2.^l_top-1)/2));
    v_bot = round((d_bot/d)+((2.^l_bot-1)/2));
    
    b_top = [];
    for j=(1:l_top)
        b_top = [b_top, rem(v_top,2)];
        v_top = floor(v_top/2);
    end
    
    b_bot = [];
    for j=(1:l_bot)
        b_bot = [b_bot, rem(v_bot, 2)];
        v_bot = floor(v_bot/2);
    end
    
    data_recd{i}=[b_top, b_bot];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% ERROR Calculations %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

err=(complex_recd_symbol-complex_symbol);
figure,subplot(2,1,1),stem(real(err));
title('Real part of the error signal')
%figure,
subplot(2,1,2),stem(imag(err));
title('Imaginary part of the error signal')
xlabel('Channel number')

bit_err=[data_recd{1,:}]-[data{1,:}];
figure,stem(bit_err)
title('Bit error')
xlabel('Samples')
end

