
clc;
clear all;
I = imread('1.jpg');
subplot(2,2,1),imshow(I);

% for i=2:6
%        
%  H = fspecial('gaussian',10,45);
%  image[i] = imfilter(I,H,'replicate');
    
H = fspecial('gaussian',10,45);
gaussian1 = imfilter(I,H,'replicate');
%imwrite(gaussian1,'1.jpg');
subplot(2,2,2),imshow(gaussian1);
H2 = fspecial('gaussian',10,25);

gaussian2 = imfilter(gaussian1,H2,'replicate');
subplot(2,2,3),imshow(gaussian2);
H3 = fspecial('gaussian',10,25);
gaussian3 = imfilter(gaussian2,H3,'replicate');
subplot(2,2,4),imshow(gaussian3);

%need to genarate 6 figures

%end
y= fspecial('laplacian');
laplacian1 = imfilter(I,y,'replicate');
figure,imshow(laplacian1);






detector = buildDetector();
%[bbox bbimg faces bbfaces] = detectFaceParts(detector,im,2);
[bbox,im_eye,im_no,im_mo] = detectFaceParts(detector,im);
imshow(im_eye);
imshow(im_no);
imshow(im_mo);


% 
% vSize = [256 256];
% imBig = rand([vSize 3]);
% nParts = [2 2]; %means divide into 4 parts, 2 horizontal, 2 vertical
% 
% blockproc(imBig, ceil(vSize ./ nParts), @yourAlgorithm);
% 
% 
% function res = yourAlgorithm(blockStruct)
%    %do your processing of the block here and 
%    %optionally return a result in 'res'
% 
%    %for example, just return the RGB vector of the first pixel
%    res = blockStruct.data(1,1,:);
% end