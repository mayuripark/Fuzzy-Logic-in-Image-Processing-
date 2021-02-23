%%
% Creater - Mayuri Parkhe, MATLAB Helper
% Website - https://matlabhelper.com
% Date    - 08/08/2020
% This script will show the results of Noise Reduction using Fuzzy Logic 
%%
clc 
clear all
close all
clear workspace
% Coversion in gray scale
I = imread('CT.jpg');
img2d = rgb2gray(I);
[y1,x1] = size(img2d);
%Add noise to the image
J = imnoise(img2d,'gaussian',0.02);
% Mean Filter
M = imnlmfilt(J);
% Median Filter
K = medfilt2(J);
figure(1)
subplot(2,2,1)
imshow(I)
title('Original Image')
subplot(2,2,2)
imshow(J)
title('Noisy Image')
subplot(2,2,3)
imshow(M)
title('Mean Filter')
subplot(2,2,4)
imshow(K)
title('Median Filter');
% Array conversion
Img = im2double(J);
Mean = im2double(M);
Median = im2double(K);
%Noise
noiseFIS = mamfis('Name','Noise Reduction');
noiseFIS = addInput(noiseFIS,[-1 1],'Name','Mean');
noiseFIS = addInput(noiseFIS,[-1 1],'Name','Median');
sx = 0.4;
sy = 0.7;
noiseFIS = addMF(noiseFIS,'Mean','gaussmf',[sx 0],'Name','zero');
noiseFIS = addMF(noiseFIS,'Median','gaussmf',[sy 0],'Name','zero');
noiseFIS = addOutput(noiseFIS,[0 1],'Name','Iout');
noiseFIS = addMF(noiseFIS,'Iout','gaussmf',[0.0314 0.0784 0.1686],'Name','Homogenous');
noiseFIS = addMF(noiseFIS,'Iout','gaussmf',[0.1314 0.1549 0.2078],'Name','Details');
figure(2)
subplot(2,2,1)
plotmf(noiseFIS,'input',1)
title('Mean')
subplot(2,2,2)
plotmf(noiseFIS,'input',2)
title('Median')
subplot(2,2,[3 4])
plotmf(noiseFIS,'output',1)
title('Iout')
r1 = "If Mean is zero and Median is zero then Iout is Homogenous";
r2 = "If Mean is not zero or Median is not zero then Iout is Details";
noiseFIS = addRule(noiseFIS,[r1 r2]);
noiseFIS.Rules
Ieval = zeros(size(Img));
for ii = 1:size(Img,1)
    Ieval(ii,:) = evalfis(noiseFIS,[(Mean(ii,:));(Median(ii,:))]');
end
figure(3)
image(Ieval,'CDataMapping','scaled')
colormap('gray')
title('Noise Reduction Using Fuzzy Logic')
writeFIS(noiseFIS,'Fuzzy_Noise')