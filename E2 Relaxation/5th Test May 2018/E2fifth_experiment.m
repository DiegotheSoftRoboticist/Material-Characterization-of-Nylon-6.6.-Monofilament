% Calculate E2 third test. Stress relaxation is taken into account.

clc
close all
clear all
set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');
       

% Retrieve Data
%FIRST CYCLE
filename = 'E2 Relaxation.xls';
sheet = 'Stress relaxation - 2';
rheom_data1 = xlsread(filename,sheet,'B:C');
    time_F1 = rheom_data1(:,1);
    Force1 = rheom_data1(:,2); % N
scope_data1 = xlsread(filename,sheet,'G:H');
    b1 = 1/2*scope_data1(:,2); % mm
    time_b1 = scope_data1(:,1);
%SECOND CYCLE
filename = 'E2 Relaxation (1).xls';
sheet = 'Stress relaxation - 2';
rheom_data2 = xlsread(filename,sheet,'B:C');
    time_F2 = rheom_data2(:,1);
    Force2 = rheom_data2(:,2); % N
scope_data2 = xlsread(filename,sheet,'G:H');
    b2 = 1/2*scope_data2(:,2); % mm
    time_b2 = scope_data2(:,1);

%THIRD CYCLE
filename = 'E2 Relaxation (2).xls';
sheet = 'Stress relaxation - 2';
rheom_data3 = xlsread(filename,sheet,'B:C');
    time_F3 = rheom_data3(:,1);
    Force3 = rheom_data3(:,2); % N
scope_data3 = xlsread(filename,sheet,'G:H');
    b3 = 1/2*scope_data3(:,2); % mm
    time_b3 = scope_data3(:,1);

%FOURTH CYCLE
filename = 'E2 Relaxation (3).xls';
sheet = 'Stress relaxation - 2';
rheom_data4 = xlsread(filename,sheet,'B:C');
    time_F4 = rheom_data4(:,1);
    Force4 = rheom_data4(:,2); % N
scope_data4 = xlsread(filename,sheet,'G:H');
    b4 = 1/2*scope_data4(:,2); % mm
    time_b4 = scope_data4(:,1);
    
 %FITH CYCLE
filename = 'E2 Relaxation (4).xls';
sheet = 'Stress relaxation - 2';
rheom_data5 = xlsread(filename,sheet,'B:C');
    time_F5 = rheom_data5(:,1);
    Force5 = rheom_data5(:,2); % N
scope_data5 = xlsread(filename,sheet,'G:H');
    b5 = 1/2*scope_data5(:,2); % mm
    time_b5 = scope_data5(:,1);   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
 L = 6.75; % mm
 D = 0.975; % mm
 
F_int1 = interp1(time_F1,Force1,time_b1); % interpolated patch width at rheometer times
F_int2 = interp1(time_F2,Force2,time_b2); % interpolated patch width at rheometer times
F_int3 = interp1(time_F3,Force3,time_b3); % interpolated patch width at rheometer times
F_int4 = interp1(time_F4,Force4,time_b4); % interpolated patch width at rheometer times
F_int5 = interp1(time_F5,Force5,time_b5); % interpolated patch width at rheometer times

