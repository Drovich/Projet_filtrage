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

% Last Modified by GUIDE v2.5 06-Jan-2019 17:32:31

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
handles.fech=1*10^3;
% Intialisation des valeurs par défault
handles.window=32;
textLabel = sprintf('%d',handles.window );
set(handles.window_text, 'String', textLabel);

handles.noverlap=8;
textLabel = sprintf('%d',handles.noverlap );
set(handles.noverlap_text, 'String', textLabel);

handles.nfft=256;
textLabel = sprintf('%d',handles.nfft );
set(handles.nfft_text, 'String', textLabel);

handles.n_electrode=1;
textLabel = sprintf('%d',handles.n_electrode );
set(handles.n_electrode_text, 'String', textLabel);

handles.n_sujet=1;
textLabel = sprintf('%d',handles.n_sujet );
set(handles.n_sujet_text, 'String', textLabel);

handles.phase=1;
textLabel = sprintf('%d',handles.phase );
set(handles.phase_text, 'String', textLabel);

handles.window_tendance=100;
textLabel = sprintf('%d',handles.window_tendance );
set(handles.window_tendance_text, 'String', textLabel);

handles.N_tab=[11 13 17 21 27 35 47 59 77 101];
textLabel = sprintf(' DEFAULT :  N=[11 13 17 21 27 35 47 59 77 101]');
set(handles.N_tab_text, 'String', textLabel);

handles.N_start=3;
textLabel = sprintf(' %d',handles.N_start);
set(handles.N_start_text, 'String', textLabel);

handles.N_max=222;

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




function window_text_Callback(hObject, eventdata, handles)
% hObject    handle to window_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of window_text as text
%        str2double(get(hObject,'String')) returns contents of window_text as a double
handles.window=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function window_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to window_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function noverlap_text_Callback(hObject, eventdata, handles)
% hObject    handle to noverlap_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of noverlap_text as text
%        str2double(get(hObject,'String')) returns contents of noverlap_text as a double
handles.noverlap=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function noverlap_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noverlap_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject, handles);


function nfft_text_Callback(hObject, eventdata, handles)
% hObject    handle to nfft_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nfft_text as text
%        str2double(get(hObject,'String')) returns contents of nfft_text as a double
handles.nfft=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function nfft_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nfft_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_electrode_text_Callback(hObject, eventdata, handles)
% hObject    handle to n_electrode_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_electrode_text as text
%        str2double(get(hObject,'String')) returns contents of n_electrode_text as a double
handles.n_electrode=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function n_electrode_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_electrode_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function n_sujet_text_Callback(hObject, eventdata, handles)
% hObject    handle to n_sujet_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_sujet_text as text
%        str2double(get(hObject,'String')) returns contents of n_sujet_text as a double
handles.n_sujet=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function n_sujet_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_sujet_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function phase_text_Callback(hObject, eventdata, handles)
% hObject    handle to phase_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of phase_text as text
%        str2double(get(hObject,'String')) returns contents of phase_text as a double
handles.phase=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function phase_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to phase_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function window_tendance_text_Callback(hObject, eventdata, handles)
% hObject    handle to window_tendance_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of window_tendance_text as text
%        str2double(get(hObject,'String')) returns contents of window_tendance_text as a double
handles.window_tendance=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function window_tendance_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to window_tendance_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function N_tab_text_Callback(hObject, eventdata, handles)
% hObject    handle to N_tab_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of N_tab_text as text
%        str2double(get(hObject,'String')) returns contents of N_tab_text as a double
handles.N_max=str2double(get(hObject,'String'));
if handles.N_max > handles.N_start
    handles.N_tab=[handles.N_start:handles.N_max];
    textLabel = sprintf(' N = [%d:%d]',handles.N_start,handles.N_max);
    set(handles.N_tab_text, 'String', textLabel);
    textLabel = sprintf('Value of N successfully changed ');
    set(handles.text_main, 'String', textLabel);
