
close all
clear all
clc



filename1 = 'Matched camare temperature with the rheometer 36 degrees.xlsx'
 sheet = 'Sheet1'
newtempcam = xlsread(filename1,sheet, 'A1:A4744');

filename2 = 'Actuation Test Feb 18 18_36PA.xlsx'
sheet = 'Sheet1';

untwist_rad = xlsread(filename2,sheet, 'B4:B4747');
contraction = xlsread(filename2,sheet, 'C4:C4747');
untwist = (untwist_rad*180)/pi; %untwist in degrees.

% Number of inserted twist = 103,
%Lentgh of the sample in mm = 395 mm
%Radius = 0.89 mm/2
% NonDimensionalAngle = Phi*Radius/ Length 

NonDimensionalAngle = (2*pi*(103-(untwist/360))*(0.89/2))/395


strain = ((contraction-contraction(1))/contraction(1))*100;

%Temperature Cycles 

Temp1= newtempcam(1:3000);
Temp2= newtempcam(3000:3700);
Temp3= newtempcam(3700:4300);
Temp4= newtempcam(4300:4744);

%Untwist Cycles 

untwist1= untwist(1:3000);
untwist2= untwist(3000:3700);
untwist3= untwist(3700:4300);
untwist4= untwist(4300:4744);

%Strain Cycles 

strain1= strain(1:3000);
strain2= strain(3000:3700);
strain3= strain(3700:4300);
strain4= strain(4300:4744);


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
ylim([-255 10])
xlabel('Temperature ($$^{\circ}$$C)','FontSize',20)
ylabel(' $$\Delta \phi~~ (^\circ)$$','FontSize',20)
legend('First Cycle','Second Cycle','Third Cycle','Fourth Cycle','Location','Northeast') 
% saveas(fig,'Axial Stress Relaxation','tif')
fig1=figure; hold on; grid on; set(gca,'FontSize',20);
plot(Temp1,strain1,'LineWidth',1.2); hold on
plot(Temp2,strain2,'LineWidth',1.2); hold on
plot(Temp3,strain3,'LineWidth',1.2); hold on
plot(Temp4,strain4,'LineWidth',1.2); hold on
ylim([-0.1 0.7])
xlabel('Temperature ($$^{\circ}$$C)','FontSize',20)
ylabel('Strain $$(\%)$$','FontSize',20)
legend('First Cycle','Second Cycle','Third Cycle','Fourth Cycle','Location','southeast')

fig3=figure; hold on; grid on; set(gca,'FontSize',20);

   plot(newtempcam(4300:4567),NonDimensionalAngle(4300:4567)-NonDimensionalAngle(4300),'--r','LineWidth',2)
   plot(newtempcam(4567:end),NonDimensionalAngle(4567:end)-NonDimensionalAngle(4300),'--b','LineWidth',2)
 
 xlabel('Temperature ($$^{\circ}$$C)')
 ylabel('$$\Delta \Phi$$')
 grid on
 legend('Heating','Cooling','northwest')
  
 ExcelData1 = [newtempcam(4300:end) untwist(4300:end) NonDimensionalAngle(4300:end)]

filename = 'Free actuation Amys Paper1.xlsx'
  xlswrite(filename,ExcelData1)
 