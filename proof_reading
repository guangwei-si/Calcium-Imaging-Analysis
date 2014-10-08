function varargout = proof_reading(varargin)
%several inputs:
%1. image stack
%2. 

% PROOF_READING MATLAB code for proof_reading.fig
%      PROOF_READING, by itself, creates a new PROOF_READING or raises the existing
%      singleton*.
%
%      H = PROOF_READING returns the handle to a new PROOF_READING or the handle to
%      the existing singleton*.
%
%      PROOF_READING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROOF_READING.M with the given input arguments.
%
%      PROOF_READING('Property','Value,...) creates a new PROOF_READING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before proof_reading_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to proof_reading_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help proof_reading

% Last Modified by GUIDE v2.5 07-May-2014 21:21:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @proof_reading_OpeningFcn, ...
                   'gui_OutputFcn',  @proof_reading_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before proof_reading is made visible.
function proof_reading_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to proof_reading (see VARARGIN)

% Choose default command line output for proof_reading

handles.img_stack=varargin{1};
handles.transformation_array=varargin{2};
handles.filename=varargin{3};
handles.istart=varargin{4};
handles.iend=varargin{5};
handles.image_times = varargin{6};
handles.odor_seq = varargin{7};

[height,width,sections]=size(handles.img_stack);
handles.image_width=width;
handles.image_height=height;
handles.image_depth=handles.iend-handles.istart+1;
handles.sections=sections;
width=round(width*1.25);
height=round(height*1.25);
set(hObject,'Units','pixels');
set(handles.figure1, 'Position', [400 400 width height+45]);
set(handles.slider1, 'Position', [0 2 width 18]);
axes(handles.axes1);
handles.low=0;
handles.high=500;
handles.tracking_threshold=40;
handles.search_radius = 0;
img=imagesc(handles.img_stack(:,:,handles.istart),[handles.low handles.high]);
colormap(gray);
set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [0 22 width height]);
set(handles.text1, 'Units','pixels');
set(handles.text1, 'Position',[0 22+height+2 width 18]);
set(handles.text1, 'HorizontalAlignment','center');
set(handles.text1, 'String',strcat(num2str(handles.istart),'/',num2str(sections),'(',handles.filename,')'));
set(img,'ButtonDownFcn', 'proof_reading(''ButtonDown_Callback'',gcbo,[],guidata(gcbo))');

handles.neuron_number=varargin{8};
handles.colorset=varycolor(handles.neuron_number);
%initialize neuronal position;
if length(varargin)==9
    handles.neuronal_position=varargin{9};
    handles.isproofread=ones(handles.image_depth,1);
else
    handles.isproofread=zeros(handles.image_depth,1);
    handles.neuronal_position=cell(handles.iend-handles.istart+1,handles.neuron_number);
end

handles.signal=[];
handles.normalized_signal=[];
handles.ratio=[];
min_step=1/(handles.image_depth-1);
max_step=5*min_step;
set(handles.slider1, ...
    'Enable','on', ...
    'Min',1, ...
    'Max',handles.image_depth, ...
    'Value',1, ...
    'SliderStep', [min_step max_step]);

handles.frame_number=1;


handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes proof_reading wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = proof_reading_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function PlotMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PlotMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)



% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.frame_number=round(get(hObject,'Value'));
set(handles.text1, 'String',strcat(num2str(handles.frame_number+handles.istart-1),'/',num2str(handles.sections),'(',handles.filename,')'));
axes(handles.axes1);
cla;
img=imagesc(handles.img_stack(:,:,handles.frame_number+handles.istart-1),[handles.low handles.high]);
colormap(gray);

set(img,'ButtonDownFcn', 'proof_reading(''ButtonDown_Callback'',gcbo,[],guidata(gcbo))');

for j=1:handles.neuron_number
    if ~isempty(handles.neuronal_position{handles.frame_number,j})
        x=handles.neuronal_position{handles.frame_number,j}(1);
        y=handles.neuronal_position{handles.frame_number,j}(2);
        hold on;  handles.points{j}=rectangle('Curvature',[1,1],'Position',[x-handles.r(j), y-handles.r(j), 2*handles.r(j), 2*handles.r(j)],'EdgeColor',handles.colorset(j,:));
        set(handles.points{j},'ButtonDownFcn', 'proof_reading(''ButtonDownPoint_Callback'',gcbo,[],guidata(gcbo))');
    else
        break;
    end
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% ----click on the axes to identify neuronal positions and update neuronal
% position in rest of the frames ------------------

