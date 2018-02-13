function varargout = mainFigure(varargin)
% MAINFIGURE MATLAB code for mainFigure.fig
%      MAINFIGURE, by itself, creates a new MAINFIGURE or raises the existing
%      singleton*.
%
%      H = MAINFIGURE returns the handle to a new MAINFIGURE or the handle to
%      the existing singleton*.
%
%      MAINFIGURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINFIGURE.M with the given input arguments.
%
%      MAINFIGURE('Property','Value',...) creates a new MAINFIGURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mainFigure_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mainFigure_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mainFigure

% Last Modified by GUIDE v2.5 06-Mar-2017 21:50:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mainFigure_OpeningFcn, ...
                   'gui_OutputFcn',  @mainFigure_OutputFcn, ...
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


% --- Executes just before mainFigure is made visible.
function mainFigure_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mainFigure (see VARARGIN)

% Choose default command line output for mainFigure
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mainFigure wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mainFigure_OutputFcn(hObject, eventdata, handles) 
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
global im;
[f,p]=uigetfile('.jpg');
im=imread(strcat(p,f));
axes(handles.axes1);
imshow(im);
handles.im=im;
guidata(hObject,handles);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;

H = fspecial('gaussian',10,45);
G1 = imfilter(im,H,'replicate');
axes(handles.axes2);
imshow(G1);
i=1;
OutVideoDir = 'Granularity Data';
        baseFileName = sprintf('%d.jpg', i); 
        fullFileName = fullfile(OutVideoDir, baseFileName); 
        imwrite(G1, fullFileName);i=i+1;
H2 = fspecial('gaussian',10,35);
G2 = imfilter(G1,H2,'replicate');
axes(handles.axes3);
        baseFileName = sprintf('%d.jpg', i); 
        fullFileName = fullfile(OutVideoDir, baseFileName); 
        imwrite(G2, fullFileName);i=i+1;
imshow(G2);
H3 = fspecial('gaussian',10,25);
G3 = imfilter(G2,H3,'replicate');
axes(handles.axes4);
imshow(G3);
        baseFileName = sprintf('%d.jpg', i); 
        fullFileName = fullfile(OutVideoDir, baseFileName); 
        imwrite(G3, fullFileName);i=i+1;

G4 = imfilter(G3,H3,'replicate');
axes(handles.axes5);
imshow(G4);
        baseFileName = sprintf('%d.jpg', i); 
        fullFileName = fullfile(OutVideoDir, baseFileName); 
        imwrite(G4, fullFileName);i=i+1;
H4 = fspecial('gaussian',10,15);
G5 = imfilter(G4,H3,'replicate');
axes(handles.axes6);
imshow(G5);
        baseFileName = sprintf('%d.jpg', i); 
        fullFileName = fullfile(OutVideoDir, baseFileName); 
        imwrite(G5, fullFileName);i=i+1;
G6 = imfilter(G5,H3,'replicate');
axes(handles.axes7);
imshow(G6);
        baseFileName = sprintf('%d.jpg', i); 
        fullFileName = fullfile(OutVideoDir, baseFileName); 
        imwrite(G6, fullFileName);i=i+1;

detector = buildDetector();
%[bbox bbimg faces bbfaces] = detectFaceParts(detector,im,2);
[m n c]=size(im);
if(c==3)
[bbox,im_eye,im_no,im_mo] = detectFaceParts(detector,im);
else
    [bbox,im_eye,im_no,im_mo] = detectFaceParts1(detector,im);
end
    
axes(handles.axes8);
imshow(im_eye);


axes(handles.axes9);
imshow(im_no);

axes(handles.axes10);
imshow(im_mo);
        baseFileName = sprintf('%d.jpg', i); 
        fullFileName = fullfile(OutVideoDir, baseFileName); 
        imwrite(im_eye, fullFileName);i=i+1;
        
         baseFileName = sprintf('%d.jpg', i); 
        fullFileName = fullfile(OutVideoDir, baseFileName); 
        imwrite(im_no, fullFileName);i=i+1;
        
        baseFileName = sprintf('%d.jpg', i); 
        fullFileName = fullfile(OutVideoDir, baseFileName); 
        imwrite(im_mo, fullFileName);i=i+1;

% lbp1=LBP(G1,1);
% lbp2=LBP(G2,1);
% lbp3=LBP(G3,1);
% lbp4=LBP(G4,1);
% lbp5=LBP(G5,1);
% lbp6=LBP(G6,1);
% 
% feature=[lbp1' lbp2' lbp3' lbp4' lbp5' lbp6'];
% feat(:)=feature;
% save feat;

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 Dir = 'Granularity Data\'; 
% Read images from Images folder
Imgs = dir(fullfile(Dir, '*.jpg'));
h=waitbar(0,'Input Image Features extraction processing');
for i=1:length(Imgs)
    waitbar(i/length(Imgs));
    %na=name{1,i};
    %imageName=(imread([path '\' na]));
    imageName = imread(fullfile(Dir, Imgs(i).name)); 
    lbp1=LBP(imageName,1);
    lbpHist=imhist(lbp1);
       Flbp(:,i)=lbpHist;
 end
close(h);
save Features Flbp;
msgbox('Features saved successfully');
% for j=1:length(Imgs)
%     imageName = imread(fullfile(Dir, Imgs(j).name));  % Read image
%     %featureVector = gaborFeatures(Img); % apply gabor filter

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load Features ;
load Features1;

Dist1 = (sum(abs(Flbp1-Flbp)))
x=sum(Dist1)
if sum(Dist1)>2098930
    msgbox('Face Matched');
else
    msgbox('Face Not Matched');
end
    
% gist1=double(gist1);
% Fgist=double(Fgist);
% for i=1:size(Fgist,2);
%     f1=Fgist(:,i);
%     c(i)=sum(distance(f1',gist1));
% end
% Dis=sqrt(real(c).^2+imag(c).^2);
% 
% [Val,pos]=min(Dis);
