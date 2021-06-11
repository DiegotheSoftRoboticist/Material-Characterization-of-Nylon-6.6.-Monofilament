
close all
clear all
clc

filename ='hot_plate_calibration_test_2 radial expansion.csv';
num = csvread(filename);

time_min = num(1:end,2);
time_sec = num(1:end,3);
temp_thermist = num(1:end,4);
temp_Control = num(1:end,5);
for i =1 : length(time_min)
if time_min(i)==0 || time_min(i)==1 || time_min(i)==2 || time_min(i)==3
    time(i) =3600+60*time_min(i)+time_sec(i);
else  
time(i) =60*time_min(i)+time_sec(i);
end
end
time_abs = time-time(1);
filename ='thermal camera_hot plate test 2 radial expansion.txt';
fileID = fopen(filename);
Camera = textscan(fileID,'%s %s %s %s %s'); % we read the file in characters in a cell
fclose(fileID);
whos Camera

A = Camera{1,3};
% Below we convert the relative time to absolute time
[Y, M, D, H, MN, S] = datevec(A);
for i =1 : length(H)
    if H(i)==0|H(i)==1
D(i)=(24+H(i))*3600+MN(i)*60+S(i);
    else
D(i)=(H(i)*3600)+(MN(i)*60)+S(i);
    end
end
 timecam = D-D(1);

tempcam = str2num(cell2mat(Camera{1,4}));

 
 Temp_cali = temp_thermist+2;
 Time_cali = time_abs-6;

 set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');
       
fig=figure; hold on; grid on; set(gca,'FontSize',20);

 plot(time_abs/60,temp_Control,'Linewidth',1.5); hold on
 plot(time_abs/60,temp_thermist,'Linewidth',1.5); hold on
 plot (timecam/60,tempcam,'Linewidth',1.5); hold on
 plot(Time_cali/60,Temp_cali,'--','Linewidth',1.5)
 
 
xlim([-0.2 6])
%     ylim([-0.3 0.05]) 
ylabel('Temperature ($$^{\circ}$$C)')
xlabel('Time (min)')

% legend('Control Temperature','Thermister Temperature','Calibrated Temperature','Camera Temperature','Location','Northeast')
% saveas(fig,'CalibrationForRadialThermalExpansion','tif')

set(groot, 'Default', struct()) 



ExcelData1 = [time_abs' temp_thermist temp_Control]; 
ExcelData2 = [timecam tempcam];
filename1 = 'Time_HotPlateTemp_ControlTemp.xlsx'
xlswrite(filename1,ExcelData1)
filename2 = 'TimeCamera_TempCamera.xlsx'
xlswrite(filename2,ExcelData2)




% fig3= figure('color','w');
%  plot(temp_thermist,tempcam(1:length(temp_thermist)),'Linewidth',1.5); hold on
