
close all
clc
set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');

% filename ='ThermalCreepTestJan31_100micron5cycles.Vibrometer.csv';
% num = csvread(filename);
% 
% timevib = num(1:end,1);
% Disp = num(1:end,2);
% filename ='rearrangedtemperature.txt';
% fileID = fopen(filename);
% C = textscan(fileID,'%s %s %s %s %s'); % we read the file in characters in a cell
% fclose(fileID);
% whos C
% 
% A = C{1,3};
% % Below we convert the relative time to absolute time
% [Y, M, D, H, MN, S] = datevec(A);
% for i =1 : length(H)
%     if H(i)==0|H(i)==1
% D(i)=(24+H(i))*3600+MN(i)*60+S(i);
%     else
% D(i)=(H(i)*3600)+(MN(i)*60)+S(i);
%     end
% end
%  timecam = D-D(1);
% 
% tempcam = str2num(cell2mat(C{1,4}));
% newtempcam=zeros(length(timevib),1);
% Disp_o = 23 %mm 
% Strain = (Disp/Disp_o)*100;
% 
% 
% %we interpolate the temperature respect the time of the vibrometer
% for j=1:length(timevib)
%     
%    i=1; 
%     while newtempcam(j)==0    
%         
%     if timecam(i)<=timevib(j) && timevib(j)<timecam(i+1)
%         
%         newtempcam(j)=(((timevib(j)-timecam(i))*(tempcam(i+1)-tempcam(i)))...
%             /(timecam(i+1)-timecam(i)))+tempcam(i);
%    
%     end
%     i=i+1;
%     end
% end

time = timevib(87160:90600);
temp = newtempcam(87160:90600);
strain=Strain(87160:90600);


   time = time(1:5:length(time));
   temp = temp(1:5:length(temp));
   strain = strain(1:5:length(strain));

 

fig3=figure; hold on; grid on; set(gca,'FontSize',20);

left_color = [.5 .5 0];
right_color = [0 0 0];

set(fig3,'defaultAxesColorOrder',[left_color; right_color]);

yyaxis left;
H1 = plot(time/60,temp)
ylabel('Temperature $$(^{\circ}$$C)')
yyaxis right;
H2 = plot(time/60,strain)
ylabel('Axial Thermal Strain, $$\varepsilon^t_{11}\hspace{1.5mm}(\%)$$')
xlabel('Time (min)')

legend('Temperature','Axial Thermal Strain')


x=time;

% 
%MAXWEL MODEL
Maxwell.a = 285.5;
Maxwell.b = 6393; 
for j = 1:10
g_m= fittype('a*exp(-x/b)');
Maxwell = fit(x,strain,g_m,'StartPoint',[Maxwell.a,Maxwell.b]);
Maxwell2 = Maxwell.a*exp(-x/Maxwell.b);
end

%ZENER MODEL
Zener.a = 258.6;
Zener.b = 334.9;
Zener.c = 4.34;
for j = 1:10
g = fittype('a+b*exp(-x/c)');
Zener = fit(x,strain,g,'StartPoint',[Zener.a,Zener.b,Zener.c]);
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

ZenerParallel = fit(x,strain,g_iz,'StartPoint',[ZenerParallel.a,ZenerParallel.b,ZenerParallel.c,ZenerParallel.d,ZenerParallel.e])
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
ZenerSeries = fit(x,strain,g_isz,'StartPoint',[ZenerSeries.a,ZenerSeries.b,ZenerSeries.c,ZenerSeries.d,ZenerSeries.e]);
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

h=plot(x/60,strain,x/60,Maxwell2,'b',t/60,Maxwell22,'bo',x/60,Zener2,'r',t/60,Zener22,'r*',...
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