function ButtonDown_Callback(hObject, eventdata, handles)

handles.isproofread(handles.frame_number)=1;
[x,y]=getcurpt(handles.axes1);

d_min=handles.image_height;

for k=1:handles.neuron_number
    distance=norm(handles.neuronal_position{handles.frame_number,k}-[x y]);
    if distance<d_min
        d_min=distance;
        idx=k;
    end
end

handles.neuronal_position{handles.frame_number,idx}(1)=x;
handles.neuronal_position{handles.frame_number,idx}(2)=y;

if ~isempty(handles.points{idx})
    delete(handles.points{idx});
end

axes(handles.axes1);
hold on;  handles.points{idx}=rectangle('Curvature', [1 1],'Position',[x-handles.r(idx), y-handles.r(idx), 2*handles.r(idx), 2*handles.r(idx)],'EdgeColor',handles.colorset(idx,:));
set(handles.points{idx},'ButtonDownFcn', 'proof_reading(''ButtonDownPoint_Callback'',gcbo,[],guidata(gcbo))');

guidata(hObject,handles);



% ----click on the axes to identify neuronal positions and update neuronal
% position in rest of the frames ------------------

function ButtonDownPoint_Callback(hObject, eventdata, handles)

handles.isproofread(handles.frame_number)=1;
[x,y]=getcurpt(handles.axes1);

d_min=handles.image_height;

for k=1:handles.neuron_number
    distance=norm(handles.neuronal_position{handles.frame_number,k}-[x y]);
    if distance<d_min
        d_min=distance;
        idx=k;
    end
end

handles.neuronal_position{handles.frame_number,idx}(1)=x;
handles.neuronal_position{handles.frame_number,idx}(2)=y;

delete(hObject);

axes(handles.axes1);
hold on;  handles.points{idx}=rectangle('Curvature', [1 1],'Position',[x-handles.r(idx), y-handles.r(idx), 2*handles.r(idx), 2*handles.r(idx)],'EdgeColor',handles.colorset(idx,:));
set(handles.points{idx},'ButtonDownFcn', 'proof_reading(''ButtonDownPoint_Callback'',gcbo,[],guidata(gcbo))');

hObject=handles.points{idx};

guidata(hObject,handles);


% --------------------------------------------------------------------
function SaveMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to SaveMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fn, savepathname]= uiputfile('*.mat', 'choose file to save', strcat(handles.filename, '_',num2str(handles.istart),'-',num2str(handles.iend),'.mat'));
if length(fn) > 1
    fnamemat = strcat(savepathname,fn);
    save(fnamemat);
end
    


% --------------------------------------------------------------------
function ImportMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to ImportMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function ExportMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to ExportMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
assignin('base','signal',handles.signal);
assignin('base','normalized_signal',handles.normalized_signal);
assignin('base','dual_position_data',handles.neuronal_position);
assignin('base','ratio',handles.ratio);
neuron_position_data=zeros(length(handles.neuronal_position),2);
for i=1:length(handles.neuronal_position)
    neuron_position_data(i,:)=handles.neuronal_position{i,1};
end
assignin('base','neuron_position_data',neuron_position_data);
    


% --------------------------------------------------------------------
function ImageMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to ImageMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function LUTMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to LUTMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
answer = inputdlg({'low','high'}, 'Cancel to clear previous', 1, ...
            {num2str(handles.low),num2str(handles.high)});
handles.low=str2double(answer{1});
handles.high=str2double(answer{2});
axes(handles.axes1);
cla;
img=imagesc(handles.img_stack(:,:,handles.frame_number+handles.istart-1),[handles.low handles.high]);
colormap(gray);
set(img,'ButtonDownFcn', 'proof_reading(''ButtonDown_Callback'',gcbo,[],guidata(gcbo))');

