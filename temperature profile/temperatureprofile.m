
close all
clear all
clc

filename ='temperature profile.csv';
num = csvread(filename);

pixel = num(1:end,1);
temp = num(1:end,2);
temp_mean(1:length(temp),1) = mean(temp);



set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');

%% Get all your variables and stuff here

fig=figure; hold on; grid on; set(gca,'FontSize',20);

% fig1= figure('color','w');set(gca,'FontSize',5);
plot(pixel,temp,'Linewidth',1.5); hold on
plot(pixel,temp_mean,'k --','Linewidth',1.5); hold on
% Plot your stuff
% All the labels and everything has to be in latex syntex, so here's a sample axis label:
ylabel('Temperature ($$^{\circ}$$C)')
xlabel('Pixel')
text(31,41.5,'IR','FontSize',20)
text(57.5,41.5,'Visual Spectrum','FontSize',20)
legend('Temperature Profile','Average Temperature','Location','southwest') 
saveas(fig,'TemperatureProfile','tif')

% At the end of your code, you can put this to turn off all those settings

set(groot, 'Default', struct())



