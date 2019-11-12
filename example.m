% storedStructure = load('/Users/sakumoil/Documents/Opinnot/Kandi/thermal_scripts/subject100/0 minute_fridge (2).mat');
% img = storedStructure.image;

img = 'C:\Users\admin\Projects\Bachelors\helsinki thermal\10\Mikro1min10\0 minute_warm1 left medial10.jpg';

[v]= FlirMovieReader([img]);
v.unit = 'temperatureFactory';
[image, ~] =step(v);
image=double(image);

normalizedImage = uint8(255*mat2gray(image));
BW = normalizedImage > 180;
BW_fill = imfill(BW, 'holes');
BW_fill = bwareafilt(BW_fill, 2, 4);
blobMeasurements = regionprops(BW_fill, normalizedImage, 'all');

image = imresize(image, 2);

imshow(BW_fill);
alteredimage = normalizedImage;

numberOfBlobs = size(blobMeasurements, 1)

% BW = double(BW);
% BW_fill = double(BW_fill);
% BW_diff = imabsdiff(BW, BW_fill);
% areas_filled = find(BW_diff);

% id = 0;
% for k = 1 : numberOfBlobs
%     id = id + 1;
%     blobCentroid = blobMeasurements(k).Centroid;
%     blobArea = blobMeasurements(k).Area;
%     ellipseX = blobCentroid(1) - 107/2;
%     ellipseY = blobCentroid(2) - 132/2;
%     hEllipse(id) = imellipse(gca, [ellipseX, ellipseY, 60, 30]);
%     wait(hEllipse(id));
%     BW = createMask(hEllipse(id));
%     se = strel('disk', 2, 8);
%     BW2 = BW - imerode(BW, se);
%     alteredimage(BW2==1) = max(image(:));
%     imshow(alteredimage)
%     [average(id), maximum(id), minimum(id), standard(id), homogeneity1(id), entropy1(id), homogeneity2(id), entropy2(id)] = calcul_parameters(img,BW);
%     textural(1, id, 1) = average(id);
%     textural(1, id, 2) = maximum(id);
%     textural(1, id, 3) = minimum(id);
%     textural(1, id, 4) = standard(id);
%     textural(1, id, 5) = homogeneity1(id);
%     textural(1, id, 6) = entropy1(id);
%     textural(1, id, 7) = homogeneity2(id);
%     textural(1, id, 8) = entropy2(id);

% end

% for j = 1 : 4
%     id = id + 1;
%     hEllipse(id) = imellipse(gca);
%     wait(hEllipse(id));
%     BW = createMask(hEllipse(id));
%     se = strel('disk', 2, 8);
%     BW2 = BW - imerode(BW, se);
%     alteredimage(BW2==1) = max(image(:));
%     imshow(alteredimage)
%     [average(id), maximum(id), minimum(id), standard(id), homogeneity1(id), entropy1(id), homogeneity2(id), entropy2(id)] = calcul_parameters(img,BW);
%     textural(1, id, 1) = average(id);
%     textural(1, id, 2) = maximum(id);
%     textural(1, id, 3) = minimum(id);
%     textural(1, id, 4) = standard(id);
%     textural(1, id, 5) = homogeneity1(id);
%     textural(1, id, 6) = entropy1(id);
%     textural(1, id, 7) = homogeneity2(id);
%     textural(1, id, 8) = entropy2(id);
% end

% delete(hEllipse);

% save("TEST", 'image', 'textural');

% for k = 1 : numberOfBlobs
%     blobCentroid = blobMeasurements(k).Centroid;
%     blobArea = blobMeasurements(k).Area;
%     plot(blobCentroid(1), blobCentroid(2), 'rx');
% end


% figure; imhist(normalizedImage);
% hold on;
% yAxisLimits = ylim();
% line([140, 141], yAxisLimits, 'Color', 'r', 'LineWidth', 2);
% set(gca,'XColor', 'none','YColor','none');
% title('Default threshold of 140', 'FontSize', 24);
