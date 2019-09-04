% Purpose of this script is to convert images into a .mat -file using FlirMovieReader


folder_name = uigetdir('Folder with images');
% folder_name = '/Users/sakumoil/Projects/Bachelors/helsinki thermal/1/Kontrolli1';
list_images = dir([folder_name, '/*.jpg']);
for i = 1:length(list_images)
    split_imname = strsplit(list_images(i).name, '.');
    split_imname = char(split_imname(1));
    image_name = [folder_name, '\', list_images(i).name];
    new_name = [folder_name, '\', split_imname, '.mat'];
    [v]= FlirMovieReader([image_name]);
    v.unit = 'temperatureFactory';
    [image, ~] =step(v);
    image = double(image);
    save(new_name, 'image', '-mat')
end