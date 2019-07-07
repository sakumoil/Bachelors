clear
clc



[v]= FlirMovieReader('C:\Users\jtheveno\Desktop\thermal\kuva1.jpg');
v.unit = 'temperatureFactory';          % set the desired unitwhile
[image, metadata] =step(v);
image=double(image);

imshow(image,[]);
h = imellipse;
position=wait(h);
BW = createMask(h);
delete(h);

se = strel('disk',2,8);
BW2=BW-imerode(BW,se);
image(BW2==1)=max(image(:));
imshow(image,[]);


