
close all
clear all
clc

filename ='Thermal Contraction Vibrometer Data Feb_17_firsttest.csv';
num = csvread(filename);

timevib = num(1:end,1);
Disp = num(1:end,2);
filename ='Axial Contraction Temporal Plot Feb_17_18 (1).txt';
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
title('first test')
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

ExcelData1 = [newtempcam(29000:32000) Strain(29000:32000)]; 
ExcelData2 = [newtempcam(37105:end) Strain(37105:end)];
filename1 = 'CleanDataFirstTest1.xlsx'
xlswrite(filename1,ExcelData1)
filename2 = 'CleanDataFirstTest2.xlsx'
xlswrite(filename2,ExcelData2)

