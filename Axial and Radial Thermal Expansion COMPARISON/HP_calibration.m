% Hot Plate Calibration Using Thermal Camera
clc
close all
set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');
       
% Calibration Offset
tdelay = -6.5;
Tdiff = 1.76;
% Colors
dr = [0.75, 0.07, 0.1];
lb = [0 , 0.8, 1];

% % Radial Expansion - Calibration
% % Interpolate Hot Plate temperatures to camera time vector
%     % Retrieve Data
%     filename = 'RadExpan_HP-Cam_Calibration_T2.xlsx';
%     sheet = 'Sheet1';
%     cam_data = xlsread(filename, sheet,'A:B');
%         time_cam = cam_data(:,1);
%         temp_cam = cam_data(:,2);
%     hp_data = xlsread(filename, sheet,'E:F');
%         time_hp = hp_data(:,1);
%         temp_hp = hp_data(:,2);
%     % Interpolate
%     temp_hp = interp1(time_hp, temp_hp, time_cam);
% %     % Store interpolated temperatures in the Excel Sheet
% %     range = strcat('C3:C',num2str(length(cam_data)+2));
% %     xlswrite(filename,temp_hp,sheet,range)
% 
% % Plot Calibration Data
%     time = time_cam(1:length(temp_hp));
%     temp_cam = temp_cam(1:length(temp_hp));
%     figure('color','white'); hold on; grid on; %title('Hot Plate Calibration')
%     plot(time, temp_cam, 'k', time, temp_hp,'b',time+tdelay, temp_hp+Tdiff,'b--')
%     legend('Camera Temp', 'Hot Plate Temp', 'Calibrated Temp')
%     xlabel('Time (s)')
%     ylabel('Temperature (\circC)')
%     
% Radial Expansion Data
    % Retrieve Data
    filename = 'Radial Expansion Microscope Data.xlsx';
    sheet = 'Sheet1';
    exp_microscope = xlsread(filename, sheet,'A:C');
        time_exp = exp_microscope(:,1);
        strain_exp = exp_microscope(:,3);
    exp_data_temp = xlsread(filename, sheet,'G:H');
        time_exp_cal = exp_data_temp(:,1)+tdelay; % Raw: don't subract 5.5
        temp_exp_cal = exp_data_temp(:,2)+Tdiff; % Raw: don't add 1.76
    % Interpolate
    temp_exp = interp1(time_exp_cal, temp_exp_cal, time_exp);
% %     % Store interpolated temperatures in the Excel Sheet
% %     range = strcat('E3:E',num2str(length(time_exp)+2));
% %     xlswrite(filename,temp_exp,sheet,range)
% 
% 
    % Plot Temp and Strain vs. Time
    fig = figure('color','white'); hold on; grid on;set(gca,'FontSize',20); %title('Radial Thermal Expansion - Time Data');
    set(fig,'defaultAxesColorOrder',[[1 0 0]; [0 1 1]]);
        yyaxis left % Strain
            plot(time_exp, 100*strain_exp)
            ylabel('Thermal Strain, \fontsize{15} \epsilon_{\fontsize{5} 22}^{\fontsize{7} t} \fontsize{10} (%)')
        yyaxis right % Temp
            plot(time_exp,temp_exp)
            ylabel('Temperature (\circC)')
        xlabel('Time (s)')
    % Find indice of max temperature
    [M,b] = max(temp_exp);
    % Generate Curve fits with truncated data
    T_trunc = temp_exp(1:end-3);
    strain_exp_trunc = strain_exp(1:end-3);
    exp_heat_fit = polyfit(temp_exp(1:b), 100*strain_exp(1:b),2)
    exp_cool_fit = polyfit(T_trunc(b:end), 100*strain_exp_trunc(b:end),2)
    exp_tot_fit = polyfit(T_trunc(1:end), 100*strain_exp_trunc(1:end),2)
    % Alpha = de/dT
        alpha_heat_fit = [exp_heat_fit(1)*2, exp_heat_fit(2)]
        alpha_cool_fit = [exp_cool_fit(1)*2, exp_cool_fit(2)]
        alpha_fit = [exp_tot_fit(1)*2, exp_tot_fit(2)]
    T_exp = temp_exp(1):0.1:temp_exp(b);
    exp_heat = polyval(exp_heat_fit,T_exp);
    exp_cool = polyval(exp_cool_fit,T_exp);
    exp_tot = polyval(exp_tot_fit,T_exp);
        alpha_heat = polyval(alpha_heat_fit,T_exp);
        alpha_cool = polyval(alpha_cool_fit,T_exp);
        alpha = polyval(alpha_fit,T_exp);
     % Plot Experimental Data and Curve fit
    figure('color','white'); hold on; grid on; set(gca,'FontSize',20);%title('Radial Thermal Expansion - Curve Fits')
        plot(temp_exp(1:end), 100*strain_exp(1:end),'LineWidth',2)
%         plot(T_trunc(b:end), 100*strain_exp_trunc(b:end),'LineWidth',2)    
%         plot(T_exp, exp_heat,'Color',dr)
%         plot(T_exp, exp_cool,'Color',lb)
        plot(T_exp,exp_tot,'--k')
       ylabel('Radial Thermal Strain, $$\varepsilon^t_{22}\hspace{1.5mm}(\%)$$')
       xlabel('Temperature $$(^{\circ}$$C)')
        legend('Radial Thermal Expansion','Curve Fit','Location','northwest')    
        
ExcelData1 = [temp_exp(1:end) 100*strain_exp(1:end)]

