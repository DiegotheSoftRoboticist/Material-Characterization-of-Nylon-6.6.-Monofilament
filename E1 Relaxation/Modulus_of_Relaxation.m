% Calculate the Modulus of Relaxation
% Amy Swartz 10/30/17

clear all
close all
clc
% Retrieve Data
%filename = 'I:\Desktop\Nylon Actuation\Relaxation Modulus\Modulus of relaxation.xls';
filename = 'Modulus of relaxation.xls';
sheet = 'Stress relaxation - 1';
L0 = 30736.3; % microns
t = xlsread(filename, sheet, 'A5:A595'); % time
F = -xlsread(filename, sheet, 'B5:B595'); % axial force (N)
L = xlsread(filename, sheet, 'C5:C595'); % gap length (microns)

% Calculated Strain, Stress, and Young's Mmodulus
e = (L-L0)/L0; % strain
s = F/(pi/4*0.00089^2)*10^(-6); % stress (MPa)
E = s./e; % Young's Modulus (MPa)

% Plot variables
% figure('Color','w') % 1, All Non-Pre-cycled Samples
% subplot(3,1,1)
%     plot(t,100*e)
%     grid on
%     title('Strain')
%     xlabel('Time (s)')
%     ylabel('\epsilon (%)')
% subplot(3,1,2)
%     plot(t,s)
%     grid on
%     title('Stress')
%     xlabel('Time (s)')
%     ylabel('\sigma (MPa)')
% subplot(3,1,3)
%     plot(t,E)
%     grid on
%     title('Modulus of Relaxation')
%     xlabel('Time (s)')
%     ylabel('E(t) (MPa)')

% Trendline
% ftype = fittype('a -b*log(x)');
% [curvefit,gof,output] = fit((t),E,ftype,'StartPoint',[3000 10])
% subplot(3,1,3)
% hold on
% plot(curvefit)





%Plots
set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');

%% Get all your variables and stuff here

fig=figure; hold on; grid on; set(gca,'FontSize',14);

left_color = [.5 .5 0];
right_color = [0 0 0];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);
[AX1,H1,H2] = plotyy(t/60,s,t/60,100*e); hold on
set(H2,'LineStyle','--');

