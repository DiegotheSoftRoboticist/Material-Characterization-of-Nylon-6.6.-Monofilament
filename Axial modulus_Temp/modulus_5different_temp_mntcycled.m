 
clear
clc
close all

%Read the file and clasify data in matrices.

filename ='room_temp_lastcycle.csv';
num_amb = csvread(filename);
filename ='temp_45_lastcycle.csv';
num_45 = csvread(filename);
filename ='temp_65_lastcycle.csv';
num_65 = csvread(filename);
filename ='temp_85_lastcycle.csv';
num_85 = csvread(filename);
filename ='temp_105_lastcycle.csv';
num_105 = csvread(filename);

%Room Temperature
stress_amb = - num_amb(1:end,5)/(((0.89^2)*pi)/4)+3.33;
disp_amb =num_amb(1:end,2);
strain_amb = abs((disp_amb(1:1)-disp_amb)/disp_amb(1:1));

%Temperature of 45 degrees celsious 
stress_45 = - num_45(1:end,5)/(((0.89^2)*pi)/4);
disp_45 =num_45(1:end,2);
strain_45 = abs((disp_45(1:1)-disp_45)/disp_45(1:1));

%Temperature of 65 degrees celsious 
stress_65 = - num_65(1:end,5)/(((0.89^2)*pi)/4);
disp_65 =num_65(1:end,2);
strain_65 = abs((disp_65(1:1)-disp_65)/disp_65(1:1));

%Temperature of 85 degrees celsious 
stress_85 = - num_85(1:end,5)/(((0.89^2)*pi)/4);
stress_85 = stress_85-stress_85(1);

disp_85 =num_85(1:end,2);
strain_85 = abs((disp_85(1:1)-disp_85)/disp_85(1:1));
%Checking for moisture
stress_85Mois = - num_85(1:end/2,5)/(((0.89^2)*pi)/4);
stress_85Mois = stress_85Mois-stress_85Mois(1);

disp_85Mois =num_85(1:end/2,2);
strain_85Mois = abs((disp_85Mois(1:1)-disp_85Mois)/disp_85Mois(1:1));

%Temperature of 105 degrees celsious 
stress_105 = - num_105(1:end,5)/(((0.89^2)*pi)/4);
disp_105 =num_105(1:end,2);
strain_105 = abs((disp_105(1:1)-disp_105)/disp_105(1:1));

%fits
p_amb = polyfit(strain_amb,stress_amb,1);
fit_amb = polyval(p_amb,strain_amb);

p_45 = polyfit(strain_45,stress_45,1);
fit_45 = polyval(p_45,strain_45);

p_65 = polyfit(strain_65,stress_65,1);
fit_65 = polyval(p_65,strain_65);

p_85 = polyfit(strain_85,stress_85,1);
fit_85 = polyval(p_85,strain_85);


p_85Mois = polyfit(strain_85Mois,stress_85Mois,1);
fit_85Mois = polyval(p_85Mois,strain_85Mois);


p_105 = polyfit(strain_105,stress_105,1);
fit_105 = polyval(p_105,strain_105);

p_85_Manual = [607, 0]
fit_85_Manual = polyval(p_85,strain_85);

set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');
       
fig1=figure; hold on; grid on; set(gca,'FontSize',20);

p1 = plot(strain_amb*100,stress_amb,'Color',[0.6350, 0.0780, 0.1840],'LineWidth',2); hold on
plot(strain_amb*100,fit_amb,'k','LineWidth', 0.8)

% p2 = plot(strain_45*100,stress_45,'Color',[0.4660, 0.6740, 0.1880],'LineWidth',2); hold on
% plot(strain_45*100,fit_45,'k','LineWidth', 0.8)
% 
% p3 = plot(strain_65*100,stress_65,'Color',[0, 0.4470, 0.7410],'LineWidth',2); hold on
% plot(strain_65*100,fit_65,'k','LineWidth', 0.8)
% 
% p4 = plot(strain_85*100,stress_85,'Color',[0.8500, 0.3250, 0.0980],'LineWidth',2); hold on
% plot(strain_85(200:678)*100,fit_85_Manual(200:678),'k','LineWidth', 0.8)
% 
% % p4Mois = plot(strain_85Mois*100,stress_85Mois,'Color',[0.8500, 0.3250, 0.0980],'LineWidth',2); hold on
% % plot(strain_85Mois*100,fit_85Mois,'k','LineWidth', 0.8)
% % % plot(strain_85*100,5.000e+02*strain_85,'k','LineWidth', 0.8)
% 
% p5 = plot(strain_105*100,stress_105,'Color',[0.6350, 0.0780, 0.1840],'LineWidth',2); hold on
% p6 = plot(strain_105*100,fit_105_Manual,'k','LineWidth', 0.8)


xlabel('Strain ($\%$)')
ylabel('Stress (MPa)')
 legend([p1 p2 p3 p4 p5 p6],{'Room Temperature $$(25^{\circ}$$C)','$$(45^{\circ}$$C)',...
    '$$(65^{\circ}$$C)','$$(85^{\circ}$$C)','$$(105^{\circ}$$C)','Linear Fit'},'Location','Northwest')
xlim([0 1.02])
saveas(fig1,'FinalCycleAxialModulusinaPlot','tif')



