% Purpose of this script is to convert images into a .mat -file using FlirMovieReader


% folder_name = uigetdir('Folder with images');
folder_name = '/Users/sakumoil/Projects/Bachelors/helsinki thermal/1/Kontrolli1';
list_images = dir([folder_name, '/*.jpg']);
for i = 1:length(list_images)
    image_name = [folder_name, '/', list_images(i).name];
    converted_name = [folder_name, '/', 'mat_', list_images(i).name, '.mat']
    [v]= FlirMovieReader([image_name]);
    v.unit = 'temperatureFactory';
    [image, ~] =step(v);
    image(i)=double(image);
    save(converted_name, image)
end