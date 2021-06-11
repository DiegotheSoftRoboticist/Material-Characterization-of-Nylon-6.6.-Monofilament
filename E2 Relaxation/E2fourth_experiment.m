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
filename = 'E2 Relaxation test (1).xls';
sheet = 'Stress relaxation - 2';
rheom_data1 = xlsread(filename,sheet,'B:C');
    time_F1 = rheom_data1(:,1);
    Force1 = rheom_data1(:,2); % N
scope_data1 = xlsread(filename,sheet,'G:H');
    b1 = 1/2*scope_data1(:,2); % mm
    time_b1 = scope_data1(:,1);
%SECOND CYCLE
filename = 'E2 Relaxation test (2).xls';
sheet = 'Stress relaxation - 2';
rheom_data2 = xlsread(filename,sheet,'B:C');
    time_F2 = rheom_data2(:,1);
    Force2 = rheom_data2(:,2); % N
scope_data2 = xlsread(filename,sheet,'G:H');
    b2 = 1/2*scope_data2(:,2); % mm
    time_b2 = scope_data2(:,1);

%THIRD CYCLE
filename = 'E2 Relaxation test (3).xls';
sheet = 'Stress relaxation - 2';
rheom_data3 = xlsread(filename,sheet,'B:C');
    time_F3 = rheom_data3(:,1);
    Force3 = rheom_data3(:,2); % N
scope_data3 = xlsread(filename,sheet,'G:H');
    b3 = 1/2*scope_data3(:,2); % mm
    time_b3 = scope_data3(:,1);

%FOURTH CYCLE
filename = 'E2 Relaxation test (4).xls';
sheet = 'Stress relaxation - 2';
rheom_data4 = xlsread(filename,sheet,'B:C');
    time_F4 = rheom_data4(:,1);
    Force4 = rheom_data4(:,2); % N
scope_data4 = xlsread(filename,sheet,'G:H');
    b4 = 1/2*scope_data4(:,2); % mm
    time_b4 = scope_data4(:,1);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
 L = 5.3; % mm
 D = 0.959; % mm
 
F_int1 = interp1(time_F1,Force1,time_b1); % interpolated patch width at rheometer times
F_int2 = interp1(time_F2,Force2,time_b2); % interpolated patch width at rheometer times
F_int3 = interp1(time_F3,Force3,time_b3); % interpolated patch width at rheometer times
F_int4 = interp1(time_F4,Force4,time_b4); % interpolated patch width at rheometer times

E2_1 = 2*D*F_int1./(pi*L*b1.^2);
E2_2 = 2*D*F_int2./(pi*L*b2.^2);
E2_3 = 2*D*F_int3./(pi*L*b3.^2);
E2_4 = 2*D*F_int4./(pi*L*b4.^2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%     sigma1 = -(Force1/5.3)/sqrt(1+i^2/
    
    
fig1 = figure; hold on; grid on; set(gca,'FontSize',14);
plot(time_b1/60,E2_1,time_b2/60,E2_2,time_b3/60,E2_3,time_b4/60,E2_4);
xlabel('Time (min)'); ylabel('$E_2$ (MPa)'); %title('Transverse Modulus Relaxation');
legend('First Cycle','Second Cycle','Third Cycle','Fourth Cycle')

fig2 = figure; hold on; grid on; set(gca,'FontSize',14);
plot(time_b1/60,2*b1,time_b2/60,2*b2,time_b3/60,2*b3,time_b4/60,2*b4);
xlabel('Time (min)'); ylabel('$2b$ (mm)'); %title('Patch width as a function of time');
legend('First Cycle','Second Cycle','Third Cycle','Fourth Cycle','Location','Southwest')

fig3 = figure; hold on; grid on; set(gca,'FontSize',14);
plot(time_b1/60,F_int1,time_b2/60,F_int2,time_b3/60,F_int3,time_b4/60,F_int4);
xlabel('Time (min)'); ylabel('$Force$ (Newton)'); %title('Compression force as a function of time');
legend('First Cycle','Second Cycle','Third Cycle','Fourth Cycle')

set(groot, 'Default', struct()) 

