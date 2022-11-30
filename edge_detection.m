obj = imread('pisang 1.png');
figure, imshow(obj);

obj = imadjust(obj,[0.3 0.7],[]);
figure, imshow(obj);

obj = rgb2gray(obj);
figure, imshow(obj);

[~,threshold] = edge(obj,'Log');
fudgeFactor = 0.7;
BWs = edge(obj,'Log',threshold * fudgeFactor);
figure, imshow(BWs);

se90 = strel('line',3,90);
se0 = strel('line',3,0);
BWsdil = imdilate(BWs,[se90 se0]);
figure, imshow(BWsdil);

bwfill = imfill(BWsdil, 'holes');
bwfill = bwareaopen(bwfill,200);
bwfill = bwlabel(bwfill);
figure, imshow(bwfill);

seD = strel('diamond',4);
BWfinal = imerode(bwfill,seD);
BWfinal = imerode(BWfinal,seD);
figure, imshow(BWfinal);

