 
clear all
close all
clc
% close all

%Read the file and clasify data in matrices.

filename ='temp_amb_rig_mod1.csv';
num_amb = csvread(filename);
filename ='temp_45_rig_mod1.csv';
num_45 = csvread(filename);
filename ='temp_65_rig_mod1.csv';
num_65 = csvread(filename);
filename ='temp_85_rig_mod1.csv';
num_85 = csvread(filename);
filename ='temp_105_rig_mod1.csv';
num_105 = csvread(filename);

%%%%%%%%%%Torque and displacement%%%%
torque_amb = num_amb(1:2,2)*0.001;
torque_45 = num_45(1:2,2)*0.001;
torque_65 = num_65(1:2,2)*0.001;
torque_85 = num_85(1:2,2)*0.001;
torque_105 = num_45(1:2,2)*0.001;

rad_amb = num_amb(1:2,1)-num_amb(1,1);
rad_45 = num_45(1:2,1)-num_45(1,1);
rad_65 = num_65(1:2,1)-num_65(1,1);
rad_85 = num_85(1:2,1)-num_85(1,1);
rad_105 = num_105(1:2,1)-num_105(1,1);

Axial_amb = num_amb(1:2,3);
Axial_45 = num_45(1:2,3);
Axial_65 = num_65(1:2,3);
Axial_85 = num_85(1:2,3);
Axial_105 = num_105(1:2,3);

%parameters
J = pi*0.89^4/32;
E_amb = 3.8003; E_45 = 1.8617; E_65 = 0.8569; E_85 = 0.6071; E_105 = .5040; % GPa
Lo_amb= 41.587; Lo_45 = 33.34; Lo_65 = 32.24; Lo_85 = 32.18; Lo_105 = 32.41; %mm
A= 0.62211; %mm^2

%Room Temperature
disp_amb =num_amb(1:end,2);
Lf_amb = Lo_amb+(Axial_amb.*Lo_amb/(A*E_amb*1000)); % mm
G_amb_num = (torque_amb.*Lf_amb); 
G_amb_den = (J*rad_amb);
G_amb = G_amb_num./G_amb_den;

G_amb_av = median(G_amb)

% %Temperature of 45 degrees celsious 
disp_45 =num_45(1:end,2);
Lf_45 = Lo_45+(Axial_45.*Lo_45/(A*E_45*1000));
G_45_num = (torque_45.*Lf_45);
G_45_den = (J*rad_45);
G_45 = G_45_num./G_45_den;

G_45_av = median(G_45)

% %Temperature of 65 degrees celsious

disp_65 =num_65(1:end,2);
Lf_65 = Lo_65+(Axial_65.*Lo_65/(A*E_65*1000)); % mm
G_65_num = (torque_65.*Lf_65); 
G_65_den = (J*rad_65);
G_65 = G_65_num./G_65_den;

G_65_av = median(G_65)

% % % %Temperature of 85 degrees celsious 
disp_85 =num_85(1:end,2);
Lf_85 = Lo_85+(Axial_85.*Lo_85/(A*E_85*1000)); % mm
G_85_num = (torque_85.*Lf_85); 
G_85_den = (J*rad_85);
G_85 = G_85_num./G_85_den;

G_85_av = median(G_85)

% % %Temperature of 105 degrees celsious 
disp_105 =num_105(1:end,2);
Lf_105 = Lo_105+(Axial_105.*Lo_105/(A*E_105*1000)); % mm
G_105_num = (torque_105.*Lf_105); 
G_105_den = (J*rad_105);
G_105 = G_105_num./G_105_den;

G_105_av = median(G_105)


G = [G_amb_av,G_45_av,G_65_av,G_85_av,G_105_av];
T = [25,45,65,85,105];
p_shear = polyfit(T,G,3);
T_new = (25:1:105);
G_approx = polyval(p_shear,T_new);



%'StartPoint',[1,2]

%fits
p_amb = polyfit(rad_amb,torque_amb,1);
fit_amb = polyval(p_amb,rad_amb);

p_45 = polyfit(rad_45,torque_45,1);
fit_45 = polyval(p_45,rad_45);

p_65 = polyfit(rad_65,torque_65,1);
fit_65 = polyval(p_65,rad_65);

p_85 = polyfit(rad_85,torque_85,1);
fit_85 = polyval(p_85,rad_85);

p_105 = polyfit(rad_105,torque_105,1);
fit_105 = polyval(p_105,rad_105);

set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');
       
fig1=figure; hold on; grid on; set(gca,'FontSize',20);

p1 = plot(rad_amb,torque_amb,'Color',[0.6350, 0.0780, 0.1840],'LineWidth',2); hold on
plot(rad_amb,fit_amb,'k','LineWidth', 0.8)

p2 = plot(rad_45,torque_45,'Color',[0.4660, 0.6740, 0.1880],'LineWidth',2); hold on
plot(rad_45,fit_45,'k','LineWidth', 0.8)

p3 = plot(rad_65,torque_65,'Color',[0, 0.4470, 0.7410],'LineWidth',2); hold on
plot(rad_65,fit_65,'k','LineWidth', 0.8)

p4 = plot(rad_85,torque_85,'Color',[0.8500, 0.3250, 0.0980],'LineWidth',2); hold on
plot(rad_85,fit_85,'k','LineWidth', 0.8)

p5 = plot(rad_105,torque_105,'Color',[0.9, 0.9, 0.25],'LineWidth',2); hold on
p6 = plot(rad_105,fit_105,'k','LineWidth', 0.8)

xlabel('Angular Displacement (rad)')
ylabel('Torque (N mm)')
legend([p1 p2 p3 p4 p5 p6],{'Room Temperature $$(25^{\circ}$$C)','$$(45^{\circ}$$C)','$$(65^{\circ}$$C)'...
    ,'$$(85^{\circ}$$C)','$$(105^{\circ}$$C)','Linear Fit'},'Location','Southeast')



fig11 = figure; hold on; grid on; set(gca,'FontSize',20);

plot(T,G,'b o','Color',[0.7500, 0.4250, 0.2980],'LineWidth',2); hold on
plot(T_new,G_approx,'k','LineWidth', 1)
ylabel('$G_{12}$ (MPa)')
xlabel('Temperature $$(^{\circ}$$C)')
legend('Experimental Data','Curve Fit')

% text(46,400,'$-0.00017 T^3 + 0.109 T^2 - 16.56 T + 845.65$','FontSize',20)
grid on 
saveas(fig11,'ShearModulusasafunctoftemp','tif')


set(groot, 'Default', struct()) 
% 
% saveas(fig1,'fig1','tif')
% saveas(fig2,'fig2','tif')


