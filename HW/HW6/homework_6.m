% Student name: UNAL FARUK
% Student ID : LS1925224

%HW5-1
%Q-1
fileID = fopen('My_file.txt','r');
txtSplitted = textscan(fileID,'%d %f %d',29,'Delimiter',',');
fclose(fileID);

x_val=txtSplitted{2};
y_val=double(txtSplitted{3});

%Q-2
[slope,intercept,corr_me]=LS_line(x_val,y_val);

%Q-3
corr_builtin=corr(x_val,y_val);

%Q-4
figure;
title('Graph for Question 5')
scatter(x_val,y_val);
hold on;
y_line=slope*x_val+intercept;
plot(x_val,y_line);

%Q-5
%Create the arrays
ser = 1:29;
x_2_arr=x_val.^2;
y_2_arr=y_val.^2;
x_y=x_val.*y_val;

%Concate them to write into file in once
table = cat(2,ser',x_val,y_val,x_2_arr,y_2_arr,x_y);
fclose('all');
fileID = fopen('Complete_data_File.txt','w');
fprintf(fileID,'%6s %15s %15s %15s %15s %15s\n','Sr.','X','Y','X^2','Y^2','X*Y');
fprintf(fileID,'%6d %15.4f %15d %15.5f %15d %15.3f\n',table');
fclose(fileID);


%%FUNCTIONS

function out = my_slope(x_arr,y_arr)    
    eq_1_1=0; %sum(x*y)
    for n=1:length(x_arr)
        eq_1_1=eq_1_1+(x_arr(n)*y_arr(n));
    end
    
    eq_1_2=0; %sum(x)
    for n=1:length(x_arr)
        eq_1_2=eq_1_2+x_arr(n);
    end
    
    eq_2_1=0; %sum(x^2)
    for n=1:length(x_arr)
        eq_2_1=eq_2_1+(x_arr(n)^2);
    end
    
    eq_2_2=eq_2_1;
    
    %Instead of using 'mean', we can calculate it using a loop but it takes
    %more time so I use this func.
    y_mean=mean(y_arr);
    x_mean=mean(x_arr);
    
    out=(eq_1_1 - (eq_1_2*y_mean))/(eq_2_1-(eq_2_2*x_mean));
    
end

function out = my_intercept(x_arr,y_arr,slope)    
    %Instead of using 'mean', we can calculate it using a loop but it takes
    %more time so I use this func.
    y_mean=mean(y_arr);
    x_mean=mean(x_arr);    
    out=y_mean - slope*x_mean;
end

%For this function I use the equation in https://www.socscistatistics.com/tests/pearson/ 
%as a reference.
function out = my_corr(x_arr,y_arr)
    mX=mean(x_arr);
    mY=mean(y_arr);
    
    %sum(x-m(x)*y-m(y))
    sum_xy_mxmy=0;
    for n=1:length(x_arr)
        sum_xy_mxmy=sum_xy_mxmy+((x_arr(n)-mX)*(y_arr(n)-mY));
    end
    
    %sum(x^2)
    sum_x_2=0;
    for n=1:length(x_arr)
        sum_x_2=sum_x_2+(x_arr(n)-mX)^2;
    end
    
    %sum(y^2)
    sum_y_2=0;
    for n=1:length(y_arr)
        sum_y_2=sum_y_2+(y_arr(n)-mY)^2;
    end
    
    out=sum_xy_mxmy/(sqrt(sum_x_2)*sqrt(sum_y_2));
end

function [out_slope,out_intercept,out_corr] = LS_line(x_arr,y_arr)
    out_slope = my_slope(x_arr,y_arr);
    out_intercept = my_intercept(x_arr,y_arr,out_slope);
    out_corr = my_corr(x_arr,y_arr);
end