guidata(hObject,handles);



% --------------------------------------------------------------------
function TrackingMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to TrackingMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty(handles.neuronal_position{1,1})||(handles.frame_number==1)
    
    axes(handles.axes1);
    text(10,10,'identify neuronal position','Color','r');
    j=1;

    while j<=handles.neuron_number
        rect=getrect;
        rect=round(rect);
        l=rect(3);
        w=rect(4);
        x=rect(1)+l/2;
        y=rect(2)+w/2;
        handles.neuronal_position{1,j}=[x y];
        handles.r(j)=max(l,w)/2; 
        hold on;  handles.points{j}=rectangle('Curvature',[1,1],'Position',[x-handles.r(j), y-handles.r(j), 2*handles.r(j), 2*handles.r(j)],'EdgeColor',handles.colorset(j,:));
        set(handles.points{j},'ButtonDownFcn', 'proof_reading(''ButtonDownPoint_Callback'',gcbo,[],guidata(gcbo))');
        j=j+1;
    end
    
    if handles.search_radius ~=0
        handles.search_radius = mean(handles.r);
    end
   
end

iend=min(handles.image_depth,handles.frame_number+2000);

for j=handles.frame_number+1:iend
    if ~handles.isproofread(j)
        for k=1:handles.neuron_number
            if isempty(handles.transformation_array)
                handles.neuronal_position{j,k}=update_neuron_position(handles.img_stack(:,:,j+handles.istart-1),...
                                                                  handles.neuronal_position{j-1,k},4*handles.search_radius,handles.tracking_threshold);
            else
                shift=handles.transformation_array{j-1+handles.istart-1,2};
                u=handles.neuronal_position{j-1,k}(1)-shift(1);
                v=handles.neuronal_position{j-1,k}(2)-shift(2);
                T=handles.transformation_array{j+handles.istart-1,1};
                [xm,ym] = tformfwd(T,u,v);
                handles.neuronal_position{j,k}(1)=xm;
                handles.neuronal_position{j,k}(2)=ym;
                shift_new=handles.transformation_array{j,2};
                handles.neuronal_position{j,k}=handles.neuronal_position{j,k}+shift_new(1:2);
            end
        end
    else
        break;
    end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function Tracking_thresholdItemMenu_Callback(hObject, eventdata, handles)
% hObject    handle to Tracking_thresholdItemMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
answer = inputdlg({'tracking threshold'}, 'Cancel to clear previous', 1, ...
            {num2str(handles.tracking_threshold)});
        
handles.tracking_threshold=str2double(answer{1});
guidata(hObject,handles);
        


% --------------------------------------------------------------------
function PlotSignalMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PlotSignalMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isempty(handles.neuronal_position{handles.frame_number,1})

for k=1:handles.neuron_number
    GC=zeros(handles.frame_number,1);
    for j=1:handles.frame_number
        x=handles.neuronal_position{j,k}(1);
        y=handles.neuronal_position{j,k}(2);
        c_mask=circle_mask(handles.image_width,handles.image_height,x,y,handles.r(k)); 
        img=handles.img_stack(:,:,j+handles.istart-1);
        img_bw=img(c_mask);
        GC(j)=calculate_intensity(img_bw);
    end
    handles.signal{k}=GC;
%     figure (1);
%     subplot(handles.neuron_number,1,k); 
%     plot(((1:handles.frame_number)+handles.istart-1),smooth(handles.signal{k},1),'Color',handles.colorset(k,:));
%     plot(image_times((1:handles.frame_number)+handles.istart-1),smooth(handles.signal{k},1),'Color',handles.colorset(k,:));
%     xlabel('frame'); ylabel('F (a.u.)');
end

curve_plot(handles.signal, handles.image_times, handles.odor_seq);

guidata(hObject, handles);

end


% --------------------------------------------------------------------
function PlotNSignalMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PlotNSignalMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if ~isempty(handles.neuronal_position{handles.frame_number,1})

