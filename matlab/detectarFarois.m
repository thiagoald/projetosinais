function [farol1 farol2] = detectarFarois( imagemCarro )
    % Transformação para yCbCr
    carroYCbCr = rgb2ycbcr(imagemCarro);
    
    % Aplica limiarização no canal Cr para identificar o farol
    farois = arrayfun(@checkColorRange, carroYCbCr(:,:,1), carroYCbCr(:,:,2), carroYCbCr(:,:,3));
    farois = cast(farois,'uint8');
    
    % Agrupa pixels próximos
    labelFarois = bwlabel(farois);
    
    % Gera imagem para ser exibida
    farolColoredLabels = label2rgb(labelFarois, 'colorcube', 'c', 'noshuffle');
    
    % TODO: Calcular o centróide dos agrupamentos identificados
    farol1 = arrayfun(@(x)x==1, labelFarois);
    farol2 = arrayfun(@(x)x==2, labelFarois);
    
    % TODO: Rodar o sobel no canal Cr e elevar todos os pixels ao quadrado
    % Criando o Sobel
    filtroSobel = fspecial('sobel');
    farois = imfilter(carroYCbCr(:,:,3), filtroSobel).^2;
    farois = imerode(farois, strel('disk',5));
    %farois = imclose(farois, strel('disk',20));
    figure;
    imshow(farois);
    pause;
    %       Depois rodar um fechamento para tornar os faróis sólidos
    %       Finalmente, recortar o que foi identificado da imagem original
    
    
    % Mostra agrupamentos
    figure;
    imshow(farolColoredLabels);
end

