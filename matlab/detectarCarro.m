% Carregando imagem do carro
carro = imread('carro (4).jpg');
originalWindow = figure('Name','original');
imshow(carro);

detectarFarois(carro);

% Escala de cinza
carroGray = rgb2gray(carro);
grayWindow = figure('Name', 'gray');
imshow(carroGray);

% Sobel
sobelFilter = fspecial('sobel');
carroSobel = imfilter(carroGray, sobelFilter);
sobelWindow = figure('Name', 'sobel');
imshow(carroSobel);

% Limiar
threshold = 50;
carroThresh = arrayfun(@(x)x>threshold, carroSobel);
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