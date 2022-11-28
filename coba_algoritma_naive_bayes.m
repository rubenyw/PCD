obj = imread('banana.png');
imshow(obj);

matriks = zeros(1,4);

obj_gray = rgb2gray(obj);
figure, imshow(obj_gray);

level = graythresh(obj);

bw = imbinarize(obj_gray);
figure, imshow(bw);

bw = imcomplement(bw);
figure, imshow(bw);

bw2 = imfill(bw, 'holes');
bw = bwareaopen(bw,500);
subplot(1, 3, 2);
figure, imshow(bw);

HSV = rgb2hsv(obj);
figure, imshow(HSV);

H = HSV(:,:,1);
S = HSV(:,:,2);
V = HSV(:,:,3);

H(~bw) = 0;
S(~bw) = 0;
V(~bw) = 0;

Hue = sum(sum(H))/sum(sum(bw));
Saturation = sum(sum(S))/sum(sum(bw));
Value = sum(sum(V))/sum(sum(bw));

Luas = sum(sum(bw));

figure, imshow(H);
figure, imshow(S);
figure, imshow(V);
