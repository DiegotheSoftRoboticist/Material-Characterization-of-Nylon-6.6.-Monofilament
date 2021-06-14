
close all
clear all
clc

filename ='Hotplat_ThermalCreep_DATA.csv';
num = csvread(filename);
time_hour=num(1:end,1);
time_min = num(1:end,2);
time_sec = num(1:end,3);
temp_thermist = num(1:end,4);
temp_Control = num(1:end,5);
    time =3600*time_hour+60*time_min+time_sec;
 

time_abs = time-time(1);


% ExcelData1 = [time_abs temp_thermist temp_Control]; 
% filename1 = 'Time---HotPlateTemp---ControlTemp.xlsx'
% xlswrite(filename1,ExcelData1)


filename ='Radial Creep Microscope Data.xlsx';
sheet = 1;
    range1 ='A3:A68'; % input on 3rd line, under headers
   time_micro =  xlsread(filename,sheet,range1);
   
   range3 ='C3:C68'; % input on 3rd line, under headers
   Strain =  xlsread(filename,sheet,range3)*100;

   
   uncalibrated_temp = interp1q(time_abs,temp_thermist,time_micro);

   
filename = 'Radial Creep Microscope Data.xlsx';
     sheet = 'Sheet1';
    range1 = strcat('H3:H',num2str(length(uncalibrated_temp)+2)); % input on 3rd line, under headers
     xlswrite(filename,uncalibrated_temp,sheet,range1)

 %Following the calibration critiria for time and temperature 
 
 Temp_cali = uncalibrated_temp+1;
Time_cali = time_micro-6;

%Plots
set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');

%% Get all your variables and stuff here

fig=figure; hold on; grid on; set(gca,'FontSize',20);
% 
% left_color = [.5 .5 0];
% right_color = [0 0 0];
% set(fig,'defaultAxesColorOrder',[left_color; right_color]);
% [AX1,H1,H2] = plotyy(Time_cali/60,Strain,Time_cali/60,Temp_cali); hold on
% set(H2,'LineStyle','--');
% 
% xlabel(AX1(1),'Time (min)','FontSize',14)
% ylabel(AX1(2),'Strain $$(\%)$$','FontSize',14)
% ylabel(AX1(1),'Temperature $$(^{\circ}C)$$','FontSize',14)
% legend('Radial Thermal Strain','Temperature','Location','southwest') 
% saveas(fig,'Radial Thermal Creep','tif')


yyaxis left;

H2 = plot(Time_cali/60,Temp_cali)
ylabel('Temperature $$(^{\circ}$$C)')
yyaxis right;
H1 = plot(Time_cali/60,Strain)
ylabel('Radial Thermal Strain, $$\varepsilon^t_{22}\hspace{1.5mm}(\%)$$')
xlabel('Time (min)')

legend('Radial Thermal Strain','Temperature','Location','southwest') 
  set(groot, 'Default', struct())
      