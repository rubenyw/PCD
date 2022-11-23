clear; clc;
pisang = imread('pisang.png');
pisang = im2double(pisang);

imshow(pisang);

pisang_gray = rgb2gray(pisang);
figure; imshow(pisang_gray);

pisang_binar= imbinarize(pisang_gray);
figure; imshow(pisang_binar);

pisang_binar=~pisang_binar;
figure;imshow(pisang_binar); 

pisang_isi = imfill(pisang_binar, 'holes');
figure;imshow(pisang_isi);

pisang_berubang = pisang_isi & ~pisang_binar;
figure; imshow(pisang_berubang);

bigholes = bwareaopen(pisang_berubang, 200);
figure;imshow(bigholes)

smallholes = pisang_berubang & ~bigholes;
figure;imshow(smallholes);

new = pisang_binar | smallholes;
figure;imshow(new);