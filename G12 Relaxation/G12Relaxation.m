
clc
close all
clear all
set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');

figure; hold on; grid on; set(gca,'FontSize',14);
figure; hold on; grid on; set(gca,'FontSize',20);

% Sample diameter and polar moment of inertia
D = 0.89/10^3; % m
J = pi*D^4/32; % m^4

% Retrieve Data
filename = 'G12Relaxation_Test1_May23';
for i = 1:9 % rheometer steps (sheets)
    sheet = i+1; %strcat({'Stress relaxation - '},num2str(i));
    data = xlsread(filename,sheet,'A:E');
        time = data(80:end,1);
        torque = data(80:end,2)/10^6; % N-m
        theta = data(80:end,3); % rad
        F = data(80:end,4); % N
        L = data(80:end,5)/10^6; % m

    % Shear Modulus
    G = torque.*L./(J*theta);
    
    % Plot data for all cycles
    figure(1)
    yyaxis left
        plot(time/60, torque*10^3, '-')
    yyaxis right
        plot(time/60, theta, '-')
    
    % Plot overlapping loading cycles
    figure(2)
    if mod(i,2) == 1 % Loading cycle
        h(i)=plot((time-time(1))/60, G/10^6);
        set(h(i),'linewidth',2);

    end
end

% Labels
figure(1)
    yyaxis left; ylabel('Torque (N-mm)'); ylim([-3 5])
    yyaxis right; ylabel('$\theta$ (rad)');
    xlabel('Time (min)');
fig2 = figure(2)
    xlabel('Time (min)'); ylabel('$G_{12}$ (MPa)'); 
    ylim([250 450])
legend('First Cycle','Second Cycle','Third Cycle','Fourth Cycle','Fifth Cycle')
saveas(fig2,'Shear Modulus Relaxation 1','tif')
    
set(groot, 'Default', struct())   