filename = 'Radial thermal expansion.xlsx'
  xlswrite(filename,ExcelData1)        
        
        
% % % % %     % Plot Experimental Data and Curve fit
% % % % %     figure('color','white'); hold on; grid on; %title('Radial Thermal Expansion - Curve Fits')
% % % % %         plot(temp_exp(1:b), 100*strain_exp(1:b),'Color',dr, 'LineStyle', ':','LineWidth',2)
% % % % %         plot(T_trunc(b:end), 100*strain_exp_trunc(b:end),'Color',lb, 'LineStyle', ':','LineWidth',2)    
% % % % % %         plot(T_exp, exp_heat,'Color',dr)
% % % % % %         plot(T_exp, exp_cool,'Color',lb)
% % % % %         plot(T_exp,exp_tot,'k')
% % % % %         xlabel('Temperature (\circC)')
% % % % %         ylabel('Radial Thermal Strain, \fontsize{15} \epsilon_{\fontsize{5} 22}^{\fontsize{7} t} \fontsize{10} (%)')
% % % % %         legend('Heating Data','Cooling Data','Quadratic Curve Fit','Location','northwest')
%         ax = gca;
%         ax.XAxisLocation = 'origin';
%         ax.YAxisLocation = 'origin';
% %     % Plot Curve Fits alone
% %     figure('color','white'); hold on; grid on; title('Radial Thermal Expansion - Curve Fits')
% %         plot(T_exp, exp_heat,'r--',T_exp, exp_cool,'b--',T_exp,exp_tot,'k')
% %         xlabel('\DeltaT (\circC)')
% %         ylabel('Radial Thermal Strain, \fontsize{15} \epsilon_{\fontsize{5} 22}^{\fontsize{7} t} \fontsize{10} (%)')
% %         legend('Heating Curve Fit','Cooling Curve Fit','Combined Curve Fit')
% %         ax = gca;
% %         ax.XAxisLocation = 'origin';
% %         ax.YAxisLocation = 'origin';
% 
%     % Plot Alpha22
%     figure('color','white'); hold on; grid on; %title('Radial Thermal Expansion - Alpha')
%         plot(T_exp,alpha,'k')
%         xlabel('Temperature (\circC)')
%         ylabel('Radial Thermal Expansion, \fontsize{15} \alpha_{\fontsize{5} 22}^{\fontsize{7} t} \fontsize{10} (\circC^{-1})')
%     


% % Radial Creep - Calibration
% % Interpolate Hot Plate temperatures to camera time vector
%     % Retrieve Data
%     filename = 'RadExpan_HP-Cam_Calibration_T2.xlsx';
%     sheet = 'Sheet1';
%     cam_data = xlsread(filename, sheet,'A:B');
%         time_cam = cam_data(:,1);
%         temp_cam = cam_data(:,2);
%     hp_data = xlsread(filename, sheet,'E:F');
%         time_hp = hp_data(:,1);
%         temp_hp = hp_data(:,2);
%     % Interpolate
%     temp_hp = interp1(time_hp, temp_hp, time_cam);
% %     % Store interpolated temperatures in the Excel Sheet
% %     range = strcat('C3:C',num2str(length(cam_data)+2));
% %     xlswrite(filename,temp_hp,sheet,range)

% % Radial Creep Data
%     % Retrieve Data
%     filename = 'Radial Creep Microscope Data.xlsx';
%     sheet = 'Sheet1';
%     creep_data_strain = xlsread(filename, sheet,'A:C');
%         time_creep = creep_data_strain(:,1);
%         strain_creep = creep_data_strain(:,3);
%     creep_data_temp = xlsread(filename, sheet,'G:H');
%         time_creep_cal = creep_data_temp(:,1)+tdelay;
%         temp_creep_cal = creep_data_temp(:,2)+Tdiff;
%     % Interpolate
%     temp_creep = interp1(time_creep_cal, temp_creep_cal, time_creep);
% % %     % Store interpolated temperatures in the Excel Sheet
% % %     range = strcat('E3:E',num2str(length(time_creep)+2));
% % %     xlswrite(filename,temp_creep,sheet,range)
% % 
%     % Plot Temp and Strain vs. Time
%     fig = figure('color','white'); hold on; grid on; %title('Radial Thermal Creep - Time Data');
%         set(gca,'FontSize',14)
%         yyaxis left % Strain
%             plot(time_creep/60, 100*strain_creep)
% %             ylabel('Radial Thermal Strain, \fontsize{19} \epsilon_{\fontsize{10} 22}^{\fontsize{10} t} \fontsize{14} (%)')
%             ylabel('Radial Thermal Strain, $$\varepsilon^t_{22}\hspace{1.5mm}(\%)$$')
%         yyaxis right % Temp
%             plot(time_creep/60,temp_creep,'--')
% %             ylabel('Temperature (\circC)')
%             ylabel('Temperature $$(^{\circ}C)$$')
%         xlabel('Time (min)')
%         legend('Radial Thermal Strain','Temperature')

 %ALPHA
fig1=figure; hold on; grid on; set(gca,'FontSize',20);
alpha = (2.62*(T_exp - T_exp(1))-9.29) * 10^-4 

plot(T_exp,alpha,'LineWidth',3);hold on

% plot(T_6,fit,'LineWidth',1,'Color',[0,0,0]);hold on

ylabel('Radial Thermal Strain Coefficient, $$\alpha^t_{22}\hspace{1.5mm}$$')
xlabel('Temperature ($$^{\circ}$$C)')
% ylim([-0.016 0])

set(groot, 'Default', struct())   