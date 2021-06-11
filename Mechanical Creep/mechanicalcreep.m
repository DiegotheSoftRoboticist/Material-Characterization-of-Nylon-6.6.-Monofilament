
close all
clear all
clc

filename ='mechanical creep.csv';
num = csvread(filename);

time = num(1:end,1);
Disp = num(1:end,2);
Ten = -num(1:end,3);

A = 0.622114; % mm^2

Stress = (Ten/A); % MPa
Mec_Strain =(((Disp-Disp(1,:))/Disp(1,:))*10^6)/10000; % (%


% fig3 = figure('color','w');
% [AX1,H1,H2] = plotyy(time,Mec_Strain,time,Stress); hold on
% xlabel(AX1(1),'Time [s]')
% ylabel(AX1(2),'Axial Stress \fontsize{15} \sigma{\fontsize{5} 11}^{\fontsize{7} t} \fontsize{10}(MPa)')
% ylabel(AX1(1),'Mechanical Strain, \fontsize{15} \epsilon_{\fontsize{5} 11}^{\fontsize{7} t} \fontsize{10} (%)')
% grid on 
% saveas(fig3,'plot 12','tif')

%Plots
set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');

%% Get all your variables and stuff here

fig=figure; hold on; grid on; set(gca,'FontSize',14);

left_color = [.5 .5 0];
right_color = [0 0 0];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);
[AX1,H1,H2] = plotyy(time/60,Mec_Strain,time/60,Stress); hold on
set(H2,'LineStyle','--');

xlabel(AX1(1),'Time (min)','FontSize',14)
ylabel(AX1(1),'Strain $$(\%)$$','FontSize',14)
ylabel(AX1(2),'Axial Stress $$\sigma_{11}^1 (MPa)$$','FontSize',14)
legend('Strain','Axial Stress Step Function','Location','southwest') 
saveas(fig,'Mechanical Creep','tif')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  set(groot, 'Default', struct())