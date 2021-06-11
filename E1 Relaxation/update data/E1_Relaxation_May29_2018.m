
clc
close all
clear all
set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');

figure; hold on; grid on; set(gca,'FontSize',20);

% Sample diameter and area
D = 0.89; % mm
Area = (pi*D^2)/4; %mm^2

% Retrieve Data


filename = 'E1_Relaxation_Test2_May29_2018';
for i = 2:2:40 % rheometer steps (sheets)
    sheet = i; %strcat({'Stress relaxation - '},num2str(i));
    data = xlsread(filename,sheet,'A:F');
        time = data(:,3);
        F = abs(data(:,5)); % N
        L = data(:,6)*10^-3; % mm

    % Shear Modulus
    Stress = F/Area;
    Strain = ((L-19.450)/19.450);
    E =Stress./Strain;
    
    % Plot data for all cycles
%     figure(1)
%     yyaxis left
%         plot(time/60, torque*10^3, '-')
%     yyaxis right
%         plot(time/60, theta, '-')
%     
    % Plot overlapping loading cycles
    figure(1)
        h(i)=plot(time/60, E*10^-3);
       set(h(i),'linewidth',1.6); 
%     figure(2)
%         yyaxis left;
%     H1 = plot(time/60,Strain)
%     ylabel('$\varepsilon(\%)$')
%     
%         yyaxis right;
%     H2 = plot(time/60,Stress)
%     ylabel('$\sigma (MPa)$')
%     xlabel('Time (min)')

end


% Labels
% figure(1)
%     yyaxis left; ylabel('Torque (N-mm)'); ylim([-3 5])
%     yyaxis right; ylabel('$\theta$ (rad)');
%     xlabel('Time (min)');

fig1 = figure(1)
    xlabel('Time (min)'); ylabel('$E_1$ (GPa)'); 
%     ylim([270 450])
 xlim([0.05 2])

%     legend(strcat({'Ramp'},{' '},num2str((1:i/2)')));
% saveas(fig2,'Shear Modulus Relaxation 2','tif')
 
figure; hold on; grid on; set(gca,'FontSize',20);
plot(time/60, E*10^-3,'linewidth',1.6);
xlabel('Time (min)'); ylabel('$E_1$ (GPa)'); 




