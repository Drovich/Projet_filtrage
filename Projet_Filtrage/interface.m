function varargout = interface(varargin)
% INTERFACE MATLAB code for interface.fig
%      INTERFACE, by itself, creates a new INTERFACE or raises the existing
%      singleton*.
%
%      H = INTERFACE returns the handle to a new INTERFACE or the handle to
%      the existing singleton*.
%
%      INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACE.M with the given input arguments.
%
%      INTERFACE('Property','Value',...) creates a new INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before interface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interface

% Last Modified by GUIDE v2.5 03-Jan-2019 18:46:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interface_OpeningFcn, ...
                   'gui_OutputFcn',  @interface_OutputFcn, ...
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


% --- Executes just before interface is made visible.
function interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interface (see VARARGIN)

% Choose default command line output for interface
handles.output = hObject;
handles.EGG= load('dataEEG.mat');
handles.EGG_mark= 1;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = interface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in dfa_button.
function dfa_button_Callback(hObject, eventdata, handles)
% hObject    handle to dfa_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.EGG_mark==1
else
end
try
    y=handles.signal;
    [J,alpha_dfa,beta_dfa,yinit,Al,lF_dfa,ltF] = DFA_function(y);
    handles.alpha_dfa=alpha_dfa;
    handles.beta_dfa=beta_dfa;
    handles.lF_dfa=lF_dfa;
    handles.ltF=ltF;
    handles.yinit=yinit;
    plot_regularite(alpha_dfa,beta_dfa,lF_dfa,ltF)
    textLabel = sprintf('Regularity with DFA method : %i ', alpha_dfa );
    set(handles.text_main, 'String', textLabel);
catch
    textLabel = sprintf('Please first load a signal');
    set(handles.text_main, 'String', textLabel);
end
guidata(hObject, handles);



% --- Executes on button press in dma_button.
function dma_button_Callback(hObject, eventdata, handles)
% hObject    handle to dma_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.EGG_mark==1
else
end
try
    y=handles.signal;
    [J,alpha_dma,beta_dma,yinit,yinit_filt,lF_dma,ltF] = DMA_functionv2(y);
    handles.alpha_dma=alpha_dma;
    handles.beta_dma=beta_dma;
    handles.lF_dma=lF_dma;
    handles.ltF=ltF;
    handles.yinit=yinit;
    handles.yinit_dma=yinit_filt;
    plot_regularite(alpha_dma,beta_dma,lF_dma,ltF)
    textLabel = sprintf('Regularity with DMA method : %i ', alpha_dma );
    set(handles.text_main, 'String', textLabel);
catch
    textLabel = sprintf('Please first load a signal');
    set(handles.text_main, 'String', textLabel);
end
guidata(hObject, handles);




% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    EGG= load('dataEEG.mat');
    handles.fech=1*10^3;
    y=cell2mat(EGG.dataEEG(1,1,1))';
    handles.signal = y;
    M=length(y);
    t = (1:1:M)/fech;
    plot(t,y);
    xlabel('Temps (s)');
    ylabel('y(t)');
    title('Représentation temporelle de y(t) ');
    % % handles.Fs = signal.Fs;
    % handles.N = size(handles.data,2);
    % handles.time_axis = (1:handles.N)/handles.Fs;
    % % xlabel('Time (s)');
    % % ylabel('Magnitude');
    % textLabel = sprintf('Time evolution of the loaded signal');
    % set(handles.text_main, 'String', textLabel);
    textLabel = sprintf('Signal loaded');
    set(handles.text_main, 'String', textLabel);
catch
    textLabel = sprintf('Error : Loading image not found...');
    set(handles.text_main, 'String', textLabel);
end
guidata(hObject, handles);



function text_main_Callback(hObject, eventdata, handles)
% hObject    handle to text_main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text_main as text
%        str2double(get(hObject,'String')) returns contents of text_main as a double
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function text_main_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in dfa_dma.
function dfa_dma_Callback(hObject, eventdata, handles)
% hObject    handle to dfa_dma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dfa_dma
guidata(hObject, handles);


% --- Executes on button press in white_noise.
function white_noise_Callback(hObject, eventdata, handles)
% hObject    handle to white_noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
y=randn(1,1000);
handles.signal = y;
handles.fech=1*10^3;
M=length(y);
t = (1:1:M)/handles.fech;
plot(t,y);
xlabel('Temps (s)');
ylabel('y(t)');
title('Représentation temporelle du bruit blanc');
textLabel = sprintf('Signal generated');
set(handles.text_main, 'String', textLabel);
% Hint: get(hObject,'Value') returns toggle state of white_noise
guidata(hObject, handles);


% --- Executes on button press in pink_noise.
function pink_noise_Callback(hObject, eventdata, handles)
% hObject    handle to pink_noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pink_noise



function electrode_text_Callback(hObject, eventdata, handles)
% hObject    handle to electrode_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of electrode_text as text
%        str2double(get(hObject,'String')) returns contents of electrode_text as a double
handles.n_electrode=str2double(get(hObject,'String'));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function electrode_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to electrode_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject, handles);



% --- Executes on button press in profil.
function profil_Callback(hObject, eventdata, handles)
% hObject    handle to profil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    M=length(handles.signal);
    t = (1:1:M)/handles.fech;
    plot(t,handles.yinit)
    hold on
    plot(t,handles.yinit_dma)
    hold off
    textLabel = sprintf('Profil of the signal');
    set(handles.text_main, 'String', textLabel);
catch
    textLabel = sprintf('Please process first the signal with DFA or DMA method');
    set(handles.text_main, 'String', textLabel);
end




function nsignal_text_Callback(hObject, eventdata, handles)
% hObject    handle to nsignal_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nsignal_text as text
%        str2double(get(hObject,'String')) returns contents of nsignal_text as a double
handles.n_signal=str2double(get(hObject,'String'));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function nsignal_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nsignal_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject, handles);

    


% --- Executes on button press in EEG_text.
function EEG_text_Callback(hObject, eventdata, handles)
% hObject    handle to EEG_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.EGG_mark== 1
    handles.EGG_mark= 0;
    y=randn(1,1000);
    handles.signal = y;
    handles.fech=1*10^3;
    M=length(y);
    t = (1:1:M)/handles.fech;
    plot(t,y);
    xlabel('Temps (s)');
    ylabel('y(t)');
    title('Représentation temporelle du bruit blanc');
    textLabel = sprintf('Signal generated');
    set(handles.text_main, 'String', textLabel);
else
    handles.EGG_mark= 1;
    try
        y=cell2mat(handles.EGG.dataEEG(handles.n_electrode,handles.n_electrode,handles.n_signal))';
        handles.signal=y;
    catch
        textLabel = sprintf('error loading signal dataEGG' );
        set(handles.text_main, 'String', textLabel)
        return;
    end
    handles.signal = y;
    handles.fech=1*10^3;
    M=length(y);
    t = (1:1:M)/handles.fech;
    plot(t,y);
    xlabel('Temps (s)');
    ylabel('y(t)');
    title('Représentation du signal EEG');
    textLabel = sprintf('Signal load');
    set(handles.text_main, 'String', textLabel);
end

% Hint: get(hObject,'Value') returns toggle state of EEG_text
guidata(hObject, handles);