else
    textLabel = sprintf('ERROR, first load a signal and pay attention to the argument you use ');
    set(handles.text_main, 'String', textLabel);
    textLabel = sprintf(' ERROR just enter the max you want for N > Nmin');
    set(handles.N_tab_text, 'String', textLabel);
end

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function N_tab_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to N_tab_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function N_start_text_Callback(hObject, eventdata, handles)
% hObject    handle to N_start_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of N_start_text as text
%        str2double(get(hObject,'String')) returns contents of N_start_text as a double
handles.N_start=str2double(get(hObject,'String'));
if handles.N_start < handles.N_max
    handles.N_tab=[handles.N_start:handles.N_max];
    textLabel = sprintf(' N = [%d:%d]',handles.N_start,handles.N_max);
    set(handles.N_tab_text, 'String', textLabel);
    textLabel = sprintf('Value of N successfully changed ');
    set(handles.text_main, 'String', textLabel);
else
    textLabel = sprintf('ERROR, Nmin must be < at your maximum ');
    set(handles.text_main, 'String', textLabel);
    textLabel = sprintf(' ERROR please enter a number > Nmin');
    set(handles.N_tab_text, 'String', textLabel);
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function N_start_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to N_start_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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







% --- Executes on button press in dfa_button.
function dfa_button_Callback(hObject, eventdata, handles)
% hObject    handle to dfa_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    y=handles.signal;
    [J,alpha_dfa,beta_dfa,yinit,Al,lF_dfa,ltF] = DFA_function(y,handles.N_tab);
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

try
    y=handles.signal;
    [J,alpha_dma,beta_dma,yinit,yinit_filt,lF_dma,ltF] = DMA_function(y,handles.N_tab);
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


% --- Executes on button press in white_noise.
function white_noise_Callback(hObject, eventdata, handles)
% hObject    handle to white_noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
y=randn(1,1000);
handles.signal = y;
handles.yinit=0;
M=length(y);
handles.t = (1:1:M)/handles.fech;
plot(handles.t,y);
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
cn = dsp.ColoredNoise('Color','pink');
y = cn();
y=y';
handles.signal = y;
handles.yinit=0;
M=length(y);
handles.t = (1:1:M)/handles.fech;
plot(handles.t,y);
xlabel('Temps (s)');
ylabel('y(t)');
title('Représentation temporelle du bruit rose');
textLabel = sprintf('Signal generated');
set(handles.text_main, 'String', textLabel);
guidata(hObject, handles);

% --- Executes on button press in profil_dfa.
function profil_dfa_Callback(hObject, eventdata, handles)
% hObject    handle to profil_dfa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    if handles.yinit==0
        textLabel = sprintf('Error, please use first DMA or DFA method' );
        set(handles.text_main, 'String', textLabel);
        return;
    end
    plot(handles.t,handles.yinit)
    xlabel('Temps (s)');
    ylabel('yinit(t)');
    title('Représentation du profil du signal');
    textLabel = sprintf('Profil of the signal with DFA method');
    set(handles.text_main, 'String', textLabel);
catch
    textLabel = sprintf('Please load a signal');
    set(handles.text_main, 'String', textLabel);
end
guidata(hObject, handles);

% --- Executes on button press in profil_dma.
function profil_dma_Callback(hObject, eventdata, handles)
% hObject    handle to profil_dma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    if handles.yinit==0
        textLabel = sprintf('Error, please use first DMA or DFA method' );
        set(handles.text_main, 'String', textLabel);
        return;
    end
    plot(handles.t,handles.yinit)
    hold on
    plot(handles.t,handles.yinit_dma)
    hold off
    xlabel('Temps (s)');
    ylabel('yinit(t) et yinit_{filtered}(t)');
    title('Représentation du profil du signal');
    legend('Profil DFA', 'Profil DMA (DFA filtered)');
    textLabel = sprintf('Profil of the signal');
    set(handles.text_main, 'String', textLabel);
catch
    textLabel = sprintf('Please use first the DMA method');
    set(handles.text_main, 'String', textLabel);
end
guidata(hObject, handles);


