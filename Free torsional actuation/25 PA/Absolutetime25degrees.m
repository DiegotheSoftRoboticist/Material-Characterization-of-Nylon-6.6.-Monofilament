
close all
clear all
clc

filename ='ActuationTestFeb1818_15PA.csv';
num = csvread(filename);
    timerhe = num(1:end,1);

filename ='Actuation 15PA Feb18_18.txt';
fileID = fopen(filename);
    C = textscan(fileID,'%s %s %s %s %s'); % we read the file in characters in a cell
    fclose(fileID);
    whos C

A = C{1,3};
% Below we convert the relative time to absolute time
[Y, M, D, H, MN, S] = datevec(A);
for i =1 : length(H)
    if H(i)==0|H(i)==1
D(i)=(24+H(i))*3600+MN(i)*60+S(i);
    else
D(i)=(H(i)*3600)+(MN(i)*60)+S(i);
    end
end
 timecam = D-D(1);

tempcam = str2num(cell2mat(C{1,4}));
newtempcam=zeros(length(timerhe),1);



%we interpolate the temperature respect the time of the vibrometer
for j=1:length(timerhe)
    
   i=1; 
    while newtempcam(j)==0    
        
    if timecam(i)<=timerhe(j) && timerhe(j)<timecam(i+1)
        
        newtempcam(j)=(((timerhe(j)-timecam(i))*(tempcam(i+1)-tempcam(i)))...
            /(timecam(i+1)-timecam(i)))+tempcam(i);
   
    end
    i=i+1;
    end
end

filename1 = 'Matched camare temperature with the rheometer 15 degrees.xlsx'
xlswrite(filename1,newtempcam)