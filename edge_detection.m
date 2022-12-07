clc, clear
close all
warning off

obj = imread('pensil.png');
% figure, imshow(obj);
buah = true;
obj2 = obj;
figure, imshow(obj);

% edge_detected_image = bwareaopen(imfill(imclose(edge(rgb2gray(obj),'sobel'),strel('diamond',4)),'holes'),100000);
% figure, imshow(edge_detected_image);

obj =imadd(obj, 50);
figure, imshow(obj);
obj = imadjust(obj,[0.2 0.8]);
figure, imshow(obj);
obj = rgb2gray(obj);
obj = edge(obj,'log');
obj = bwareaopen(obj, 30);
figure, imshow(obj);
obj = imclose(obj, strel('disk', 60));
figure, imshow(obj);
obj = imfill(obj, 'holes');
figure, imshow(obj);
BWfinal = imerode(obj,strel('diamond',1));
figure, imshow(BWfinal);

se = strel('sphere',5);
BWfinal = imerode(BWfinal, se);
figure, imshow(BWfinal);


R = obj2(:,:,1);
G = obj2(:,:,2);
B = obj2(:,:,3);

R(~BWfinal) = 0;
G(~BWfinal) = 0;
B(~BWfinal) = 0;
RGB = cat(3,R,G,B);
figure, imshow(RGB);
total = numel(BWfinal);
Luas = length(BWfinal(BWfinal~=0));
%deteksi bentuk
[labeled, numObjects] = bwlabel(BWfinal);
labelrgb = label2rgb(labeled);


s = regionprops(labeled, {'Area', 'Perimeter', 'BoundingBox'});
luas =  cat(1, s.Area);
keliling = cat(1,s.Perimeter);
bbox = cat(1,s.BoundingBox);
metric = 4*pi*luas./(keliling.^2);

cek = false;
for k = 1 : numObjects
    if (metric(k) < 0.6) && (metric(k) >= 0.3)
        RGB2 = insertObjectAnnotation(RGB, 'rectangle', bbox(k,:), 'Pisang','LineWidth', 3, 'Color', 'y', 'FontSize', 24);
        cek = true;
    else
        RGB2 = insertObjectAnnotation(RGB, 'rectangle', bbox(k,:), 'Bukan Pisang','LineWidth', 3, 'Color', 'y', 'FontSize', 24);
    end
    figure, imshow(RGB2);
end 

%deteksi warna
matang = 'bukan pisang';
if(cek == true)
    HSV = rgb2hsv(RGB);

    H = HSV(:,:,1);
    S = HSV(:,:,2);

    [r,c,v] = find((H>30/255 & H<54/255 & S>50/255));

    numid = size(r,1);
    bw = false(size(RGB,1), size(RGB,2));
    for i = 1:numid
        bw(r(i),c(i)) =1;
    end

    bw = imfill(bw, 'holes');
    bw = bwareaopen(bw, 1000);

    R = RGB(:,:, 1);
    G = RGB(:,:, 2);
    B = RGB(:,:, 3);

    R(~bw) = 0;
    G(~bw) = 0;
    B(~bw) = 0;
    img = cat(3,R,G,B);
    figure , imshow(img);

    img = imbinarize(rgb2gray(img));
    figure, imshow(img);
    Luas_kuning = length(img(img~=0));

    if(Luas_kuning >= (Luas/100*40))
        matang = 'segar';
    else
        matang = 'tidak segar';
    end
    
end

%j = rgb2gray(img);

%k = imbinarize(j,.95);

% i = double(img);
% figure , imshow(i);
% 
% img = rgb2gray(img);
% figure,imshow(img);
% img = imbinarize(img);
% figure, imshow(img);






% figure, imshow(obj);
% 
% obj = rgb2gray(obj);
% % figure, imshow(obj);
% 
% [~,threshold] = edge(obj,'Log');
% fudgeFactor = 0.7;
% BWs = edge(obj,'Log',threshold * fudgeFactor);
% % figure, imshow(BWs);
% 
% se90 = strel('line',3,90);
% se0 = strel('line',3,0);
% BWsdil = imdilate(BWs,[se90 se0]);
% % figure, imshow(BWsdil);
% 
% bwfill = imfill(BWsdil, 'holes');
% bwfill = bwareaopen(bwfill,200);
% bwfill = bwlabel(bwfill);
% % figure, imshow(bwfill);
% 
% seD = strel('diamond',1);
% BWfinal = imerode(obj,seD);
% figure, imshow(BWfinal);
% BWfinal = imerode(BWfinal,seD);
% BWfinal = imerode(BWfinal,seD);
% BWfinal = imerode(BWfinal,seD);
% BWfinal = imerode(edge_detected_image,seD);
% figure, imshow(BWfinal);
% 
