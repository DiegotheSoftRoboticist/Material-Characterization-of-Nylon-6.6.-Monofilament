 
clear
clc
close all


 % Retrieve Data
    filename = 'Axial aned radial thermal expansion.xlsx';
    sheet = 'Sheet1';
    data = xlsread(filename, sheet,'A:D');
        Temp_axial = data(1:end,1);
        Axial_strain = data(1:end,2);
        Temp_radial = data(1:20,3);
        Radial_strain = data(1:20,4);

p_axial = polyfit(Temp_axial,Axial_strain,3);
fit_axial = polyval(p_axial,Temp_axial);
fit_epsilon_paper_axial = (-0.0091*(Temp_axial.^3 - Temp_axial(1)^3) + 0.954*(Temp_axial.^2 - Temp_axial(1)^2)- 32.1*(Temp_axial - Temp_axial(1))) * 10^-4 

p_radial = polyfit(Temp_radial,Radial_strain,2);
fit_radial = polyval(p_radial,Temp_radial);
fit_epsilon_paper_radial = ( 0.000122*(Temp_radial.^2 - Temp_radial(1)^2)+0.0022*(Temp_radial - Temp_radial(1)))-0.152

set(groot, 'DefaultTextInterpreter', 'tex', ...
           'DefaultAxesTickLabelInterpreter', 'tex', ...
           'DefaultAxesFontName', 'tex', ...
           'DefaultLegendInterpreter', 'tex', ...
           'defaultFigureColor','w');

fig1=figure; hold on; grid on; set(gca,'FontSize',16);

 figure('color','white'); hold on; grid on; set(gca,'FontSize',20);%title('Radial Thermal Expansion - Curve Fits')
  plot(Temp_axial(1:10:730), Axial_strain(1:10:730)-Axial_strain(1),':','Color',[0.3010 0.7450 0.9330],'Linewidth',2)      
 plot(Temp_radial(1:7), Radial_strain(1:7),'Color',[0.3010 0.7450 0.9330],'Linewidth',2)
%         plot(Temp_radial(8:20), Radial_strain(8:20),'--b','LineWidth',2)
        
%         plot(Temp_radial,fit_epsilon_paper_radial-fit_epsilon_paper_radial(1),'--k')
        
       
%         plot(Temp_axial(738:end), Axial_strain(738:end),'--b','LineWidth',2)
        
%         plot(Temp_axial,fit_epsilon_paper_axial,'--k')
        
        
       grid on  
       ylabel('Thermal Strain, \epsilon^t(%)')
       xlabel('Temperature (^{\circ}C)')
        legend('\epsilon_{Axial} Nylon Monofilament',...
     '\epsilon_{Radial} Nylon Monofilament')  
        
        