E2_1 = 2*D*F_int1./(pi*L*b1.^2);
E2_2 = 2*D*F_int2./(pi*L*b2.^2);
E2_3 = 2*D*F_int3./(pi*L*b3.^2);
E2_4 = 2*D*F_int4./(pi*L*b4.^2);
E2_5 = 2*D*F_int5./(pi*L*b5.^2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%     sigma1 = -(Force1/5.3)/sqrt(1+i^2/
    
    
fig1 = figure; hold on; grid on; set(gca,'FontSize',20);
h=plot(time_b1/60,E2_1,time_b2/60,E2_2,time_b3/60,E2_3,time_b4/60,E2_4,time_b5/60,E2_5);
xlabel('Time (min)'); ylabel('$E_2$ (MPa)'); %title('Transverse Modulus Relaxation');
legend('First Cycle','Second Cycle','Third Cycle','Fourth Cycle','Fifth Cycle')
set(h(1),'linewidth',2);
set(h(2),'linewidth',2);
set(h(3),'linewidth',2);
set(h(4),'linewidth',2);
set(h(5),'linewidth',2);



fig2 = figure; hold on; grid on; set(gca,'FontSize',20);
plot(time_b1/60,2*b1,time_b2/60,2*b2,time_b3/60,2*b3,time_b4/60,2*b4,time_b5/60,2*b5);
xlabel('Time (min)'); ylabel('$2b$ (mm)'); %title('Patch width as a function of time');
legend('First Cycle','Second Cycle','Third Cycle','Fourth Cycle','Fifth Cycle','Location','Southwest')

fig3 = figure; hold on; grid on; set(gca,'FontSize',20);
plot(time_b1/60,F_int1,time_b2/60,F_int2,time_b3/60,F_int3,time_b4/60,F_int4,time_b5/60,F_int5);
xlabel('Time (min)'); ylabel('$Force$ (Newton)'); %title('Compression force as a function of time');
legend('First Cycle','Second Cycle','Third Cycle','Fourth Cycle','Fifth Cycle')

x=time_b5;

%MAXWEL MODEL
Maxwell.a = 1;
Maxwell.b = 1; 
for j = 1:5
g_m= fittype('a*exp(-x/b)');
Maxwell = fit(time_b5,E2_5,g_m,'StartPoint',[Maxwell.a,Maxwell.b])
Maxwell2 = Maxwell.a*exp(-x/Maxwell.b);
end

%ZENER MODEL
Zener.a = 1;
Zener.b = 1;
Zener.c = 1;
for j = 1:5
g = fittype('a+b*exp(-x/c)');
Zener = fit(time_b5,E2_5,g,'StartPoint',[Zener.a,Zener.b,Zener.c])
Zener2 = Zener.a+Zener.b*exp(-x/Zener.c);
end

%IMPROVED PARALLEL ZENER MODEL
ZenerParallel.a = 1;
ZenerParallel.b = 1;
ZenerParallel.c = 1;
ZenerParallel.d = 1.4;
ZenerParallel.e = 1;
for j = 1:5

g_iz= fittype('a+b*exp(-x/c)+d*exp(-x/e)');

ZenerParallel = fit(time_b5,E2_5,g_iz,'StartPoint',[ZenerParallel.a,ZenerParallel.b,ZenerParallel.c,ZenerParallel.d,ZenerParallel.e])

for i=1:length(x)
ZenerParallel2(i) = ZenerParallel.a+ZenerParallel.b*exp(-x(i)/ZenerParallel.c)+ZenerParallel.d*exp(-x(i)/ZenerParallel.e);
end
end
% 
%IMPROVED SERIES ZENER MODEL
ZenerSeries.a = 1;
ZenerSeries.b = 1;
ZenerSeries.c = 1;
ZenerSeries.d = 1;
ZenerSeries.e = 1;
for j = 1:5
g_isz= fittype('1/((1/a)+(1/b)*(1-exp(-x/c))+(1/d)*(1-exp(-x/e)))');
ZenerSeries = fit(time_b5,E2_5,g_isz,'StartPoint',[ZenerSeries.a,ZenerSeries.b,ZenerSeries.c,ZenerSeries.d,ZenerSeries.e])
for i=1:length(x)
ZenerSeries2(i) = 1/((1/ZenerSeries.a)+(1/ZenerSeries.b)*(1-exp(-x(i)/ZenerSeries.c))+(1/ZenerSeries.d)*(1-exp(-x(i)/ZenerSeries.e)));

end

end


fig4 = figure; hold on; grid on; set(gca,'FontSize',20);


h=plot(time_b5/60,E2_5',time_b5/60,Maxwell2,'b',time_b5/60,Maxwell2,'bo',time_b5/60,Zener2,'r',time_b5/60,Zener2,'r*'...
    ,time_b5/60,ZenerParallel2,'g',time_b5/60,ZenerParallel2,'gs',time_b5/60,ZenerSeries2,'m',time_b5/60,ZenerSeries2,'m+')
set(h(1),'color','k','LineStyle','--','linewidth',3);


xlabel('Time (min)'); ylabel('$E_2$ (MPa)'); %title('Axial Modulus Relaxation');
legend([h(1) h(3) h(5) h(7) h(9)],{'Experimental Data for $E_2$',...
    'Maxwell Model Fit Curve for $E_2$',...
    'Zener Model Fit Curve for $E_2$',...
    'Paralell Zener Model Fit Curve for $E_2$',...
    'Series Zener Model Fit Curve for $E_2$'})

% title('Relaxation Modulus for the Viscoelastic Models')
saveas(fig4,'E2 Modulus for the Viscoelastic Models','tif')

set(groot, 'Default', struct()) 
