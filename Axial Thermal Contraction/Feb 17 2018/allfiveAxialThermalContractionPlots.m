
close all
clear all
clc
set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');
       
filename ='Allfiveplots_AxialThermalContraction_absolute T.csv';
num = csvread(filename);

deltaT_1 = num(1:end,1);
Strain_1 = num(1:end,2);
deltaT_2 = num(1:1871,3);
Strain_2 = num(1:1871,4);
deltaT_3 = num(1:2565,5);
Strain_3 = num(1:2565,6);
deltaT_4 = num(1:1660,7);
Strain_4 = num(1:1660,8);
deltaT_5 = num(1:1613,9);
Strain_5 = num(1:1613,10);



 fig = figure('color','white'); hold on; grid on;set(gca,'FontSize',20);
plot(deltaT_1,Strain_1)
hold on
plot(deltaT_2,Strain_2)
hold on
plot(deltaT_3,Strain_3)
hold on
plot(deltaT_4,Strain_4)
hold on
plot(deltaT_5,Strain_5)

legend('First Cycle','Second Cycle','Third Cylce','Fifth Cycle',...
'Sixth Cycle','Location','southwest')
ylabel('Axial Thermal Strain, $$\varepsilon^t_{11}\hspace{1.5mm}(\%)$$')
xlabel('Temperature $$(^{\circ}$$C)')
grid on 
saveas(fig,'Thermal Axial Contraction all cycles','tif')

set(groot, 'Default', struct())   