xlabel(AX1(1),'Time (min)','FontSize',14)
ylabel(AX1(2),'Strain $$(\%)$$','FontSize',14)
ylabel(AX1(1),'Axial Stress $$\sigma_{11}^1 (MPa)$$','FontSize',14)
legend('Axial Stress','Strain Step Function','Location','southwest') 
saveas(fig,'Axial Stress Relaxation','tif')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%In order to calculate the exponential fit we need to distribute the points
%equally
x=t;
fig1=figure; hold on; grid on; set(gca,'FontSize',14);
g = fittype('a+b*exp(-x/c)');
fitOptions = fitoptions(g);
f0 = fit(x,E,g,'StartPoint',[2002,1109,32.61]);
%,'StartPoint',[2002,1109,32.61]
plot(x/60,E',x/60,f0(x),'k--')
xlabel('Time (min)'); ylabel('$E_1$ (MPa)'); %title('Axial Modulus Relaxation');
legend('Experimental Data for $E_1$','Exponential Fit Curver for $E_1$')

t_new=[0:20:1180]; % Here I divide the total time for every 20 seconds

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%MODELS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ZENER MODEL

for i = 1:length(t_new) % And we calculate the E for every new time
[c index] = min(abs(t-t_new(i)));
indice(i)=index;
E_new(i)=E(index);
end
E_new = E_new';
x=t_new';
fig2=figure; hold on; grid on; set(gca,'FontSize',14);

Zener.a = 1825;
Zener.b = 976;
Zener.c = 143.6;

for j = 1:5
g = fittype('a+b*exp(-x/c)');
Zener = fit(x,E_new,g,'StartPoint',[Zener.a,Zener.b,Zener.c])
Zener1 = 1700+1500*exp(-x/150);
Zener2 = Zener.a+Zener.b*exp(-x/Zener.c);
end


plot(x/60,E_new',x/60,Zener2,'r.-',x/60,Zener1,'k--')
xlabel('Time (min)'); ylabel('$E_1$ (MPa)'); %title('Axial Modulus Relaxation');
legend('Experimental reduced Data for $E_1$','MATLAB Zener Model Fit Curve for $E_1$','CUSTOMIZED Zener Model Fit Curve for $E_1$')
title('Relaxation Modulus for the Zener Model')
saveas(fig2,'Relaxation Modulus for the Zener Model','tif')

%MAXWEL MODEL

fig3=figure; hold on; grid on; set(gca,'FontSize',14);
Maxwell.a = 3200;
Maxwell.b = 143.6; 

for j = 1:5

g_m= fittype('a*exp(-x/b)');

Maxwell = fit(x,E_new,g_m,'StartPoint',[Maxwell.a,Maxwell.b])

Maxwell1 = 3200*exp(-x/1200);
Maxwell2 = Maxwell.a*exp(-x/Maxwell.b);

end

plot(x/60,E_new',x/60,Maxwell2,'r.-',x/60,Maxwell1,'k--')
xlabel('Time (min)'); ylabel('$E_1$ (MPa)'); %title('Axial Modulus Relaxation');
legend('Experimental reduced Data for $E_1$','MATLAB Maxwell Model Fit Curve for $E_1$','CUSTOMIZED Maxwell Model Fit Curve for $E_1$')
title('Relaxation Modulus for the Maxwell Model')
saveas(fig3,'Relaxation Modulus for the Maxwell Model','tif')

%IMPROVED PARALLEL ZENER MODEL
ParallelZener.a = 1750;
ParallelZener.b = 800;
ParallelZener.c = 20;
ParallelZener.d = 625.4;
ParallelZener.e = 350;

fig4=figure; hold on; grid on; set(gca,'FontSize',14);
for j = 1:5

g_iz= fittype('a+b*exp(-x/c)+d*exp(-x/e)');


ParallelZener = fit(x,E_new,g_iz,'StartPoint',[ParallelZener.a,ParallelZener.b,ParallelZener.c,ParallelZener.d,ParallelZener.e])
% f0_iz = fit(x,E_new,g_iz);

for i=1:60
ParallelZener1(i) = 1750+800*exp(-x(i)/20)+625.4*exp(-x(i)/350);
ParallelZener2(i) = ParallelZener.a+ParallelZener.b*exp(-x(i)/ParallelZener.c)+ParallelZener.d*exp(-x(i)/ParallelZener.e);
end
% plot(x/60,E_new',x/60,f0_iz(x),'r.-')
end

plot(x/60,E_new',x/60,ParallelZener2,'r.-',x/60,ParallelZener1,'k--')
xlabel('Time (min)'); ylabel('$E_1$ (MPa)'); %title('Axial Modulus Relaxation');
legend('Experimental reduced Data for $E_1$','MATLAB Improved Parallel Zener Model Fit Curve for $E_1$','CUSTOMIZED Improved Parallel Zener Model Fit Curve for $E_1$')
title('Relaxation Modulus for the Improved Parallel Zener Model')
saveas(fig4,'Relaxation Modulus for the Improved Parallel Zener Model','tif')

%IMPROVED SERIES ZENER MODEL

SeriesZener.a = 3199;
SeriesZener.b = 5971;
SeriesZener.c = 320;
SeriesZener.d = 1.138e+04;
SeriesZener.e = 20;


fig5=figure; hold on; grid on; set(gca,'FontSize',14);
for j = 1:5

g_isz= fittype('1/((1/a)+(1/b)*(1-exp(-x/c))+(1/d)*(1-exp(-x/e)))');

SeriesZener = fit(x,E_new,g_isz,'StartPoint',[SeriesZener.a,SeriesZener.b,SeriesZener.c,SeriesZener.d,SeriesZener.e])

for i=1:60
SeriesZener1(i) = 1/((1/3199)+(1/5971)*(1-exp(-x(i)/320))+(1/1.138e+04)*(1-exp(-x(i)/20)));
SeriesZener2(i) = 1/((1/SeriesZener.a)+(1/SeriesZener.b)*(1-exp(-x(i)/SeriesZener.c))+(1/SeriesZener.d)*(1-exp(-x(i)/SeriesZener.e)));
end

end

plot(x/60,E_new',x/60,SeriesZener2,'r.-',x/60,SeriesZener1,'k--')
xlabel('Time (min)'); ylabel('$E_1$ (MPa)'); %title('Axial Modulus Relaxation');
legend('Experimental reduced Data for $E_1$','MATLAB Improved Series Zener Model Fit Curve for $E_1$','CUSTOMIZED Improved Series Zener Model Fit Curve for $E_1$')
title('Relaxation Modulus for the Improved Series Zener Model')

saveas(fig5,'Relaxation Modulus for the Improved Series Zener Model','tif')

fig6=figure; hold on; grid on; set(gca,'FontSize',14);
h=plot(x/60,E_new',x/60,Maxwell2,'o-',x/60,Zener2,'*-',x/60,ParallelZener2,'s-',x/60,SeriesZener2,'+-')
set(h(1),'linewidth',2.5);
xlabel('Time (min)'); ylabel('$E_1$ (MPa)'); %title('Axial Modulus Relaxation');
legend('Experimental reduced Data for $E_1$',...
    'Maxwell Model Fit Curve for $E_1$',...
    'Zener Model Fit Curve for $E_1$',...
    'Paralell Zener Model Fit Curve for $E_1$',...
    'Series Zener Model Fit Curve for $E_1$')

title('Relaxation Modulus for the Viscoelastic Models')
saveas(fig6,'Relaxation Modulus for the Viscoelastic Models','tif')

set(groot, 'Default', struct())




