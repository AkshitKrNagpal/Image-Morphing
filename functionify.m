function varargout = functionify(varargin)
% FUNCTIONIFY MATLAB code for functionify.fig
%      FUNCTIONIFY, by itself, creates a new FUNCTIONIFY or raises the existing
%      singleton*.
%
%      H = FUNCTIONIFY returns the handle to a new FUNCTIONIFY or the handle to
%      the existing singleton*.
%
%      FUNCTIONIFY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FUNCTIONIFY.M with the given input arguments.
%
%      FUNCTIONIFY('Property','Value',...) creates a new FUNCTIONIFY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before functionify_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to functionify_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help functionify

% Last Modified by GUIDE v2.5 09-Dec-2015 11:06:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @functionify_OpeningFcn, ...
                   'gui_OutputFcn',  @functionify_OutputFcn, ...
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


% --- Executes just before functionify is made visible.
function functionify_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to functionify (see VARARGIN)
global choice;
choice=1;
% Choose default command line output for functionify
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes functionify wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = functionify_OutputFcn(hObject, eventdata, handles) 
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

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global choice;
global A;
B=uint8(zeros(size(A)));

m = size(A,1);
n = size(A,2);

a=ceil((n+1)/2);
b=ceil((m+1)/2);

initial = str2double(get(handles.edit1,'String'));
final = str2double(get(handles.edit2,'String'));

range = [initial final];

for k=1:3
    for i = 1:m
        for j = 1:n
            
            x = range(1) + (j/n)*(range(2)-range(1));
            switch choice
                case 1 
                    maxx=1;
                    p = ceil(b - (b-i)*( maxx/(  sin(x) ) ));
                case 2
                    maxx=1;
                    p = ceil(b - (b-i)*( maxx/(  cos(x) ) ));
                case 3
                    maxx=sqrt(2);
                    p = ceil(b - (b-i)*( maxx/(  sin(x)+cos(x)  )));
                case 4
                    maxx=1;
                    p = ceil(b - (b-i)*( maxx/(  (sin(x))^3 + (cos(x))^3 ) ));
                case 5
                    maxx=1;
                    p = ceil(b - (b-i)*( maxx/(  (sin(x))^4 ) ));
                case 6
                    maxx=sqrt(27)/16;
                    p = ceil(b - (b-i)*( maxx/(  sin(x)*(cos(x))^3 ) ));
            end
            q = j;%floor(a - (a-j)*abs(cos( (i/m)*pi )));
            
            if p<=size(B,1) && p>0 && q<=size(B,2) && q>0
                B(i,j,k)= A(p,q,k);
            end
        end
    end        
end

guidata(hObject, handles);
axes(handles.axes2);
imshow(B)



% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global choice;
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'radiobutton1'
        choice=1;
    case 'radiobutton2'
        choice=2;
    case 'radiobutton3'
        choice=3;
    case 'radiobutton4'
        choice=4;
    case 'radiobutton5'
        choice=5;
    case 'radiobutton6'
        choice=6;   
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
