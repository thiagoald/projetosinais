carro = imread('carro.jpg');
originalWindow = figure('Name','original');
imshow(carro);

carroGray = rgb2gray(carro);
grayWindow = figure('Name', 'gray');
imshow(carroGray);

sobelFilter = fspecial('sobel');
carroSobel = imfilter(carroGray, sobel);
sobelWindow = figure('Name', 'sobel');
imshow(carroSobel);

threshold = 125;
carroThresh = arrayfun(@(x)x>threshold, carroSobel);
threshWindow = figure('Name', 'threshold');
imshow(carroThresh);

carroFiltered = medfilt2(carroThresh, [5 5]);
filteredWindow = figure('Name', 'median filter');
imshow(carroFiltered);

carroClosed = imclose(carroFiltered, strel('square',10));
closedWindow = figure('Name', 'closed');
imshow(carroClosed);

carroLabeled = bwlabel(carroFiltered);

carroColoredLabels = label2rgb(carroLabeled, 'colorcube', 'c', 'noshuffle');