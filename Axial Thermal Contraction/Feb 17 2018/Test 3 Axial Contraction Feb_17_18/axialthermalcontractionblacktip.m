
close all
clear all
clc

filename ='Thermal Contraction Vibrometer Data Feb_17_blacktip.csv';
num = csvread(filename);

timevib = num(1:end,1);
Disp = num(1:end,2);
filename ='Axial Contraction Temporal Plot Feb_17_18 (3).txt';
fileID = fopen(filename);
C = textscan(fileID,'%s %s %s %s %s'); % we read the file in characters in a cell
fclose(fileID);
whos C

A = C{1,3};
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

tempcam = str2num(cell2mat(C{1,4}));
newtempcam=zeros(length(timevib),1);
Disp_o = 19.6 %mm 
Strain = (Disp/Disp_o)*100;


%we interpolate the temperature respect the time of the vibrometer
for j=1:length(timevib)
    
   i=1; 
    while newtempcam(j)==0    
        
    if timecam(i)<=timevib(j) && timevib(j)<timecam(i+1)
        
        newtempcam(j)=(((timevib(j)-timecam(i))*(tempcam(i+1)-tempcam(i)))...
            /(timecam(i+1)-timecam(i)))+tempcam(i);
   
    end
    i=i+1;
    end
end

 
% p = polyfit(newtempcam,Strain,4);
% Approximation = polyval(p,newtempcam);
T_set_to_zero = newtempcam-newtempcam(1);
% f = fit(T_set_to_zero,Strain,'exp2')
% Approximation = polyval(f,newtempcam);
% plot (newtempcam,Approximation)


fig1 = figure('color','w');
[AX1,H1,H2] = plotyy(timevib,newtempcam,timevib,Strain); hold on
title('Thermal Creep for 5 cycles')
xlabel(AX1(1),'Time [s]')
ylabel(AX1(2),'Strain [%]')
ylabel(AX1(1),'Temperaute C\circ')
grid on 
saveas(fig1,'plot 12','tif')

fig2 = figure('color','w');
 plot(T_set_to_zero,Strain); hold on
%  plot (T_set_to_zero,Approximation)
%     xlim([20 100])
%     ylim([-0.3 0.05])
title('Thermal axial contraction')
ylabel('Strain [%]')
xlabel('Temperaute C\circ')
grid on 
saveas(fig2,'plot 12','tif')


%Fit thermal axial contraction coefficient 

Temp_lastcycle = newtempcam(1660:end);
Strain_lastcycles =Strain(1660:end);
Temp_lastcycle = Temp_lastcycle(7339:end);
Strain_lastcycles = Strain_lastcycles(7339:end);

fig3 = figure('color','w');
plot(Temp_lastcycle,Strain_lastcycles) 

title('Thermal axial contraction LAST CYCLE')
ylabel('Strain [%]')
xlabel('\Deta T C\circ')
grid on 
saveas(fig2,'plot 12','tif')

ExcelData = [newtempcam(1:1690) Strain(1:1690)];
filename1 = 'CleanDataThirdTest1.xlsx'
xlswrite(filename1,ExcelData)

ExcelData2 = [Temp_lastcycle Strain_lastcycles];
filename2 = 'Final Thermal Axial Expansion.xlsx'


% Retrieve Data
     filename = 'Final Thermal Axial Expansion.xlsx';
     sheet = 'Sheet1';
    range2_1 = strcat('E3:E',num2str(length(Temp_lastcycle)+2)); % input on 3rd line, under headers
     xlswrite(filename,Temp_lastcycle,sheet,range2_1)
    
    range2_2 = strcat('F3:F',num2str(length(Strain_lastcycles)+2));
    xlswrite(filename,Strain_lastcycles,sheet,range2_2)
    
    range3_1 = strcat('A3:A',num2str(length(newtempcam(1:1660))+2)); % input on 3rd line, under headers
     xlswrite(filename,newtempcam(1:1660),sheet,range3_1)
    
    range3_2 = strcat('B3:B',num2str(length(Strain(1:1660))+2));
    xlswrite(filename,Strain(1:1660),sheet,range3_2)
    
    range_heat_temp = strcat('I2:I',num2str(length(Temp_lastcycle(1:737))+1));
    xlswrite(filename,Temp_lastcycle(1:750),sheet,range_heat_temp)
    
    range_heat_strain =strcat('J2:J',num2str(length(Strain_lastcycles(1:737))+1));
    xlswrite(filename,Strain_lastcycles(1:750),sheet,range_heat_strain)
    
    range_cooling_temp = strcat('K2:K',num2str(length(Temp_lastcycle(737:end))+1));
    xlswrite(filename,Temp_lastcycle(750:end),sheet,range_cooling_temp)
    
    range_cooling_strain = strcat('L2:L',num2str(length(Strain_lastcycles(737:end))+1));
    xlswrite(filename,Strain_lastcycles(750:end),sheet,range_cooling_strain)
    
    
