
close all
clear all
clc



 filename1 = 'Matched camare temperature with the rheometer 15 degrees.xlsx'
 sheet = 'Sheet1'
newtempcam = xlsread(filename1,sheet, 'A1:A3164');

filename2 = 'Actuation Test Feb 18 18_15PA (1).xlsx'
sheet = 'Sheet';

untwist_rad = xlsread(filename2,sheet, 'B4:B3167');
contraction = xlsread(filename2,sheet, 'C4:C3167');
untwist = (untwist_rad*180)/pi; %untwist in degrees.

% Number of inserted twist = 37,
%Lentgh of the sample in mm = 385 mm
%Radius = 0.89 mm/2
% NonDimensionalAngle = Phi*Radius/ Length 

NonDimensionalAngle = (2*pi*(37-(untwist/360))*(0.89/2))/385


strain = ((contraction-contraction(1))/contraction(1))*100;

%Temperature Cycles 

Temp1= newtempcam(1:2000);
Temp2= newtempcam(2000:2400);
Temp3= newtempcam(2400:2870);
Temp4= newtempcam(2870:3164);

%Untwist Cycles 

untwist1= untwist(1:2000);
untwist2= untwist(2000:2400);
untwist3= untwist(2400:2870);
untwist4= untwist(2870:3164);



%Strain Cycles 

strain1= strain(1:2000);
strain2= strain(2000:2400);
strain3= strain(2400:2870);
strain4= strain(2870:3164);


%Plots
set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');

%% Get all your variables and stuff here

fig=figure; hold on; grid on; set(gca,'FontSize',20);

plot(Temp1,-untwist1,'LineWidth',1.2); hold on
plot(Temp2,-untwist2,'LineWidth',1.2); hold on
plot(Temp3,-untwist3,'LineWidth',1.2); hold on
plot(Temp4,-untwist4,'LineWidth',1.2); hold on

xlabel('Temperature ($$^{\circ}$$C)','FontSize',20)
ylabel(' $$\Delta \phi~~ (^\circ)$$','FontSize',20)
legend('First Cycle','Second Cycle','Third Cycle','Fourth Cycle','Location','Northeast') 
% saveas(fig,'Axial Stress Relaxation','tif')
fig1=figure; hold on; grid on; set(gca,'FontSize',20);
plot(Temp1,strain1,'LineWidth',1.2); hold on
plot(Temp2,strain2,'LineWidth',1.2); hold on
plot(Temp3,strain3,'LineWidth',1.2); hold on
plot(Temp4,strain4,'LineWidth',1.2); hold on

xlabel('Temperature ($$^{\circ}$$C)','FontSize',20)
ylabel('Strain $$(\%)$$','FontSize',20)
legend('First Cycle','Second Cycle','Third Cycle','Fourth Cycle','Location','southwest')


fig3=figure; hold on; grid on; set(gca,'FontSize',20);

   plot(newtempcam(2870:3007),NonDimensionalAngle(2870:3007)-NonDimensionalAngle(2870),'--r','LineWidth',2)
   plot(newtempcam(3007:end),NonDimensionalAngle(3007:end)-NonDimensionalAngle(2870),'--b','LineWidth',2)
 
 xlabel('Temperature ($$^{\circ}$$C)')
 ylabel('$$\Delta \Phi$$')
 grid on
  legend('Heating','Cooling','northwest')


