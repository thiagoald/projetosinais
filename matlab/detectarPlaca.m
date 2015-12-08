function [labels, numLabels] = detectarPlaca(carImage)

carImageGray = rgb2gray(carImage);

elementoEstruturante = zeros(31,31);

elementoEstruturante(15,:) = ones(1,31);

[labels, numLabels] = bwlabel(imclose(imclose(edge(carImageGray,'canny',0.1),strel('disk',10)), elementoEstruturante));

labels = double(labels);

end

