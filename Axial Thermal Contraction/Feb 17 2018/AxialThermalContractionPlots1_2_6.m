
close all
clear all
clc

% We read five cycles over a total of 6, but remember that we couldnt
% record the number 5th
filename ='Allfiveplots_AxialThermalContraction_absolute T.csv';
num = csvread(filename);

deltaT_1 = num(1:end,1);
T_1 = deltaT_1; % Absolute temperature = delata plus initial temp. 
Strain_1 = num(1:end,2);
deltaT_2 = num(1:end,3);
T_2 = deltaT_2;
Strain_2 = num(1:end,4);
deltaT_6 = num(1:1450,9);
T_6 = deltaT_6;
Strain_6 = num(1:1450,10);

%We plot in LaTex format the cycle 1,2 and 6.

set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');


fig=figure; hold on; grid on; set(gca,'FontSize',20);
p = polyfit(T_6,Strain_6,3);
%p1 = [-9.90121482988430e-07,0.000109014878177862,-0.00396374022027449,0]
fit = polyval(p,T_6);

fit_epsilon_paper = (-0.0091*(T_6.^3 - T_6(1)^3) + 0.954*(T_6.^2 - T_6(1)^2)- 32.1*(T_6 - T_6(1))) * 10^-4 

plot(T_6,Strain_6,'LineWidth',2);hold on

% plot(T_6,fit,'LineWidth',1,'Color',[0,0,0]);hold on

plot(T_6(1:5:737),fit_epsilon_paper(1:5:737),'k --','LineWidth',1)

legend('Sixth Cycle','Curve fit','Location','southwest')
ylabel('Axial Thermal Strain, $$\varepsilon^t_{11}\hspace{1.5mm}(\%)$$')
xlabel('Temperature ($$^{\circ}$$C)')
saveas(fig,'Thermal Axial Contraction for thesis','tif')

%ALPHA
fig1=figure; hold on; grid on; set(gca,'FontSize',20);
alpha = (-0.0273*(T_6.^2 - T_6(1)^2)+1.91*(T_6 - T_6(1))-32.1) * 10^-4 

plot(T_6,alpha,'LineWidth',3);hold on

% plot(T_6,fit,'LineWidth',1,'Color',[0,0,0]);hold on

ylabel('Axial Thermal Strain Coefficient, $$\alpha^t_{11}\hspace{1.5mm}$$')
xlabel('Temperature ($$^{\circ}$$C)')
ylim([-0.016 0])
xlim([20 110])
set(groot, 'Default', struct())

ExcelData1 = [T_6 Strain_6]

filename = 'Axial thermal contraction.xlsx'
  xlswrite(filename,ExcelData1)
