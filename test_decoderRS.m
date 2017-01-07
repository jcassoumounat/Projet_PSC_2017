A=[1 0 0 1 1 0 0 0 1 0 0 0 1];
B=[3 3 2 1 2 2];
m=3;
k=3;
enc=encoderRS(A,B,m,k);
msg=decoderRS(enc,B,m,k);
disp(msg);