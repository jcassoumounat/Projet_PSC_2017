function [ output_signal ] = test_channel()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    signal = zeros(1,544);
    for i = 1 : 20
        signal(i) = 1;
    end
    Te = 1/1104000;                  %sample time
    tableau_temps = [1:1:544];       %Size of the number of discret samples
    y = channel(signal);
    plot(tableau_temps*Te, y)
end

