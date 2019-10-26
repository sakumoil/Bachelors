function varargout = segment_gui(varargin)
%SEGMENT_GUI: This script is used to extract textural data from specified ROIs from a thermal image
% The script tries to find patella from knees automatically using thresholding. The default thresholding
% value is 140. After drawing ROI, user can modify them as needed


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @segment_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @segment_gui_OutputFcn, ...
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

% --- Executes just before segment_gui is made visible.
function segment_gui_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to segment_gui (see VARARGIN)

    % Choose default command line output for segment_gui
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % Set default ellipse size
    handles.ellipseSizex = 130;
    handles.ellipseSizey = 90;

    % Set the threshold value for binary image. Easy to specify from histogram
    % of normalized image.
    handles.thresholdValue = 120;
    textLabel = sprintf('Current threshold is: %d', handles.thresholdValue);

    % Initialize figure elements
    set(handles.text2, 'String',textLabel);
    set(handles.axes1,'visible', 'off');

    guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = segment_gui_OutputFcn(hObject, eventdata, handles)
    % varargout  cell array for returning output args (see VARARGOUcT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;


% --- Executes on button press in folderbutton.
function folderbutton_Callback(hObject, eventdata, handles)
% Specify folder containig thermal images

handles.ROI_id=0;

handles.folder_name = uigetdir('Select folder with thermal data');

handles.iteration=1;

if handles.folder_name==0
    handles.folder_name=[];
    return
end

% Get all images from folder
handles.list_images = dir([handles.folder_name, '\*.jpg']);
handles.name_image = [handles.folder_name, '\', handles.list_images(handles.iteration).name];

% Use FlirMovieReader to read image
[v]= FlirMovieReader([handles.name_image]);
v.unit = 'temperatureFactory';
[image, ~] =step(v);
handles.image=double(image);
handles.altered_image=handles.image;

% Display current image name in text box
textLabel = sprintf(handles.list_images(handles.iteration).name);
set(handles.text1, 'String', textLabel);

% Resize image to [480 640]
if size(handles.image) == [240 320]
    handles.image = imresize(handles.image, 2);
end

% Append the current image to images -variable
imageNumber = handles.iteration;
handles.images(:,:,imageNumber) = handles.image;

axes(handles.axes1);
imshow(handles.image, []);

guidata(hObject, handles);


% --- Executes on button press in nextimagebutton.
function nextimagebutton_Callback(hObject, eventdata, handles)

    % Change to next image in directory
    handles.iteration=handles.iteration+1;
    handles.ROI_id=0;

    % If current image is the last image in the folder, raise error message
    if handles.iteration>size(handles.list_images,1)
        textLabel = sprintf('No pictures left!');
        set(handles.text1, 'String', textLabel)
        handles.iteration = handles.iteration-1;
        return
    end

    % If current image is the last image in the folder, raise error message
    if handles.iteration>size(handles.list_images,1)
        textLabel = sprintf('No pictures left!');
        set(handles.text1, 'String', textLabel)
        handles.iteration = handles.iteration-1;
        return
    end

    % Set image name into handles
    handles.name_image = [handles.folder_name, '\', handles.list_images(handles.iteration).name];

    % Use FlirMovieReader to properly read thermal images
    [v]= FlirMovieReader([handles.name_image]);
    v.unit = 'temperatureFactory';
    [image, ~] =step(v);
    handles.image=double(image);
    handles.altered_image=handles.image;

    % Display name of current image in text field
    textLabel = sprintf(handles.list_images(handles.iteration).name);
    set(handles.text1, 'String', textLabel);

    % Resize image to [480 640]
    if size(handles.image) == [240 320]
        handles.image = imresize(handles.image, 2);
    end

    % Append the current image to the images variable
    imageNumber = handles.iteration;
    handles.images(:,:,imageNumber) = handles.image;
    image = handles.image;

    % Show current image
    axes(handles.axes1);
    imshow(handles.image, []);

    guidata(hObject, handles);

% --- Executes on button press in previousimagebutton.
function previousimagebutton_Callback(hObject, eventdata, handles)
    % Change to previous image

    handles.iteration=handles.iteration-1;
    handles.ROI_id=0;

    % If current image is the last image in the folder, raise error message
    if handles.iteration>size(handles.list_images,1)
        textLabel = sprintf('No pictures left!');
        set(handles.text1, 'String', textLabel)
        handles.iteration = handles.iteration-1;
        return
    end

    % If current image is the last image in the folder, raise error message
    if handles.iteration>size(handles.list_images,1)
        textLabel = sprintf('No pictures left!');
        set(handles.text1, 'String', textLabel)
        handles.iteration = handles.iteration-1;
        return
    end

    % Set image name into handles
    handles.name_image = [handles.folder_name, '\', handles.list_images(handles.iteration).name];

    % Use FlirMovieReader to properly read thermal images
    [v]= FlirMovieReader([handles.name_image]);
    v.unit = 'temperatureFactory';
    [image, ~] =step(v);
    handles.image=double(image);
    handles.altered_image=handles.image;

    % Display name of current image in text field
    textLabel = sprintf(handles.list_images(handles.iteration).name);
    set(handles.text1, 'String', textLabel);

    % Resize image to [480 640]
    if size(handles.image) == [240 320]
        handles.image = imresize(handles.image, 2);
    end

    % Append the current image to the images variable
    imageNumber = handles.iteration;
    handles.images(:,:,imageNumber) = handles.image;

    axes(handles.axes1);
    imshow(handles.image, []);

    guidata(hObject, handles);


function ellipsebutton_Callback(hObject, ~, handles)

    % Executes on button press of "Ellipse button".
    handles.alteredimage = handles.image;

    % Normalize the grayscale image
    normalizedImage = uint8(255*mat2gray(handles.alteredimage));

    % Create a binary image depending on threshold value
    BW = normalizedImage > handles.thresholdValue;

    % Fill holes in the binary image
    BW_fill = imfill(BW, 'holes');

    % Only choose two largest areas from binary image
    BW_fill = bwareafilt(BW_fill, 2, 4);

    % If area is under 20 000 px, delete it
    BW_fill = bwareaopen(BW_fill, 20000);

    % Get measurements from blobs
    blobMeasurements = regionprops(BW_fill, normalizedImage, 'all');

    % Number of areas in binary image
    numberOfBlobs = size(blobMeasurements, 1);

    % Find filled areas and set them to variable
    BW = double(BW);
    BW_fill = double(BW_fill);
    BW_diff = imabsdiff(BW, BW_fill);
    areas_filled = find(BW_diff);

    % Get the centroids and areas of all blobs left
    for k = 1 : numberOfBlobs
        blobCentroid = blobMeasurements(k).Centroid;
        blobArea = blobMeasurements(k).Area;
    end


    % In case of just 1 blob recognized and it's area being over 95000 pixels,
    % it's safe to assume that the picture is taken either from front or behind
    % and number of blobs is 1, so we need to simulate the thigh gap
    if numberOfBlobs == 1 && blobArea > 95000
        centroidHorizontal = round(blobCentroid(1:2:end-1));
        BW(:, centroidHorizontal) = 0;
        BW = bwareaopen(BW, 20000);
        blobMeasurements = regionprops(BW, normalizedImage, 'all');
        numberOfBlobs = size(blobMeasurements, 1);
    end

    % Recalculate blob centroids and draw ellipses on them
    for k = 1 : numberOfBlobs
        handles.ROI_id = handles.ROI_id+1;
        blobCentroid = blobMeasurements(k).Centroid;
        if blobCentroid(2) < 200 || blobCentroid(2) > 400
            continue
        end

        % Define ellipse x-coordinate of ellipse center
        ellipseX(handles.ROI_id) = blobCentroid(1)-handles.ellipseSizex/2;

        % Only define ellipse y-coordinate if current image is the first
        % in directory. Otherwise keep the same height for ellipse for rest of
        % the images.
        if handles.iteration == 1
            handles.ellipseY = blobCentroid(2)-handles.ellipseSizey/2;
        end

        % Define the ellipse
        handles.hEllipse(handles.ROI_id) = imellipse(gca, [ellipseX(handles.ROI_id) handles.ellipseY handles.ellipseSizex handles.ellipseSizey]);
        wait(handles.hEllipse(handles.ROI_id));

        %Save ROI position into a variable
        handles.pos{handles.ROI_id} = getPosition(handles.hEllipse(handles.ROI_id));

        % If current image is the first in directory, save ellipse y-coordinate into a variable
        % for later user.
        if handles.iteration == 1
            pos = getPosition(handles.hEllipse(handles.ROI_id));
            handles.ellipseY = pos(2);
        end

        % Create mask of ellipse
        BW = handles.hEllipse(handles.ROI_id).createMask();

        % Save the number of pixels in ROI into a variable
        handles.numberOfPixels{handles.ROI_id} = find(BW);

        se = strel('disk',2,8);
        BW2=BW-imerode(BW,se);
        handles.alteredimage(BW2==1)=max(handles.image(:));

        % Set filled areas to NaN
        for j = 1:length(areas_filled)
            handles.image(areas_filled(j)) = NaN;
        end
        imshow(handles.alteredimage,[]);

        % Calculate textural parameters and save them to variables
        [handles.average(handles.ROI_id), handles.maximum(handles.ROI_id), handles.minimum(handles.ROI_id), handles.standard(handles.ROI_id), handles.homogeneity1(handles.ROI_id), handles.entropy1(handles.ROI_id), handles.homogeneity2(handles.ROI_id), handles.entropy2(handles.ROI_id)] = calcul_parameters(handles.image,BW);

        handles.textural(handles.iteration, handles.ROI_id, 1) = handles.average(handles.ROI_id);
        handles.textural(handles.iteration, handles.ROI_id, 2) = handles.maximum(handles.ROI_id);
        handles.textural(handles.iteration, handles.ROI_id, 3) = handles.minimum(handles.ROI_id);
        handles.textural(handles.iteration, handles.ROI_id, 4) = handles.standard(handles.ROI_id);
        handles.textural(handles.iteration, handles.ROI_id, 5) = handles.homogeneity1(handles.ROI_id);
        handles.textural(handles.iteration, handles.ROI_id, 6) = handles.entropy1(handles.ROI_id);
        handles.textural(handles.iteration, handles.ROI_id, 7) = handles.homogeneity2(handles.ROI_id);
        handles.textural(handles.iteration, handles.ROI_id, 8) = handles.entropy2(handles.ROI_id);
    end

    % Draw four more ROI
    for j = 1:numberOfBlobs
        handles.ROI_id = handles.ROI_id+1;
        handles.hEllipse(handles.ROI_id) = imellipse(gca, [ellipseX(j) handles.ellipseY-150 handles.ellipseSizex+20 handles.ellipseSizey+20]);
        wait(handles.hEllipse(handles.ROI_id));
        handles.pos{handles.ROI_id} = getPosition(handles.hEllipse(handles.ROI_id));
        BW = handles.hEllipse(handles.ROI_id).createMask();

        handles.numberOfPixels{handles.ROI_id} = find(BW);

        se = strel('disk',2,8);
        BW2=BW-imerode(BW,se);
        handles.alteredimage(BW2==1)=max(handles.image(:));
        imshow(handles.alteredimage,[]);

        [handles.average(handles.ROI_id), handles.maximum(handles.ROI_id), handles.minimum(handles.ROI_id), handles.standard(handles.ROI_id), handles.homogeneity1(handles.ROI_id), handles.entropy1(handles.ROI_id), handles.homogeneity2(handles.ROI_id), handles.entropy2(handles.ROI_id)] = calcul_parameters(handles.image,BW);
        handles.textural(handles.iteration, handles.ROI_id, 1) = handles.average(handles.ROI_id);
        handles.textural(handles.iteration, handles.ROI_id, 2) = handles.maximum(handles.ROI_id);
        handles.textural(handles.iteration, handles.ROI_id, 3) = handles.minimum(handles.ROI_id);
        handles.textural(handles.iteration, handles.ROI_id, 4) = handles.standard(handles.ROI_id);
        handles.textural(handles.iteration, handles.ROI_id, 5) = handles.homogeneity1(handles.ROI_id);
        handles.textural(handles.iteration, handles.ROI_id, 6) = handles.entropy1(handles.ROI_id);
        handles.textural(handles.iteration, handles.ROI_id, 7) = handles.homogeneity2(handles.ROI_id);
        handles.textural(handles.iteration, handles.ROI_id, 8) = handles.entropy2(handles.ROI_id);


        handles.ROI_id = handles.ROI_id+1;
        handles.hEllipse(handles.ROI_id) = imellipse(gca, [ellipseX(j) handles.ellipseY+150 handles.ellipseSizex handles.ellipseSizey-10]);
        wait(handles.hEllipse(handles.ROI_id));
        handles.pos{handles.ROI_id} = getPosition(handles.hEllipse(handles.ROI_id));
        BW = handles.hEllipse(handles.ROI_id).createMask();

        handles.numberOfPixels{handles.ROI_id} = find(BW);

        se = strel('disk',2,8);
        BW2=BW-imerode(BW,se);
        handles.alteredimage(BW2==1)=max(handles.image(:));
        imshow(handles.alteredimage,[]);

        [handles.average(handles.ROI_id), handles.maximum(handles.ROI_id), handles.minimum(handles.ROI_id), handles.standard(handles.ROI_id), handles.homogeneity1(handles.ROI_id), handles.entropy1(handles.ROI_id), handles.homogeneity2(handles.ROI_id), handles.entropy2(handles.ROI_id)] = calcul_parameters(handles.image,BW);
        handles.textural(handles.iteration, handles.ROI_id, 1) = handles.average(handles.ROI_id);
        handles.textural(handles.iteration, handles.ROI_id, 2) = handles.maximum(handles.ROI_id);
        handles.textural(handles.iteration, handles.ROI_id, 3) = handles.minimum(handles.ROI_id);
        handles.textural(handles.iteration, handles.ROI_id, 4) = handles.standard(handles.ROI_id);
        handles.textural(handles.iteration, handles.ROI_id, 5) = handles.homogeneity1(handles.ROI_id);
        handles.textural(handles.iteration, handles.ROI_id, 6) = handles.entropy1(handles.ROI_id);
        handles.textural(handles.iteration, handles.ROI_id, 7) = handles.homogeneity2(handles.ROI_id);
        handles.textural(handles.iteration, handles.ROI_id, 8) = handles.entropy2(handles.ROI_id);
    end

    [average, maximum, minimum, standard, homogeneity1, entropy1, homogeneity2, entropy2] = calcul_parameters(handles.image,BW);
    %results((handles.ROI_id-1)*8+1:handles.ROI_id*8)=[average, maximum, minimum, standard, homogeneity1, entropy1, homogeneity2, entropy2];
    show_results(handles, average, maximum, minimum, standard, homogeneity1, entropy1);

    guidata(hObject,handles);


% --- Executes on button press in thresholdUp.
function thresholdUp_Callback(hObject, eventdata, handles)
    % Add 10 to current threshold

    handles.thresholdValue = handles.thresholdValue+10;
    textLabel = sprintf('Current threshold is: %d', handles.thresholdValue);
    set(handles.text2, 'String',textLabel);

    guidata(hObject, handles);

% --- Executes on button press in thresholdDown.
function thresholdDown_Callback(hObject, eventdata, handles)
    % Remove 10 from current threshold

    handles.thresholdValue = handles.thresholdValue-10;
    textLabel = sprintf('Current threshold is: %d', handles.thresholdValue);
    set(handles.text2, 'String',textLabel);

    guidata(hObject, handles);

% --- Executes on button press in resetbutton.
function resetbutton_Callback(hObject, eventdata, handles)
    % Remove all ROIs

    handles.ROI_id=0;
    axes(handles.axes1);
    imshow(handles.image, []);
    guidata(hObject, handles);


% --- Executes on button press in savebutton.
function savebutton_Callback(hObject, eventdata, handles)
    % Save variables and images into a .mat file

    images = handles.images;
    textural = handles.textural;

    maxpixels = [];

    cellfun('length', handles.numberOfPixels(1));

    % handles.ROIs(:,handles.ROI_id ,handles.iteration) = numberOfPixels;

    folder_name = strsplit(handles.folder_name, '\');
    file_name = folder_name{8};
    save_dir = fullfile(['results', '\', folder_name{7}, '\']);
    save_name = [save_dir, file_name];
    if ~exist(save_dir, 'dir')
        mkdir(save_dir);
    end

    save(save_name, 'images', 'textural');
    guidata(hObject, handles);
