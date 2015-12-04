% Carregando imagem do carro
carro = imread('audi.jpg');
originalWindow = figure('Name','original');
imshow(carro);

%detectarFarois(carro);

% Escala de cinza
carroGray = rgb2gray(carro);
grayWindow = figure('Name', 'gray');
imshow(carroGray);

% Sobel
sobelFilter = fspecial('sobel');
carroSobelHorizontal = logical(im2bw(imfilter(carroGray, sobelFilter),0.5));
carroSobelVertical = logical(im2bw(imfilter(carroGray, sobelFilter'),0.5));
sobelWindowH = figure('Name', 'sobelHorizontal');
imshow(carroSobelHorizontal);
sobelWindowV = figure('Name', 'sobelVertical');
imshow(carroSobelVertical);
sobel = carroSobelHorizontal|carroSobelVertical;
%sobel = arrayfun((@(x,y)x&&y),carroSobelH, carroSobelW);
sobelWindow = figure('Name', 'sobel');
imshow(sobel);

% Limiar
threshold = 0.7;
carroThresh = im2bw(carroSobel,threshold);
threshWindow = figure('Name', 'threshold');
imshow(carroThresh);

% Filtro da média
carroFiltered = medfilt2(carroThresh, [5 5]);
filteredWindow = figure('Name', 'median filter');
imshow(carroFiltered);

% Fechamento
carroClosed = imclose(carroFiltered, strel('square',10));
closedWindow = figure('Name', 'closed');
imshow(carroClosed);

% Labeling
carroLabeled = bwlabel(carroFiltered);
carroColoredLabels = label2rgb(carroLabeled, 'colorcube', 'c', 'noshuffle');
coloredLabelsWindow = figure('Name', 'labels');
imshow(carroColoredLabels);

pause;
close all;