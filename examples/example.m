storedStructure = load('/Users/sakumoil/Documents/Opinnot/Kandi/thermal_scripts/subject100/0 minute_fridge (2).mat');
img = storedStructure.image;
normalizedImage = uint8(255*mat2gray(img));
subplot(1, 3, 1);
imshow(normalizedImage);
title('Normalized thermal image');

BW = normalizedImage > 140;
subplot(1, 3, 2);
imshow(BW);
title('Binarized thermal image');


subplot(1, 3, 3);
imshow(BW_fill);
title('Binary image with holes filled');
BW_fill = imfill(BW, 'holes');
hold on;
blobMeasurements = regionprops(BW_fill, normalizedImage, 'all');
numberOfBlobs = size(blobMeasurements, 1);
for k = 1 : numberOfBlobs
    blobCentroid = blobMeasurements(k).Centroid;
    blobArea = blobMeasurements(k).Area;
    plot(blobCentroid(1), blobCentroid(2), 'rx');
end


% figure; imhist(normalizedImage);
% hold on;
% yAxisLimits = ylim();
% line([140, 141], yAxisLimits, 'Color', 'r', 'LineWidth', 2);
% set(gca,'XColor', 'none','YColor','none');
% title('Default threshold of 140', 'FontSize', 24);
