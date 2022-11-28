clc; clear; close all; warning off all;

obj = imread('pisang.png');
figure, imshow(obj);

b = rgb2gray(obj);
figure, imshow(b);


c = imbinarize(b);
figure, imshow(c);

d = imcomplement(c);
figure, imshow(d);

e = imfill(d, 'holes');
figure, imshow(e);

[labeled, numObjects] = bwlabel(e);
figure, imshow(labeled);