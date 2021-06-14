
close all
clear all
clc

k_0 = 1825; %N/mm
k_1 = 975.8; %N/mm
lambda =  143.6;
epsilon_0 = 1;
omega = 0.2;
E_storage = ((k_0+(k_1*(omega^2)*(lambda^2)))/(1+((omega^2)*(lambda^2))));
E_loss = ((k_1*(omega)*(lambda))/(1+((omega^2)*(lambda^2))));
delta= abs(atan2(E_loss,E_storage));
% delta = 0.127671027377279;
n =1;
for t = 0:0.5:100
time(n)=t;
% epsilon_c(n) = epsilon_0*(cos(omega*t)+sin(omega*t));
epsilon_c(n) = epsilon_0*(sin(omega*t));
% sigma_response(n) = 2*(cos(omega*t+delta(n))+sin(omega*t+delta(n)));
sigma_magnitud(n)= 35*(sin(omega*t+delta));
n=n+1;
end
% sigma_response = sigma_storage+sigma_loss;
% n=1;
% for t = 0:0.5:10
% timeo(n)=t;
% epsilon_co(n) = epsilon_0*(cos(t*t)+sin(t*t));
% sigma_storageo(n) = ((k_0+(k_1*(t^2)*(lambda^2)))/(1+((t^2)*(lambda^2))))*epsilon_c(n);
% sigma_losso(n) = ((k_1*(t)*(lambda))/(1+((t^2)*(lambda^2))))*epsilon_c(n);
% sigma_responseo(n) = 2*(cos(t*t+delta)+sin(t*t+delta));
% n=n+1;
% end
% sigma_magnitud=sqrt((sigma_storage.^2)+(sigma_loss.^2));

% 
% plot(timeo,sigma_storageo)
set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');

% Get all your variables and stuff here

% fig=figure; hold on; grid on; set(gca,'FontSize',14);
% 
% left_color = [.5 .5 0];
% right_color = [0 0 0];
% set(fig,'defaultAxesColorOrder',[left_color; right_color]);
% [AX1,H1,H2] = plotyy(time,epsilon_c,time,sigma_response); hold on
% set(H2,'LineStyle','--');
% 
% 
% xlabel(AX1(1),'Time (s)','FontSize',14)
% ylabel(AX1(1),'$\varepsilon(\%)$','FontSize',14)
% ylabel(AX1(2),'$\sigma (MPa)$','FontSize',14)
% text(.3,-1.1,'RESPONSE','FontSize',15)
% text(2,1,'IMPUT','FontSize',15,'Color',[ 0    0.4470    0.7410])
% % legend('Radial Thermal Strain','Temperature','Location','southwest') 
% saveas(fig,'senoidaldiagram','tif')




fig1= figure('color','w');set(gca,'FontSize',15);


 plot(epsilon_c,sigma_magnitud,'k','Linewidth',1.5); hold on
xlabel('$\varepsilon(\%)$ ','FontSize',10)
ylabel('$\sigma (MPa)$','FontSize',10)
% % xlim([-1 10])
% % ylim([-0.2 2.5])
% 
% 
saveas(fig1,'hysteresis loop','tif')

% At the end of your code, you can put this to turn off all those settings

set(groot, 'Default', struct())



