clc;
clear all;
close all;
I=imread('1.jpg');
subplot 444
imshow(I);
[r c p]= size(I);%r-rows,c-columns,p-planes
A=I(1:r/2,1:c/2,:);
B=I(1:r/2,c/2+1:c,:);
C=I(r/2+1:r,1:c/2,:);
D=I(r/2+1:r,c/2+1:c,:);
subplot 442
imshow(A);
title('Image part 1');
subplot 443
imshow(B);
title('Image part 2');
subplot 445
imshow(C);
title('Image part 3');
subplot 446
imshow(D);
title('Image part 4');