clc
close all
clear all
set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');

figure; hold on; grid on; set(gca,'FontSize',20);

% Sample diameter and area
D = 0.89; % mm
Area = (pi*D^2)/4; %mm^2

% Retrieve Data


filename = 'E1_Relaxation_Test2_May29_2018';

    sheet = 40; %strcat({'Stress relaxation - '},num2str(i));
    data = xlsread(filename,sheet,'A:F');
        time = data(:,3);
        F = abs(data(:,5)); % N
        L = data(:,6)*10^-3; % mm

    % Shear Modulus
    Stress = F/Area;
    Strain = ((L-19.450)/19.450);
    E =Stress./Strain;
    
  
figure; hold on; grid on; set(gca,'FontSize',20);
plot(time/60, E*10^-3,'linewidth',1.6);
xlabel('Time (min)'); ylabel('$E_1$ (GPa)'); 
x=time;
% 
%MAXWEL MODEL
Maxwell.a = 2600;
Maxwell.b = 7811; 
for j = 1:10
g_m= fittype('a*exp(-x/b)');
Maxwell = fit(x,E,g_m,'StartPoint',[Maxwell.a,Maxwell.b])
Maxwell2 = Maxwell.a*exp(-x/Maxwell.b);
end

%ZENER MODEL
Zener.a = 2600;
Zener.b = 387.8;
Zener.c = 262.2;
for j = 1:10
g = fittype('a+b*exp(-x/c)');
Zener = fit(x,E,g,'StartPoint',[Zener.a,Zener.b,Zener.c])
%
Zener2 = Zener.a+Zener.b*exp(-x/Zener.c);
end

%IMPROVED PARALLEL ZENER MODEL
ZenerParallel.a = 2200;
ZenerParallel.b = 300.8;
ZenerParallel.c = 29.53;
ZenerParallel.d = 312.9;
ZenerParallel.e = 496.4;
for j = 1:10

g_iz= fittype('a+b*exp(-x/c)+d*exp(-x/e)');

ZenerParallel = fit(x,E,g_iz,'StartPoint',[ZenerParallel.a,ZenerParallel.b,ZenerParallel.c,ZenerParallel.d,ZenerParallel.e])
%
for i=1:length(x)
ZenerParallel2(i) = ZenerParallel.a+ZenerParallel.b*exp(-x(i)/ZenerParallel.c)+ZenerParallel.d*exp(-x(i)/ZenerParallel.e);
end
end


%IMPROVED SERIES ZENER MODEL
ZenerSeries.a = 2760;
ZenerSeries.b = 10500;
ZenerSeries.c = 4090;
ZenerSeries.d = 16000;
ZenerSeries.e = 0.376;
for j = 1:10
g_isz= fittype('1/((1/a)+(1/b)*(1-exp(-x/c))+(1/d)*(1-exp(-x/e)))');
ZenerSeries = fit(x,E,g_isz,'StartPoint',[ZenerSeries.a,ZenerSeries.b,ZenerSeries.c,ZenerSeries.d,ZenerSeries.e])
%
for i=1:length(x)
 ZenerSeries2(i) = 1/((1/ZenerSeries.a)+(1/ZenerSeries.b)*(1-exp(-x(i)/ZenerSeries.c))+(1/ZenerSeries.d)*(1-exp(-x(i)/ZenerSeries.e)));
 
end

end

 t = [0:60:1197]'
Maxwell22 = Maxwell.a*exp(-t/Maxwell.b); 
Zener22 = Zener.a+Zener.b*exp(-t/Zener.c); 
ZenerParallel22 = ZenerParallel.a+ZenerParallel.b*exp(-t/ZenerParallel.c)+ZenerParallel.d*exp(-t/ZenerParallel.e);

n=1;
for t=0:60:1197
 ZenerSeries22(n) = 1/((1/ZenerSeries.a)+(1/ZenerSeries.b)*(1-exp(-t/ZenerSeries.c))+(1/ZenerSeries.d)*(1-exp(-t/ZenerSeries.e)));
 n=n+1;
end
 t = [0:60:1197]';
fig4 = figure; hold on; grid on; set(gca,'FontSize',20);

h=plot(x/60,E*10^-3,x/60,Maxwell2*10^-3,'b',t/60,Maxwell22*10^-3,'bo',x/60,Zener2*10^-3,'r',t/60,Zener22*10^-3,'r*',...
    x/60,ZenerParallel2*10^-3,'g',t/60,ZenerParallel22*10^-3,'gs',x/60,ZenerSeries2*10^-3,'m',t/60,ZenerSeries22*10^-3,'m+')

% h=plot(x/60,G2new/10^6,x/60,ZenerSeries2,t/60,ZenerSeries22,'+')
% h=plot(x/60,G2new/10^6',x/60,Maxwell2,'o-',x/60,Zener2,'*-',x/60,ZenerParallel2,'s-',x/60,ZenerSeries2,'+-')
set(h(1),'color','k','LineStyle','--','linewidth',3);


%        ylim([200 600])
       xlim([0 20])

xlabel('Time (min)'); ylabel('$E_{1}$ (MPa)'); %title('Axial Modulus Relaxation');
legend([h(1) h(3) h(5) h(7) h(9)],{'Experimental Data for $E_1$'...
    ,'Maxwell Model Fit Curve for $E_1$'...
    ,'Zener Model Fit Curve for $E_1$'...
    ,'Paralell Zener Model Fit Curve for $E_1$'...
    ,'Series Zener Model Fit Curve for $E_1$'})

% title('Relaxation Modulus for the Viscoelastic Models')
saveas(fig4,'G12 Modulus for the Viscoelastic Models','tif')


set(groot, 'Default', struct())   
