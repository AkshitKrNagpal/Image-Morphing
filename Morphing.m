
function varargout = Morphing(varargin)
% MORPHING MATLAB code for Morphing.fig
%      MORPHING, by itself, creates a new MORPHING or raises the existing
%      singleton*.
%
%      H = MORPHING returns the handle to a new MORPHING or the handle to
%      the existing singleton*.
%
%      MORPHING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MORPHING.M with the given input arguments.
%
%      MORPHING('Property','Value',...) creates a new MORPHING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Morphing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Morphing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Morphing

% Last Modified by GUIDE v2.5 29-Nov-2015 00:38:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Morphing_OpeningFcn, ...
                   'gui_OutputFcn',  @Morphing_OutputFcn, ...
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


% --- Executes just before Morphing is made visible.
function Morphing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Morphing (see VARARGIN)

% Choose default command line output for Morphing
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

global choice;
choice=1;
%axes(handles.axes1);
%imshow('default.jpg')
% UIWAIT makes Morphing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Morphing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global A;
[filename, user_cancelled] = imgetfile;
if user_cancelled
else
    A=imread(filename);
    axes(handles.axes1);
    imshow(filename)
end


% --- Executes when selected object is changed in uibuttongroup2.
function uibuttongroup2_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup2 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global choice;
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'radiobutton2'
        %eye
        choice=1;
    case 'radiobutton3'
        %wave
        choice=2;
    case 'radiobutton4'
        %decolorify
        choice=3;
    case 'radiobutton5'
        %pixel
        choice=4;
    case 'radiobutton6'
        %solarize
        choice=5;
    case 'radiobutton7'
        %warm tone
        choice=6;
       
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global choice;
switch choice
    case 1 
        eye(hObject, handles);
    case 2
        wave(hObject, handles);
    case 3
        decolor(hObject, handles);
    case 4
        pixelate(hObject, handles);
    case 5
        solarize(hObject , handles);
    case 6
        warm(hObject, handles);
end


function eye( hObject, handles )
    
global A;
B=uint8(zeros(size(A)));

m = size(A,1);
n = size(A,2);

a=ceil((n+1)/2);
b=ceil((m+1)/2);

maxx=1;
range = [0 pi];

for k=1:3
    for i = 1:m
        for j = 1:n
            
            x = range(1) + (j/n)*(range(2)-range(1));
            p = ceil(b - (b-i)*( maxx/(  sin(x) ) ));
            q = j;
            
            if p<=size(B,1) && p>0 && q<=size(B,2) && q>0
                B(i,j,k)= A(p,q,k);
            end
        end
    end        
end

guidata(hObject, handles);
axes(handles.axes2);
imshow(B)

function solarize( hObject, handles )
    
global A;
B=uint8(zeros(size(A)));

for k=1:3
    for i=1:size(A,1)
        for j=1:size(A,2)
            if(A(i,j,k)>128)
                B(i,j,k)=A(i,j,k);
            else
                B(i,j,k)=255-A(i,j,k);
                
            end
        end
    end
end
guidata(hObject, handles);
axes(handles.axes2);
imshow(B)

function warm( hObject, handles )
    
global A;

B=uint8(zeros(size(A)));
for k=1:3
    for i = 1:size(A,1)
        for j = 1:size(A,2)
            if(A(i,j,k)>128)
                B(i,j,k)=255;
            else
                B(i,j,k)=0;
            end
        end
    end
end
guidata(hObject, handles);
axes(handles.axes2);
imshow(B,[])
S

function decolor( hObject, handles )
    
global A;

B=rgb2gray(A);
guidata(hObject, handles);
axes(handles.axes2);
imshow(B,[])

function pixelate( hObject, handles )
    
global A;
m=ceil(size(A,1)/127.25);
n=ceil(size(A,2)/240);

B=uint8(zeros(size(A)));

for k=1:3
    for i = 1:size(A,1)
        for j = 1:size(A,2)
            
            p=i-mod(i-1,m)+1;
            q=j-mod(j-1,n)+1;
            
            p=min(p,size(B,1));
            p=max(p,1);
            q=min(q,size(B,2));
            q=max(q,1);
            B(i,j,k)= A(p ,q ,k);
        end
    end        
end

guidata(hObject, handles);
axes(handles.axes2);
imshow(B)

function wave( hObject, handles )
    
global A;
n=10;
a=20;
B=uint8(zeros(size(A)));
for p = 1:3
    for i = 1:size(A,1)
        for j = 1:size(A,2)
            k=ceil(i + a*sin(n*( j/size(A,1) )*pi  ));
            k=min(k,size(A,1));
            k=max(k,1);
            B(i,j,p) = A(k,j,p);
        end
    end
end

guidata(hObject, handles);
axes(handles.axes2);
imshow(B)
    

        
