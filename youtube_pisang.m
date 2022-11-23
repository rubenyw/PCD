clear; clc;
pisang = imread('pisang.png');
pisang = im2double(pisang);

imshow(pisang);

cform = makecform('srgb2lab');
lab = applycform(pisang, cform);
figure; imshow(lab);

a = lab(:,:,2);
figure; imshow(a);

bwBF = a>5;
figure;imshow(bwBF);

bw = imfill(bwBF, 'holes');
figure; imshow(bw);

bw = ~bwareaopen(~bw, 20);

holes = bw & ~bwBF;
figure; imshow(holes)

bigholes = bwareaopen(bw, 200);
figure;imshow(bigholes);

smallholes = bw & ~bigholes;
figure;imshow(smallholes);