
close all
clear all
clc

filename ='Hotplate_Data_RadialThermalExpansion.csv';
num = csvread(filename);
time_hour=num(1:end,1);
time_min = num(1:end,2);
time_sec = num(1:end,3);
temp_thermist = num(1:end,4);
temp_Control = num(1:end,5);
    time =3600*time_hour+60*time_min+time_sec;
 

time_abs = time-time(1);


ExcelData1 = [time_abs temp_thermist temp_Control]; 
filename1 = 'Time---HotPlateTemp---ControlTemp.xlsx'
xlswrite(filename1,ExcelData1)


filename ='Radial Expansion Microscope Data.xlsx';
sheet = 1;
    range1 ='A3:A22'; % input on 3rd line, under headers
   time_micro =  xlsread(filename,sheet,range1);
   
   range3 ='C3:C22'; % input on 3rd line, under headers
   Strain =  xlsread(filename,sheet,range3)*100;

   
   uncalibrated_temp = interp1q(time_abs,temp_thermist,time_micro);

   
% filename = 'Radial Creep Microscope Data.xlsx';
%      sheet = 'Sheet1';
%     range1 = strcat('H3:H',num2str(length(uncalibrated_temp)+2)); % input on 3rd line, under headers
%      xlswrite(filename,uncalibrated_temp,sheet,range1)

 %Following the calibration critiria for time and temperature 
 
 Temp_cali = uncalibrated_temp+1.76;
Time_cali = time_micro-6.5;

%Plots
set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');

%% Get all your variables and stuff here

fig=figure; hold on; grid on; %set(AX1,H1,H2,'FontSize',14);

left_color = [.5 .5 0];
right_color = [0 0 0];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);
[AX1,H1,H2] = plotyy(Time_cali/60,Strain,Time_cali/60,Temp_cali); hold on
set(H2,'LineStyle','--');

xlabel(AX1(1),'Time (min)','FontSize',14)
ylabel(AX1(1),'Strain $$(\%)$$','FontSize',14)
ylabel(AX1(2),'Temperature $$(^{\circ}C)$$','FontSize',14)
legend('Radial Thermal Strain','Temperature','Location','southwest') 
saveas(fig,'Radial Thermal Expansion time','tif')

fig2=figure; hold on; grid on; set(gca,'FontSize',14);

plot(Temp_cali,Strain)
ylabel('Strain $$(\%)$$')
xlabel('Temperature $$(^{\circ}C)$$')
saveas(fig2,'Radial Thermal Expansion Temperature','tif')


  set(groot, 'Default', struct())
      
