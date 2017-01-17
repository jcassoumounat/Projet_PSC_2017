function [ output_signal ] = test_channel(ech)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    signal = zeros(1,544);
%     for i= 1 : 9
%         signal(i) = 1;
%     end
%     for i= 10 : 544
%         signal(i) = signal(i-4) + signal(i-9);
%         if (signal(i) >= 2)
%             signal(i) = 0;
%         end
%     end
    for i = 1 : ech
        signal(i) = 1;
    end
    Te = 1/1104000;                  %sample time
    tableau_temps = [1:1:544];       %Size of the number of discret samples
    y = channel(signal);
    plot(tableau_temps*Te, y)
end

