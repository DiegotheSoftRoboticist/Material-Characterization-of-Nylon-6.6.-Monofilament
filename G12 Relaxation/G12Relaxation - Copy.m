% G12 Relaxation calcs
% Amy Swartz 5/24/18

clc
close all
clear all
set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');

figure; hold on; grid on; set(gca,'FontSize',14);
figure; hold on; grid on; set(gca,'FontSize',14);

% Sample diameter and polar moment of inertia
D = 0.89/10^3; % m
J = pi*D^4/32; % m^4

% Retrieve Data
filename = 'G12Relaxation_Test1_May23';
for i = 1:10 % rheometer steps (sheets)
    sheet = i+1; %strcat({'Stress relaxation - '},num2str(i));
    data = xlsread(filename,sheet,'A:E');
        time = data(80:end,1);
        torque = data(80:end,2)/10^6; % N-m
        theta = data(80:end,3); % rad
        F = data(80:end,4); % N
        L = data(80:end,5)/10^6; % m

    % Shear Modulus
    G = abs(torque).*L./(J*abs(theta));
    
    % Plot data for all cycles
%     figure(1)
%     yyaxis left
%         plot(time/60, torque*10^3, '-')
%     yyaxis right
%         plot(time/60, theta, '-')
%     
    % Plot overlapping loading cycles
    figure(2)
    if mod(i,2) == 1 % Loading cycle
        plot((time-time(1))/60, G/10^6,'r.');
    end
end

filename = 'G12Relaxation_Test2_May25';
for i = 1:39 % rheometer steps (sheets)
    sheet = i+1; %strcat({'Stress relaxation - '},num2str(i));
    data2 = xlsread(filename,sheet,'A:F');
        time2 = data2(80:end,3);
        torque2 = data2(80:end,1)/10^6; % N-m
        theta2 = data2(80:end,2); % rad
        F2 = data2(80:end,5); % N
        L2 = data2(80:end,6)/10^6; % m

    % Shear Modulus
    G2 = abs(torque2).*L2./(J*abs(theta2));
    
    % Plot data for all cycles
%     figure(1)
%     yyaxis left
%         plot(time/60, torque*10^3, '-')
%     yyaxis right
%         plot(time/60, theta, '-')
%     
    % Plot overlapping loading cycles
    figure(2)
    
        plot(time2/60, G2/10^6);
    
end


% Labels
% figure(1)
%     yyaxis left; ylabel('Torque (N-mm)'); ylim([-3 5])
%     yyaxis right; ylabel('$\theta$ (rad)');
%     xlabel('Time (min)');
fig2 = figure(2)
    xlabel('Time (min)'); ylabel('$G_{12}$ (MPa)'); 
      ylim([200 450])
      xlim([0 2])
%     legend(strcat({'Ramp'},{' '},num2str((1:i/2)')));
% saveas(fig2,'Shear Modulus Relaxation 2','tif')
 

