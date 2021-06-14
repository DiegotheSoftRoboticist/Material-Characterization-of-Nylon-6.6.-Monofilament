 
clear
clc
close all

filename = '100g_5cycles_parallel_no_header.csv';
num100p = csvread(filename);
time_100p_raw = num100p(:,1);
disp_100p_raw = num100p(:,2); %this is in mm
rot_100p_raw = disp_100p_raw/3*180/pi;
temp_amb_100p_raw = num100p(:,3);
temp_100p_raw = num100p(:,4);
%This gets all the data on 0.01 dt
time_100p = 0:0.01:max(time_100p_raw);
disp_100p = interp1(time_100p_raw,disp_100p_raw,time_100p);
rot_100p  = interp1(time_100p_raw,rot_100p_raw, time_100p);
temp_100p = interp1(time_100p_raw,temp_100p_raw,time_100p);
%This reshapes the data into rows of 10 so I then can average each row to
%do a moving average every 0.1 s
clip_100p = 1+sum(time_100p*10>floor(max(time_100p)*10));
time_100p_mat = reshape(time_100p(1:end-clip_100p),10,length(time_100p(1:end-clip_100p))/10)';
disp_100p_mat = reshape(disp_100p(1:end-clip_100p),10,length(disp_100p(1:end-clip_100p))/10)';
rot_100p_mat  = reshape(rot_100p(1:end-clip_100p),10,length(rot_100p(1:end-clip_100p))/10)';
temp_100p_mat = reshape(temp_100p(1:end-clip_100p),10,length(temp_100p(1:end-clip_100p))/10)';
%This gets the averages for each 0.1 seconds using the previous 10 0.01 dts
time_100p_av = time_100p_mat(:,1);%the measurement at each instant will be the average over the previous 0.01 s
disp_100p_av = [disp_100p(1,1);mean(disp_100p_mat')'];disp_100p_av = disp_100p_av(1:end-1);
rot_100p_av  = [rot_100p(1,1) ;mean(rot_100p_mat')'] ;rot_100p_av = rot_100p_av(1:end-1);
temp_100p_av = [temp_100p(1,1);mean(temp_100p_mat')'];temp_100p_av = temp_100p_av(1:end-1);


filename = '300g_5cycles_parallel_T3_no_header.csv';
num300p = csvread(filename);
time_300p_raw = num300p(:,1);
disp_300p_raw = num300p(:,2); %this is in mm
rot_300p_raw = disp_300p_raw/3*180/pi;
temp_amb_300p_raw = num300p(:,3);
temp_300p_raw = num300p(:,4);
%This gets all the data on 0.01 dt
time_300p = 0:0.01:max(time_300p_raw);
disp_300p = interp1(time_300p_raw,disp_300p_raw,time_300p);
rot_300p  = interp1(time_300p_raw,rot_300p_raw, time_300p);
temp_300p = interp1(time_300p_raw,temp_300p_raw,time_300p);
%This reshapes the data into rows of 10 so I then can average each row to
%do a moving aberage every 0.1 s
%Need to clip the last 0.03 s to get the right number of elements
clip_300p = 1+sum(time_300p*10>floor(max(time_300p)*10));
time_300p_mat = reshape(time_300p(1:end-clip_300p),10,length(time_300p(1:end-clip_300p))/10)';
disp_300p_mat = reshape(disp_300p(1:end-clip_300p),10,length(disp_300p(1:end-clip_300p))/10)';
rot_300p_mat  = reshape(rot_300p(1:end-clip_300p),10,length(rot_300p(1:end-clip_300p))/10)';
temp_300p_mat = reshape(temp_300p(1:end-clip_300p),10,length(temp_300p(1:end-clip_300p))/10)';
%This gets the averages for each 0.1 seconds using the previous 10 0.01 dts
time_300p_av = time_300p_mat(:,1);%the measurement at each instant will be the average over the previous 0.01 s
disp_300p_av = [disp_300p(1,1);mean(disp_300p_mat')'];disp_300p_av = disp_300p_av(1:end-1);
rot_300p_av  = [rot_300p(1,1) ;mean(rot_300p_mat')'] ;rot_300p_av = rot_300p_av(1:end-1);
temp_300p_av = [temp_300p(1,1);mean(temp_300p_mat')'];temp_300p_av = temp_300p_av(1:end-1);


set(groot, 'DefaultTextInterpreter', 'LaTeX', ...
           'DefaultAxesTickLabelInterpreter', 'LaTeX', ...
           'DefaultAxesFontName', 'LaTeX', ...
           'DefaultLegendInterpreter', 'LaTeX', ...
           'defaultFigureColor','w');


% fig=figure; hold on; grid on; set(gca,'FontSize',14);
% 
% left_color = [.5 .5 0];
% right_color = [0 0 0];
% set(fig,'defaultAxesColorOrder',[left_color; right_color]);
% 
% [AX1,H1,H2] = plotyy(time_100p_av/60,rot_100p_av-rot_100p_av(1),time_100p_av/60,temp_100p_av);
% 
% xlabel(AX1(1),'Time (min)','FontSize',14)
% ylabel(AX1(2),'Absolute temperature$$(^{\circ}C)$$','FontSize',14)
% ylabel(AX1(1),' $$\Delta \phi~~ (^\circ)$$','FontSize',14)
% 
% ylim(AX1(1),[0 40])
% ylim(AX1(2),[0 120])
% AX1(1).YTick = [0:5:40];
% AX1(2).YTick = [0:20:120];
% AX1(1).XLim = [0 2500/60];
% AX1(2).XLim = [0 2500/60];

fig=figure; hold on; grid on; set(gca,'FontSize',20);

yyaxis right;
H1 = plot(time_100p_av/60,rot_100p_av-rot_100p_av(1))
ylabel('$$\Delta \phi~~ (^\circ)$$')
ylim([0 40])
yyaxis left;
H2 = plot(time_100p_av/60,temp_100p_av)
ylabel('Temperature ($$^{\circ}$$C)')
ylim([0 120])
xlabel('Time (min)')
xlim([0 35])
% title('0.883 N-mm Preload Torque')
%legend('Rotation','Temperature','Location','Northwest')
grid on 
legend('Temperature','Rotation 2.94 N-mm Preload Torque','Location','Southeast')


% fig1=figure; hold on; grid on; set(gca,'FontSize',14);
% 
% left_color = [.5 .5 0];
% right_color = [0 0 0];
% set(fig1,'defaultAxesColorOrder',[left_color; right_color]);
% 
% [AX1,H1,H2] = plotyy(time_300p_av/60,rot_300p_av-rot_300p_av(1),time_300p_av/60,temp_300p_av);
% 
% xlabel(AX1(1),'Time (min)','FontSize',14)
% ylabel(AX1(2),'Absolute temperature$$(^{\circ}C)$$','FontSize',14)
% ylabel(AX1(1),' $$\Delta \phi~~ (^\circ)$$','FontSize',14)
% 
% ylim(AX1(1),[-10 5])
% ylim(AX1(2),[0 120])
% AX1(1).YTick = [-10:2:5];
% AX1(2).YTick = [0:20:120];
% AX1(1).XLim = [0 2050/60];
% AX1(2).XLim = [0 2050/60];
% title('0.883 N-mm Preload Torque')
%legend('Rotation','Temperature','Location','Northwest')
fig=figure; hold on; grid on; set(gca,'FontSize',20);

yyaxis right;
H1 = plot(time_300p_av/60,rot_300p_av-rot_300p_av(1))
ylabel('$$\Delta \phi~~ (^\circ)$$')
ylim([-15 5])
yyaxis left;
H2 = plot(time_300p_av/60,temp_300p_av)
ylabel('Temperature ($$^{\circ}$$C)')
ylim([0 120])
xlabel('Time (min)')
xlim([0 35])


grid on 
legend('Temperature','Rotation 8.83 N-mm Preload Torque','Location','Southeast')



fig2=figure; hold on; grid on; set(gca,'FontSize',20);

plot(temp_100p_av,rot_100p_av-rot_100p_av(1),'LineStyle','--'); hold on
plot(temp_300p_av,rot_300p_av-rot_300p_av(1),'Color','k'); hold on

xlabel('Temperature ($$^{\circ}$$C)','FontSize',20)
ylabel('$$\Delta \phi~~ (^\circ)$$','FontSize',20)

legend('2.94 N-mm Preload Torque','8.83 N-mm Preload Torque','Location','Northwest')
grid on
ylim([-20 38])
xlim([20 105])
% saveas(fig_rot_v_temp,'ROT_V_TEMP_100300P','tif')