% fig2=figure; hold on; grid on; set(gca,'FontSize',14);
% 
% 
% plot(strain_amb,stress_amb,'Color',[0.6350, 0.0780, 0.1840],'LineWidth',2); hold on
% plot(strain_amb,fit_amb,'k','LineWidth', 0.8)
% 
% xlabel('Strain ($\%$)')
% ylabel('Stress (MPa)')
% legend('Room Temperature $$(25^{\circ}C)$$','Linear fit with a slope of 36.03 GPa','Location','Northwest')
% grid on 
% saveas(fig2,'ElasticAxialM_subplots1','tif')
% 
% fig3=figure; hold on; grid on; set(gca,'FontSize',14);
% 
% plot(strain_45,stress_45,'Color',[0.4660, 0.6740, 0.1880],'LineWidth',2); hold on
% plot(strain_45,fit_45,'k','LineWidth', 0.8)
% xlabel('Strain ($\%$)')
% ylabel('Stress (MPa)')
% legend('Temperature of $$(45^{\circ}C)$$','Linear fit with a slope of 18.07 GPa','Location','Northwest')
% grid on 
% saveas(fig3,'ElasticAxialM_subplots2','tif')
% 
% fig4=figure; hold on; grid on; set(gca,'FontSize',14);
% 
% plot(strain_65,stress_65,'Color',[0, 0.4470, 0.7410],'LineWidth',2); hold on
% plot(strain_65,fit_65,'k','LineWidth', 0.8)
% xlabel('Strain ($\%$)')
% ylabel('Stress (MPa)')
% legend('Temperature of $$(65^{\circ}C)$$','Linear fit with a slope of 9.33 GPa','Location','Northwest')
% grid on 
% saveas(fig4,'ElasticAxialM_subplots3','tif')
% 
% fig5=figure; hold on; grid on; set(gca,'FontSize',14);
% 
% plot(strain_85,stress_85,'Color',[0.8500, 0.3250, 0.0980],'LineWidth',2); hold on
% plot(strain_85,fit_85,'k','LineWidth', 0.8)
% xlabel('Strain ($\%$)')
% ylabel('Stress (MPa)')
% legend('Temperature of $$(85^{\circ}C)$$','Linear fit with a slope of 6.79 GPa','Location','Northwest')
% grid on 
% saveas(fig5,'ElasticAxialM_subplots4','tif')
% 
% fig6=figure; hold on; grid on; set(gca,'FontSize',14);
% 
% plot(strain_105,stress_105,'Color',[0.9, 0.9, 0.25],'LineWidth',2); hold on
% plot(strain_105,fit_105,'k','LineWidth', 0.8)
% xlabel('Strain ($\%$)')
% ylabel('Stress (MPa)')
% legend('Temperature of $$(105^{\circ}C)$$','Linear fit with a slope of 5.58 GPa','Location','Northwest')
% grid on 
% 
% saveas(fig6,'ElasticAxialM_subplots5','tif')

% fig7=figure; hold on; grid on; set(gca,'FontSize',20);
% 
%  E_temp = [3.80026,1.8617,0.85695,0.60709,0.50403]
%  temp_E = [25,45,65,85,105]
% p_axial = polyfit(temp_E,E_temp,3);
% T_new = (25:1:105);
% E_approx = polyval(p_axial,T_new);
% 
%  plot(temp_E,E_temp,'b o','Color',[0.7500, 0.4250, 0.2980],'LineWidth',2); hold on
%  plot(T_new,E_approx,'k','LineWidth', 1); 
% xlabel('Temperature $$(^{\circ}$$C)')
% ylabel('$E_1$ (GPa)')
% legend('Experimental Data','Curve Fit')
%  text(46,3.1,'$-8.2\times10^{-6}  T^3 + 0.003 T^2 - 0.24 T + 8.31$','FontSize',20) 
% saveas(fig7,'ElasticAxialModulus','tif')

fig7=figure; hold on; grid on; set(gca,'FontSize',20);

E_temp = [p_amb(1)/1000,p_45(1)/1000,p_65(1)/1000,p_85(1)/1000,p_105(1)/1000]
temp_E = [25,45,65,85,105]
p_axial = polyfit(temp_E,E_temp,3);
T_new = (25:1:105);
E_approx = polyval(p_axial,T_new);
E_1 = (-8.19802*10^-6)*T_new.^3+(0.0023889)*T_new.^2-0.234739*T_new+8.30988;

 plot(temp_E,E_temp,'b o','Color',[0.7500, 0.4250, 0.2980],'LineWidth',2); hold on
 plot(T_new,E_approx,'k','LineWidth', 1); 
  plot(T_new,E_1,'k','LineWidth', 1); 

xlabel('Temperature $$(^{\circ}$$C)')
ylabel('$E_1$ (GPa)')
legend('Experimental Data','Curve Fit')
%  text(46,3.1,'$-8.2\times10^{-6}  T^3 + 0.003 T^2 - 0.24 T + 8.31$','FontSize',20) 
saveas(fig7,'ElasticAxialModulus','tif')


set(groot, 'Default', struct()) 
% 
% saveas(fig1,'fig1','tif')
% saveas(fig2,'fig2','tif')

Answer_5digit= (-8.19802*10^-6)*85^3+(0.0023889)*85^2-0.234739*85+8.30988;
Answer_2digit= (-8.19*10^-6)*80^3+(0.0024)*80^2-0.2347*80+8.31
