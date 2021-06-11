clc
close all
clear all
set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');


% Sample diameter and polar moment of inertia
D = 0.89/10^3; % m
J = pi*D^4/32; % m^4

filename = 'G12Relaxation_Test2_May25';
    sheet = 40; %strcat({'Stress relaxation - '},num2str(i));
    data2 = xlsread(filename,sheet,'A:F');
        time2 = data2(120:end,3);
        torque2 = data2(120:end,1)/10^6; % N-m
        theta2 = data2(120:end,2); % rad
        F2 = data2(120:end,5); % N
        L2 = data2(120:end,6)/10^6; % m

    % Shear Modulus
    G2 = torque2.*L2./(J*theta2);
    
    % Plot data for all cycles
%     figure(1)
%     yyaxis left
%         plot(time/60, torque*10^3, '-')
%     yyaxis right
%         plot(time/60, theta, '-')
%     
    % Plot overlapping loading cycles
   

t_new=[0:10:1182];
for i = 1:length(t_new) % And we calculate the E for every new time
[c index] = min(abs(time2-t_new(i)));
indice(i)=index;
G2new(i)=G2(index);
end

G2new = G2new';
x=t_new';

% Labels
% figure(1)
%     yyaxis left; ylabel('Torque (N-mm)'); ylim([-3 5])
%     yyaxis right; ylabel('$\theta$ (rad)');
%     xlabel('Time (min)');

fig = figure; hold on; grid on; set(gca,'FontSize',14);
    

plot(time2/60,G2/10^6,x/60,G2new/10^6); 
    xlabel('Time (min)'); ylabel('$G_{12}$ (MPa)'); 
    
%       ylim([200 450])
%       xlim([0 20])
      
      legend('a','b')
%     legend(strcat({'Ramp'},{' '},num2str((1:i/2)')));
% saveas(fig2,'Shear Modulus Relaxation 2','tif')
 




% 
%MAXWEL MODEL
Maxwell.a = 285.5;
Maxwell.b = 6393; 
for j = 1:10
g_m= fittype('a*exp(-x/b)');
Maxwell = fit(x,G2new/10^6,g_m,'StartPoint',[Maxwell.a,Maxwell.b])
Maxwell2 = Maxwell.a*exp(-x/Maxwell.b);
end

%ZENER MODEL
Zener.a = 258.6;
Zener.b = 334.9;
Zener.c = 4.34;
for j = 1:10
g = fittype('a+b*exp(-x/c)');
Zener = fit(x,G2new/10^6,g,'StartPoint',[Zener.a,Zener.b,Zener.c])
%
Zener2 = Zener.a+Zener.b*exp(-x/Zener.c);
end

%IMPROVED PARALLEL ZENER MODEL
ZenerParallel.a = 247.4;
ZenerParallel.b = 105.3;
ZenerParallel.c = 7.964;
ZenerParallel.d = 44.82;
ZenerParallel.e = 309.8;
for j = 1:10

g_iz= fittype('a+b*exp(-x/c)+d*exp(-x/e)');

ZenerParallel = fit(x,G2new/10^6,g_iz,'StartPoint',[ZenerParallel.a,ZenerParallel.b,ZenerParallel.c,ZenerParallel.d,ZenerParallel.e])
%
for i=1:length(x)
ZenerParallel2(i) = ZenerParallel.a+ZenerParallel.b*exp(-x(i)/ZenerParallel.c)+ZenerParallel.d*exp(-x(i)/ZenerParallel.e);
end
end


%IMPROVED SERIES ZENER MODEL
ZenerSeries.a = 600.1;
ZenerSeries.b = 1483;
ZenerSeries.c = 287.6;
ZenerSeries.d = 592.5;
ZenerSeries.e = 592.5;
for j = 1:10
g_isz= fittype('1/((1/a)+(1/b)*(1-exp(-x/c))+(1/d)*(1-exp(-x/e)))');
ZenerSeries = fit(x,G2new/10^6,g_isz,'StartPoint',[ZenerSeries.a,ZenerSeries.b,ZenerSeries.c,ZenerSeries.d,ZenerSeries.e])
%
for i=1:length(x)
 ZenerSeries2(i) = 1/((1/ZenerSeries.a)+(1/ZenerSeries.b)*(1-exp(-x(i)/ZenerSeries.c))+(1/ZenerSeries.d)*(1-exp(-x(i)/ZenerSeries.e)));
 
end

end

 t = [0:60:1140]'
Maxwell22 = Maxwell.a*exp(-t/Maxwell.b); 
Zener22 = Zener.a+Zener.b*exp(-t/Zener.c); 
ZenerParallel22 = ZenerParallel.a+ZenerParallel.b*exp(-t/ZenerParallel.c)+ZenerParallel.d*exp(-t/ZenerParallel.e);

n=1;
for t=0:60:1140
 ZenerSeries22(n) = 1/((1/ZenerSeries.a)+(1/ZenerSeries.b)*(1-exp(-t/ZenerSeries.c))+(1/ZenerSeries.d)*(1-exp(-t/ZenerSeries.e)));
 n=n+1;
end
 t = [0:60:1140]'
fig4 = figure; hold on; grid on; set(gca,'FontSize',20);

h=plot(x/60,G2new/10^6,x/60,Maxwell2,'b',t/60,Maxwell22,'bo',x/60,Zener2,'r',t/60,Zener22,'r*',...
    x/60,ZenerParallel2,'g',t/60,ZenerParallel22,'gs',x/60,ZenerSeries2,'m',t/60,ZenerSeries22,'m+')

% h=plot(x/60,G2new/10^6,x/60,ZenerSeries2,t/60,ZenerSeries22,'+')
% h=plot(x/60,G2new/10^6',x/60,Maxwell2,'o-',x/60,Zener2,'*-',x/60,ZenerParallel2,'s-',x/60,ZenerSeries2,'+-')
set(h(1),'color','k','LineStyle','--','linewidth',3);

%        ylim([200 600])
       xlim([0 20])

xlabel('Time (min)'); ylabel('$G_{12}$ (MPa)'); %title('Axial Modulus Relaxation');
legend([h(1) h(3) h(5) h(7) h(9)],{'Experimental Data for $G_{12}$'...
    ,'Maxwell Model Fit Curve for $G_{12}$'...
    ,'Zener Model Fit Curve for $G_{12}$'...
    ,'Paralell Zener Model Fit Curve for $G_{12}$'...
    ,'Series Zener Model Fit Curve for $G_{12}$'})

% title('Relaxation Modulus for the Viscoelastic Models')
saveas(fig4,'G12 Modulus for the Viscoelastic Models','tif')


set(groot, 'Default', struct())   
