% storedStructure = load('/Users/sakumoil/Documents/Opinnot/Kandi/thermal_scripts/subject100/0 minute_fridge (2).mat');
img = csvread('/Users/sakumoil/Documents/Opinnot/Kandi/thermal_scripts/CSV/patient1/1.csv');

% img = storedStructure.image;

normalizedImage = uint8(255*mat2gray(img));
% imshow(normalizedImage)
% subplot(1, 3, 1);
% imshow(normalizedImage);
% title('Normalized thermal image');

BW = normalizedImage > 140;
% subplot(1, 3, 2);
% imshow(BW);
% title('Binarized thermal image');


% subplot(1, 3, 3);
% title('Binary image with holes filled');
BW_fill = imfill(BW, 'holes');
imshow(BW_fill);
% hold on;
blobMeasurements = regionprops(BW_fill, normalizedImage, 'all');
numberOfBlobs = size(blobMeasurements, 1);

blobCentroid = blobMeasurements(1).Centroid;
blobArea = blobMeasurements(1).Area;
ellipseX = 107;
ellipseY = 132;
hEllipse = imellipse(gca, [ellipseX, ellipseY, 60, 30]);
wait(hEllipse);
BW = createMask(hEllipse);
delete(hEllipse);
se = strel('disk', 2, 8);
BW2 = BW - imerode(BW, se);


% for k = 1 : numberOfBlobs
%     blobCentroid = blobMeasurements(k).Centroid;
%     blobArea = blobMeasurements(k).Area;
%     plot(blobCentroid(1), blobCentroid(2), 'rx');
% end

[average, maximum, minimum, standard, homogeneity1, entropy1, homogeneity2, entropy2] = calcul_parameters(img,BW)

% figure; imhist(normalizedImage);
% hold on;
% yAxisLimits = ylim();
% line([140, 141], yAxisLimits, 'Color', 'r', 'LineWidth', 2);
% set(gca,'XColor', 'none','YColor','none');
% title('Default threshold of 140', 'FontSize', 24);
