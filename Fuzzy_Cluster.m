%%
% Creater - Mayuri Parkhe, MATLAB Helper
% Website - https://matlabhelper.com
% Date    - 08/07/2020
% This script will show the results of Segmentation from Images Using Fuzzy C Means Clustering
%%
clc;
clear all;
close all;
clear workspace;
I= imread('CT.jpg');
imshow(I);
%%
Img = reshape(I,[],1);
Img = double(Img);
[IDX, nn, obj] = fcm(Img,4);
%%
save nn.mat
save IDX.mat
save obj.mat
%% 
load nn.mat
load IDX.mat
load obj.mat

%%
%Reshaping the clustered one dimensional arrey to four 2D array
 c1= nn(1,:);
 c2= nn(2,:);
 c3= nn(3,:);
 c4= nn(4,:);
 
 imIDX1 = reshape(c1, size(I));
 imIDX2 = reshape(c2, size(I)); 
 imIDX3 = reshape(c3, size(I));
 imIDX4 = reshape(c4, size(I));
 
 %Displaying the result of clustering.
 figure()
 subplot(2,2,1),imshow(imIDX1),title('1');
 subplot(2,2,2),imshow(imIDX2),title('2');
 subplot(2,2,3),imshow(imIDX3),title('3');
 subplot(2,2,4),imshow(imIDX4),title('4');
 