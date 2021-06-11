clear all
clc
close all

set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');
       
fig7=figure; hold on; grid on; set(gca,'FontSize',20);

 E2_temp = [0.77,0.38,0.17,0.12,0.1]
 temp_E2 = [25,45,65,85,105]
p_axial = polyfit(temp_E2,E2_temp,3);
T_new = (25:1:105);
E_approx = polyval(p_axial,T_new);

 plot(temp_E2,E2_temp,'b o','Color',[0.7500, 0.4250, 0.2980],'LineWidth',2); hold on
 plot(T_new,E_approx,'k','LineWidth', 1); 
xlabel('Temperature $$(^{\circ}$$C)')
ylabel('$E_2$ (GPa)')
legend('Experimental Data','Curve Fit')
%  text(35,0.6,'$-1.56\times10^{-6}  T^3 + -4.65\times10^{-4} T^2 - 0.05 T + 1.67$','FontSize',20) 
saveas(fig7,'ElasticAxialModulus','tif')

set(groot, 'Default', struct()) 