for k=1:handles.neuron_number
    GC=zeros(handles.frame_number,1);
    for j=1:handles.frame_number
        x=handles.neuronal_position{j,k}(1);
        y=handles.neuronal_position{j,k}(2);
        c_mask=circle_mask(handles.image_width,handles.image_height,x,y,handles.r(k)); 
        img=handles.img_stack(:,:,j+handles.istart-1);
        img_bw=img(c_mask);
        GC(j)=calculate_intensity(img_bw);
    end
    handles.signal{k}=GC;
%     figure (1);
%     subplot(handles.neuron_number,1,k); 
%     plot(((1:handles.frame_number)+handles.istart-1),smooth(handles.signal{k},1),'Color',handles.colorset(k,:));
%     plot(image_times((1:handles.frame_number)+handles.istart-1),smooth(handles.signal{k},1),'Color',handles.colorset(k,:));
%     xlabel('frame'); ylabel('F (a.u.)');
end

guidata(hObject, handles);

end


if ~isempty(handles.signal)
%     for k=1:handles.neuron_number
%         handles.normalized_signal{k}=(handles.signal{k}-min(handles.signal{k}))/min(handles.signal{k});
%         figure (2);
%         subplot(handles.neuron_number,1,k); 
%         plot(((1:handles.frame_number)+handles.istart-1),handles.normalized_signal{k},'Color',handles.colorset(k,:));
% %         plot(((1:handles.frame_number)+handles.istart-1),smooth(handles.normalized_signal{k},30),'Color',handles.colorset(k,:));
% %         plot(image_times((1:handles.frame_number)+handles.istart-1),smooth(handles.normalized_signal{k},30),'Color',handles.colorset(k,:));
%         xlabel('frame'); ylabel('\delta F/F');
%     end
    
    handles.normalized_signal = nm_signal(handles.signal, handles.odor_seq);
    
    curve_plot(handles.normalized_signal, handles.image_times, handles.odor_seq);
end

guidata(hObject,handles);



% --------------------------------------------------------------------
function PlotRatioMenu_Callback(hObject, eventdata, handles)
% hObject    handle to PlotRatioMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (handles.neuron_number==2)&&(~isempty(handles.signal))
    handles.ratio=handles.signal{1}./(handles.signal{2}-0.18*handles.signal{1});
    normalized_ratio=(handles.ratio-min(handles.ratio))/min(handles.ratio);
    figure (3);  
    plot((1:handles.frame_number)+handles.istart-1,smooth(normalized_ratio,30));
%     plot(image_times((1:handles.frame_number)+handles.istart-1),smooth(normalized_ratio,30));
    xlabel('frame number'); ylabel('\delta R/R');
end

guidata(hObject,handles);


% --------------------------------------------------------------------
function Search_radiusMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to Search_radiusMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
answer = inputdlg({'search radius'}, 'Cancel to clear previous', 1, ...
            {num2str(handles.search_radius)});
        
handles.search_radius=str2double(answer{1});
guidata(hObject,handles);


% --------------------------------------------------------------------
function PlotTotalIntensity_Callback(hObject, eventdata, handles)
% hObject    handle to PlotTotalIntensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isempty(handles.neuronal_position{handles.frame_number,1})

for k=1:handles.neuron_number
    GC=zeros(handles.frame_number,1);
    for j=1:handles.frame_number
        x=handles.neuronal_position{j,k}(1);
        y=handles.neuronal_position{j,k}(2);
        c_mask=circle_mask(handles.image_width,handles.image_height,x,y,handles.r(k)); 
        img=handles.img_stack(:,:,j+handles.istart-1);
        img_bw=img(c_mask);
        GC(j)=calculate_intensity_v2(img_bw);
    end
    handles.total_intensity{k}=GC;
%     figure (1);
%     subplot(handles.neuron_number,1,k); 
%     plot(((1:handles.frame_number)+handles.istart-1),smooth(handles.signal{k},1),'Color',handles.colorset(k,:));
%     plot(image_times((1:handles.frame_number)+handles.istart-1),smooth(handles.signal{k},1),'Color',handles.colorset(k,:));
%     xlabel('frame'); ylabel('F (a.u.)');
end

guidata(hObject, handles);

end


if ~isempty(handles.total_intensity)   
    curve_plot(handles.total_intensity, handles.image_times, handles.odor_seq);
end

guidata(hObject,handles);
