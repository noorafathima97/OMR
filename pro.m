I = imread('C:\Users\CCF\Desktop\music.jpg');
J = imnoise(I,'salt & pepper',0.02);
K = medfilt3(J);
imshow(K);
title('Noise Removal')
L = rgb2gray(K);
J = imbinarize(L,'adaptive','ForegroundPolarity','dark','Sensitivity',0.44);
imshow(J)
title('Binarization')
horizontalProfile = sum(J, 1);
figure;
bar(horizontalProfile);
title('Horizontal Projection')
verticalProfile = sum(J, 2);
figure;

bar(verticalProfile);
title('Vertical Projection')
%Rmin =1;
%Rmax =2;
%[centersDark, radiiDark] = imfindcircles(J,[Rmin Rmax],'ObjectPolarity','dark');
%viscircles(centersDark, radiiDark,'Color','b');
%title('Hough circle transform')

