clc;clear all;

G=[1 0 0 1 1]';%key

M=[1 1 0 1 0 1 1 0 1 1];%input data stream

n=14;% n bits of output data stream

%code after coding CRC
C1=CRC_code(M,n,G);
C2=CRC_code_new(M,n,G);

%code received and indicator
[Recv,Indicator]=CRC_decode_new(C1,n,G);