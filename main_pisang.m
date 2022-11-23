clear; clc;
pisang = imread('pisang.png');
pisang = im2double(pisang);

imshow(pisang);

pisang_gray = rgb2gray(pisang);
figure; imshow(pisang_gray);

t=graythresh(pisang_gray);

pisang_binar= imbinarize(pisang_gray, t);
figure; imshow(pisang_binar);

pisang_binar=~pisang_binar;
figure;imshow(pisang_binar);

pisang_isi = imfill(pisang_binar, 'holes');
figure;imshow(pisang_isi);