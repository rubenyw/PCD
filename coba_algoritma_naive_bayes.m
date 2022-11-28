obj = imread('banana.png');
imshow(obj);

matriks = zeros(1,4);

obj_gray = rgb2gray(obj);
figure, imshow(obj_gray);

level = graythresh(obj);

bw = imbinarize(obj_gray, level);
figure, imshow(bw);

bw = imfill(bw, 'holes');
figure, imshow(bw);
bw = bwareaopen(bw,100);
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

matriks(1,1) = Hue;
matriks(1,2) = Saturation;
matriks(1,3) = Value;
matriks(1,4) = Luas;

kelas_latih = cell(2,1);
kelas_latih(1) = 'buah pisang';
kelas_latih(2) = 'bukan pisang';

%Naives Bayes
Mdl = fitcnb(matriks, kelas_latih);

hasil_latih = predict(Mdl, matriks);
