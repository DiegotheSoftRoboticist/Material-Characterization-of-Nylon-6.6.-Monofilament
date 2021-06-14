
close all
clear all
clc
set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');

filename ='ThermalCreepTestJan31_100micron5cycles.Vibrometer.csv';
num = csvread(filename);

timevib = num(1:end,1);
Disp = num(1:end,2);
filename ='rearrangedtemperature.txt';
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
Disp_o = 23 %mm 
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

% filename1 = 'newtempcam.xlsx'
% xlswrite(filename1,newtempcam)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig=figure; hold on; grid on; set(gca,'FontSize',14);
left_color = [.5 .5 0];
right_color = [0 0 0];

% set(fig,'defaultAxesColorOrder',[left_color; right_color]);
% [AX1,H1,H2] = plotyy(timevib/60,newtempcam,timevib/60,Strain); hold on
% xlabel(AX1(1),'Time (min)','FontSize',14)
% ylabel(AX1(1),'Temperature $$(^{\circ}C)$$','FontSize',14)
% ylabel(AX1(2),'Axial Thermal Strain, $$\varepsilon^t_{11}\hspace{1.5mm}(\%)$$','FontSize',14)
% xlim(AX1(1),[0 250])
% ylim(AX1(1),[20 100])
% ylim(AX1(2),[-1 -0.4])
% legend('Axial Thermal Strain','Temperature')
% grid on 
% saveas(fig,'thermalcreep_fivecycles','tif')

fig=figure; hold on; grid on; set(gca,'FontSize',20);

% left_color = [.5 .5 0];
% right_color = [0 0 0];
% 
% set(fig,'defaultAxesColorOrder',[left_color; right_color]);

yyaxis left;
H1 = plot(timevib/60,newtempcam)
ylabel('Temperature $$(^{\circ}$$C)')
yyaxis right;
H2 = plot(timevib/60,Strain)
ylabel('Axial Thermal Strain, $$\varepsilon^t_{11}\hspace{1.5mm}(\%)$$')
xlabel('Time (min)')

legend('Temperature','Axial Thermal Strain')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%First Cycle Effect
fig2=figure; hold on; grid on; set(gca,'FontSize',20);

left_color = [.5 .5 0];
right_color = [0 0 0];

% set(fig2,'defaultAxesColorOrder',[left_color; right_color]);
% [AX1,H1,H2] = plotyy(timevib(1:20920)/60,newtempcam(1:20920),timevib(1:20920)/60,Strain(1:20920));hold on
% xlabel(AX1(1),'Time (min)','FontSize',14)
% ylabel(AX1(1),'Temperature $$(^{\circ}C)$$','FontSize',14)
% ylabel(AX1(2),'Axial Thermal Strain, $$\varepsilon^t_{11}\hspace{1.5mm}(\%)$$','FontSize',14)
% xlim(AX1(1),[0 50])
% ylim(AX1(1),[20 100])
% ylim(AX1(2),[-1 0.1]) 
% legend('Axial Thermal Strain','Temperature')
% grid on 
% saveas(fig2,'First Cycle Effect','tif')


yyaxis left;
H1 = plot(timevib(1:20920)/60,newtempcam(1:20920))
ylabel('Temperature $$(^{\circ}$$C)')
yyaxis right;
H2 = plot(timevib(1:20920)/60,Strain(1:20920))
ylabel('Axial Thermal Strain, $$\varepsilon^t_{11}\hspace{1.5mm}(\%)$$')
xlabel('Time (min)')

legend('Temperature','Axial Thermal Strain')
%Creep for the final cycle
fig3=figure; hold on; grid on; set(gca,'FontSize',20);

left_color = [.5 .5 0];
right_color = [0 0 0];

set(fig3,'defaultAxesColorOrder',[left_color; right_color]);
% [AX1,H1,H2] = plotyy(timevib(87088:end)/60,newtempcam(87088:end),timevib(87088:end)/60,Strain(87088:end))
% xlim(AX1(1),[180 240])
% ylim(AX1(1),[20 100])
% ylim(AX1(2),[-1 -0.4])
% 
% xlabel(AX1(1),'Time (min)','FontSize',14)
% ylabel(AX1(1),'Temperature $$(^{\circ}C)$$','FontSize',14)
% ylabel(AX1(2),'Axial Thermal Strain, $$\varepsilon^t_{11}\hspace{1.5mm}(\%)$$','FontSize',14)
% legend('Axial Thermal Strain','Temperature')


yyaxis left;
H1 = plot(timevib(87088:end)/60,newtempcam(87088:end))
ylabel('Temperature $$(^{\circ}$$C)')
yyaxis right;
H2 = plot(timevib(87088:end)/60,Strain(87088:end))
ylabel('Axial Thermal Strain, $$\varepsilon^t_{11}\hspace{1.5mm}(\%)$$')
xlabel('Time (min)')

legend('Temperature','Axial Thermal Strain')

% 
% temp3cycles = newtempcam(43300:end);
% Strain3cycles = Strain(43300:end);
% templastcycle = newtempcam(87100:end);
% Strainlastcycle = Strain(87100:end);
% 
% 
% fig3 = figure('color','w');
% plot(temp3cycles,Strain3cycles)
% title('Thermal Creep for 3 cycles')
% ylabel('Strain [%]')
% xlabel('Temperaute C\circ')
% grid on 
% saveas(fig3,'plot 12','tif')
% 
% fig4 = figure('color','w');
% plot(templastcycle,Strainlastcycle)
% title('Thermal Creep for last cycles')
% ylabel('Strain [%]')
% xlabel('Temperaute C\circ')
% grid on 
% saveas(fig4,'plot 12','tif')