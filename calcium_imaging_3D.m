close all;
clear;
clc;

%%
addpath(pwd);

%%
global  odor_seq  image_times;

if exist('pathname', 'var')
        try
            if isdir(pathname)
            cd(pathname);
            end
        end
end
[filename,pathname]  = uigetfile({'*.nd2'});  
   
fname = [pathname filename];
 
if ~exist('data','var')
     data=bfopen(fname);   
end
 
[num_series,~]=size(data);
 
if ~exist('z','var')
    
    z=input('Please enter start and end z sections you want to analyze:','s');
    z=str2num(z);
    zplane=z(1):z(2);
        
end

if ~exist('frames','var')   
    frames=input('Please enter start and end frames for analyzing the data:','s');
    frames=str2num(frames);
end

istart=frames(1);
iend=frames(2);
num_t=iend-istart+1; %number of time series

%% load the log file
disp('Choose the log file of this experiment.');
[filename_log]  =  uigetfile([pathname, 'log_*.txt']);
fname_log = [pathname filename_log];

% number of lines
fid = fopen(fname_log);
allText = textscan(fid,'%s','delimiter','\n');
fclose(fid);

% strain name
numberOfLines = length(allText{1});
neuron_type = allText{1,1}{1,1};

% the odor information
num_ = 3;
odor_inf = cell(numberOfLines-num_, 2);
fmt='%s\t %d\t';
for i = 1:numberOfLines-num_
    odor_inf(i, :) = textscan(allText{1,1}{i+num_,1}, ...
        fmt, 'Delimiter','\t');
end

%%
if (num_series==1)
    imagelist=data{1,1};
    [m,n]=size(imagelist{1,1});
    disp(imagelist{1,2});
    mcherry=0;
    disp('the stack does not have red channels');
else
    mcherry=1;
    imagelist=data{1,1};
    [m,n]=size(imagelist{1,1});
    disp('the stack has red channels');
end

% if ~exist('num_z','var')
%     num_z=input('Please enter the total number of z sections in the data set:','s');
%     num_z=str2double(num_z); 
% end


%figure out the totle number of z sections, to replace the input of this information
image_inf = data{1}{1,2};

% number of channels
if isempty(strfind(image_inf, 'C=1/'))
    num_c = 1;
else
    c_start = strfind(image_inf, 'C=1/');
    c_end   = strfind(image_inf, '; T=1/');
    num_c = str2double(image_inf(c_start+4 : c_end-1));
end

% select the number of channel
if num_c ~= 1
    channel = input('Please enter the channel for analyzing the data:','s');
    channel_num = str2num(channel);
else
    channel_num = 1;
end



%number of z section
z_start = strfind(image_inf, 'Z=1/');

if isempty(strfind(image_inf, 'C=1/'))
    z_end   = strfind(image_inf, '; T=1/');
else
    z_end   = strfind(image_inf, '; C=1/');
end

if isempty(z_start)
    num_z = 1;
else
    num_z = str2double(image_inf(z_start+4 : z_end-1));
end



if ~exist('img_stack_maxintensity','var')
    
    img_stack_maxintensity=zeros(m,n,num_t); %maximum intensity projection stack along z 

    for i=istart:iend
        
        k=i-istart+1;
        
        img_stack=zeros(m,n,length(zplane));
                    
        for j=1:length(zplane)
            
            if ~mcherry
                if isempty(z_start)
                    img_stack(:,:,j)=imagelist{i, 1};
                else
                    img_stack(:,:,j)=imagelist{(i-1)*num_z*num_c + num_c*(zplane(j)-1) + channel_num,1};
                end
                
            else
                
                imagelist=data{zplane(j),1};
                %img_stack(:,:,j)=imagelist{2*i-1,1};
                img_stack(:,:,j)=imagelist{i,1};
            end
            
        end
    
        img_stack_maxintensity(:,:,k)=max(img_stack,[],3);
    
    end
    
end


%% Added by Guangwei 12/06/2013, to get the time information of each frame.
metadata = data{2};

image_times = zeros(num_t,1);

for i=istart:iend

    j = i-istart+1;

    index = j*num_z - 1;
    image_times(j) = metadata.get(['timestamp ' num2str(index)]);
end


%% get the odor sequence
odor_seq = getodorseq( image_times,  odor_inf);

return;
