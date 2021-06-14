% Calculate E2 third test. Stress relaxation is taken into account.

clc
close all
set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');
       

% Retrieve Data
filename = 'Poissons Ratio over time.xls';
sheet = 'Sheet1';
Microscope_data = xlsread(filename,sheet,'A:E');
    time = Microscope_data(2:8,1);
    poisson = Microscope_data(2:8,5); % N

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure; hold on; grid on; set(gca,'FontSize',20);
% plot(time/60,poisson,'LineWidth',1.2);
xlabel('Time (min)'); ylabel('Poisson''s Ratio'); 
ylim([0 0.5])
mean_p(1:length(poisson))=0.304;
% err = 0.039756941*ones(size(poisson));
plot(time/60,poisson,'b o','Color',[0.7500, 0.4250, 0.2980],'LineWidth',2); hold on
plot(time/60,mean_p,'k','LineWidth', 1); 


% errorbar(time/60,mean_p(1:7),err,'LineWidth',1.2);
legend('Experimental Results','Constant Average')
% fig3 = figure; hold on; grid on; set(gca,'FontSize',14);
% plot(time_b/60,F_int);
% xlabel('Time (min)'); ylabel('$Force$ (Newton)'); title('Compression force as a function of time');
saveas(fig1,'Possion Ratio','tif')


set(groot, 'Default', struct())   