% --- Executes on button press in EEG_text.
function EEG_text_Callback(hObject, eventdata, handles)
% hObject    handle to EEG_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    y=cell2mat(handles.EGG.dataEEG(handles.phase,handles.n_electrode,handles.n_sujet))';
    handles.signal=y;
    handles.yinit=0;
    M=length(y);
    handles.t = (1:1:M)/handles.fech;
    plot( handles.t,y);
    xlabel('Temps (s)');
    ylabel('y(t)');
    title('Représentation temporelle du signal EEG');
    textLabel = sprintf('Signal load');
    set(handles.text_main, 'String', textLabel);
catch
    textLabel = sprintf('error loading signal dataEGG' );
    set(handles.text_main, 'String', textLabel)
end


% Hint: get(hObject,'Value') returns toggle state of EEG_text
guidata(hObject, handles);

% --- Executes on button press in spectrgram.
function spectrgram_Callback(hObject, eventdata, handles)
% hObject    handle to spectrgram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
     spectro(handles.signal,handles.window,handles.noverlap,handles.nfft,handles.fech)
     textLabel = sprintf('Spectrogram du signal' );
     set(handles.text_main, 'String', textLabel)
catch
    textLabel = sprintf('Error using spectrogram, verify the arguments' );
    set(handles.text_main, 'String', textLabel)
end
guidata(hObject, handles);




% --- Executes on button press in tendance.
function tendance_Callback(hObject, eventdata, handles)
% hObject    handle to tendance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    y=handles.yinit;
    if y==0
        textLabel = sprintf('Error, please use first DMA or DFA method' );
        set(handles.text_main, 'String', textLabel)
        return
    end
catch
    textLabel = sprintf('Error, please load a signal' );
    set(handles.text_main, 'String', textLabel)
    return;
end
try
    plot_tendance(y,handles.window_tendance,handles.t,handles.fech);
    textLabel = sprintf('Tendance locale du signal' );
    set(handles.text_main, 'String', textLabel)
catch
    textLabel = sprintf('Error, window_tendance must be > 0' );
    set(handles.text_main, 'String', textLabel)
end
guidata(hObject, handles);
    

% --- Executes on button press in signal_display.
function signal_display_Callback(hObject, eventdata, handles)
% hObject    handle to signal_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    plot(handles.t,handles.signal);
    xlabel('Temps (s)');
    ylabel('y(t)');
    title('Représentation temporelle du signal');
    textLabel = sprintf('Signal displayed' );
    set(handles.text_main, 'String', textLabel)
catch
    textLabel = sprintf('Error, please load a signal' );
    set(handles.text_main, 'String', textLabel)
    
end



% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.window=32;
textLabel = sprintf('%d',handles.window );
set(handles.window_text, 'String', textLabel);

handles.noverlap=8;
textLabel = sprintf('%d',handles.noverlap );
set(handles.noverlap_text, 'String', textLabel);

handles.nfft=256;
textLabel = sprintf('%d',handles.nfft );
set(handles.nfft_text, 'String', textLabel);

handles.n_electrode=1;
textLabel = sprintf('%d',handles.n_electrode );
set(handles.n_electrode_text, 'String', textLabel);

handles.n_sujet=1;
textLabel = sprintf('%d',handles.n_sujet );
set(handles.n_sujet_text, 'String', textLabel);

handles.phase=1;
textLabel = sprintf('%d',handles.phase );
set(handles.phase_text, 'String', textLabel);

handles.window_tendance=100;
textLabel = sprintf('%d',handles.window_tendance );
set(handles.window_tendance_text, 'String', textLabel);

handles.N_tab=[11 13 17 21 27 35 47 59 77 101];
textLabel = sprintf(' DEFAULT :  N=[11 13 17 21 27 35 47 59 77 101]');
set(handles.N_tab_text, 'String', textLabel);

handles.N_start=3;
textLabel = sprintf('%d',handles.N_start );
set(handles.N_start_text, 'String', textLabel);

handles.N_max=222;

textLabel = sprintf(' All value reset to default');
set(handles.text_main, 'String', textLabel);


guidata(hObject, handles);

