
close all
clear all
clc

filename ='dryingprocess_nylon66.csv';
num = csvread(filename);

time = num(1:end,5);
weight = num(1:end,4);

time_de = num(1:15,5)/60;
time_mo = num(15:end,5)/60;


weight_de = num(1:15,4);
weight_mo = num(15:end,4);

%Fit
% --- caseval = 1 ---- 
% f=s1+s2*exp(-t/s3) 
% --- caseval = 2 (general case, two exponentials) ---- 
% f=s1+s2*exp(-t/s3)+s4*exp(-t/s5) 
% --- caseval = 3 ---- 
% f=s1*(1-exp(-t/s2)) %i.e., constraints between s1 and s2 


f_de=exp2fit(time_de,weight_de,1)
f_desiccant=f_de(1)+f_de(2)*exp(-time_de/37)

f_mo=exp2fit(time_mo,weight_mo,1)
f_moisture=f_mo(1)+f_mo(2)*exp(-time_mo/f_mo(3))
% f_de = fit(time_de,weight_de,'exp2')
% plot(f_de,time_de,weight_de)
% 
% f_mo = fit(time_mo,weight_mo,'exp2')
% plot(f_mo,time_mo,weight_mo)

percent = ((weight(1)-weight)/weight(1))*100; % parcentage of moisture
time_hours = time/60; %time in hours



set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');

%% Get all your variables and stuff here


fig=figure; hold on; grid on; set(gca,'FontSize',20);
plot(time_de,weight_de,'o','LineWidth', 0.8),hold on
t=0:1:180
 f_desiccant_time=f_de(1)+f_de(2)*exp(-t/37)
  plot(t(1:118),f_desiccant_time(1:118),'- b','LineWidth', 0.5),hold on
  
% plot(time_de,f_desiccant,'-- b','LineWidth', 0.5),hold on
plot(time_mo,weight_mo,'r x','LineWidth', 0.8),hold on
plot(time_mo,f_moisture,'-.','LineWidth', 0.5,'color','[0.55 0 0]'),hold on
plot(t(122:2:181),f_desiccant_time(122:2:181),'. b','LineWidth', 0.5),hold on
% Plot your stuff
% All the labels and everything has to be in latex syntex, so here's a sample axis label:
xlabel('Time (hours)')
ylabel('Mass (grams)')
legend('Desiccation Data','Exponential Fit of Desiccation','Moisture Absorption Data','Exponential Fit of Absorption','Extrapolation of Desiccantion Fit')
saveas(fig,'Whole Drying Process','jpg')

t=0:1:180
 f_desiccant_time=f_de(1)+f_de(2)*exp(-t/37)

 
%  plot(time_de,weight_de,'o','LineWidth', 0.8),hold on
% plot(t,f_desiccant_time,'-- b','LineWidth', 0.5),hold on
% % At the end of your code, you can put this to turn off all those settings
% xlabel('Time $(Hours)$')
% ylabel('Mass $(Grams)$')
% legend('Desiccation Experimental Data','Extended Exponential Fit')
% saveas(fig1,'Whole Drying Process Zoom','jpg')
set(groot, 'Default', struct())


