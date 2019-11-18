% Student name: UNAL FARUK
% Student ID : LS1925224

%HW4-1
%Q-1
fileName="BJAvgTemp.txt";
fid = fopen(fileName, 'wt');

seasons=["Spring","","Summer","","","Autumn","","Winter","","","",""];
months=["Apr","May","June","July","Aug","Sept","Oct","Nov","Dec","Jan","Feb","Mar"];
temp_c=[13,18,25,28,26,26,14,6,-2,-4,-3,5];
temp_f=[55.4,64.4,77,82.4,78.8,78.8,57.2,42.8,28.4,24.8,26.6,41];

if fid ~= -1
  fprintf(fid, 'Beijing Average Temperature\n');
  fprintf(fid,sprintf('%s%25s%25s%25s\n','SEASON','MONTHS','TEMP(CENTIGRADE)','TEMP(FAHR)'));
  for row = 1 : 12
      if seasons(row)==""
          fprintf(fid,sprintf('%s\t%25s%25d%25f\n',seasons(row),months(row),temp_c(row),temp_f(row)));
      else
          fprintf(fid,sprintf('%s:%22s%25d%25f\n',seasons(row),months(row),temp_c(row),temp_f(row)));
      end
  end
  fclose(fid);
end

%Q-2
fid = fopen("BJAvgTemp.txt");
tline = fgetl(fid);
while ischar(tline)
    disp(tline)
    tline = fgetl(fid);
end

%HW4-2
%Q-1
fclose('all');
status_rm=rmdir("MyFiles",'s');
status_mk=mkdir("MyFiles");

%Q-2
P = @(k,n,p) binopdf(k,n,p);
for p=0.1:0.1:0.9
    fileName=sprintf("MyFiles/Binary_%i.dat",round(p*10));
    fid = fopen(fileName, 'wt');
    for k=0:1:5
        fprintf(fid, sprintf('%f\n',P(k,5,p)));
    end
    fclose(fid);
end

%Q-3
% Get all PDF files in the current folder
files = dir('MyFiles/*.dat');
% Loop through each file to change their names
for id = 1:length(files)
    % Get the file name 
    [~, f,ext] = fileparts(files(id).name);
    splittedName=strsplit(f,"_");
    rename = strcat('MyFiles/newfile_',splittedName(2),'.dat');
    movefile(string(strcat('MyFiles/',files(id).name)), string(rename),'f');
end

%Q-3
for i = 1:9
    % Get the file name
    fileName_loop = strcat('MyFiles/newfile_',string(i),'.dat');    
    fid_loop = fopen(fileName_loop);
    tline_loop=fgetl(fid_loop);
    lastMaxNumber=str2double(tline_loop);
    while ischar(tline_loop)
        tline_loop = str2double(fgetl(fid_loop));
        if tline_loop > lastMaxNumber
            lastMaxNumber = tline_loop;
        end
    end
    fileName_forMax = strcat('MyFiles/Max_',string(i),'.txt');
    fid_forMax = fopen(fileName_forMax, 'wt');
    fprintf(fid_forMax, sprintf('%f',lastMaxNumber));
    fclose(fid_forMax);
end

%Q-4
maxNumbers_array=[];
for i=1:9
   fileName_forMax = strcat('MyFiles/Max_',string(i),'.txt');
   fid_forMax = fopen(fileName_forMax);
   tline_forMax=fgetl(fid_forMax);
   maxNumbers_array=[maxNumbers_array str2double(tline_forMax)];
   fclose(fid_forMax);
end

%Q-5
maxNumbers_sorted=maxNumbers_array;
theLastMin=-999;
for i=1:9
    for k=i:9
        if maxNumbers_sorted(k)<maxNumbers_sorted(i)
            temp=maxNumbers_sorted(i);
            maxNumbers_sorted(i)=maxNumbers_sorted(k);
            maxNumbers_sorted(k)=temp;
        end
    end
end

%Q-6
writematrix(maxNumbers_sorted,'MyFiles/sorted.txt')
