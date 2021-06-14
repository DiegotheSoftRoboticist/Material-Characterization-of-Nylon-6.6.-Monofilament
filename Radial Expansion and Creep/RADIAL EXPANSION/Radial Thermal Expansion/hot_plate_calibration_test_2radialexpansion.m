
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

fig4= figure('color','w');
 plot(time_abs,temp_Control,'Linewidth',1.5); hold on
 plot(time_abs,temp_thermist,'Linewidth',1.5); hold on
 plot(Time_cali,Temp_cali,'Linewidth',1.5); hold on
 plot (timecam,tempcam,'Linewidth',1.5)
 
%     xlim([20 100])
%     ylim([-0.3 0.05])
title('Hot Plate Calibration')
ylabel('Temperaute \circC')
xlabel('Time [s]')
legend('Control Temperature','Thermister Temperature','Calibrated Temperature','Camera Temperature')
grid on 

ExcelData1 = [time_abs' temp_thermist temp_Control]; 
ExcelData2 = [timecam tempcam];
filename1 = 'Time_HotPlateTemp_ControlTemp.xlsx'
xlswrite(filename1,ExcelData1)
filename2 = 'TimeCamera_TempCamera.xlsx'
xlswrite(filename2,ExcelData2)

%we interpolate the temperature respect the time of the microscope

filename ='Radial Expansion Microscope Data.csv';
num = csvread(filename);

time_microscope = num(1:end,1);


newtempcal=zeros(length(Time_cali),1);
%we interpolate the temperature respect the time of the microscope
for j=1:length(time_microscope)
    
   i=1; 
    while newtempcal(j)==0    
        
    if Time_cali(i)<=time_microscope(j) && time_microscope(j)<Time_cali(i+1)
        
        newtempcal(j)=(((time_microscope(j)-Time_cali(i))*(Temp_cali(i+1)-Temp_cali(i)))...
            /(Time_cali(i+1)-Time_cali(i)))+Temp_cali(i);
   
    end
    i=i+1;
    end
end

newtempcal = newtempcal(1:length(time_microscope));


% Retrieve Data
    filename = 'Radial Expansion Microscope Data.xlsx';
    sheet = 'Sheet1';
    range = strcat('E3:E',num2str(length(newtempcal)+2)); % input on 3rd line, under headers
    xlswrite(filename,newtempcal,sheet,range)
