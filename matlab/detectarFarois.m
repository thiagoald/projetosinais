function [farol1 farol2] = detectarFarois( imagemCarro )
    % Transformação para yCbCr
    carroYCbCr = rgb2ycbcr(imagemCarro);
    
    % Aplica limiarização no canal Cr para identificar o farol
    farois = arrayfun(@checkColorRange, carroYCbCr(:,:,1), carroYCbCr(:,:,2), carroYCbCr(:,:,3));
    farois = cast(farois,'uint8');
    % TODO: substituir por um top hat?
    farois = imclose(farois,strel('disk',20));
    farois = imopen(farois,strel('disk',20));
    
    % Agrupa pixels próximos
    labelFarois = bwlabel(farois);
    
    figure('Name', 'Selecione');
    imshow(imagemCarro);
    while(1)
        coordinates = ginput(1);
        coordinates = int64(coordinates);
        labelSelecionada = (labelFarois == (labelFarois(coordinates(2),coordinates(1))));
        R = imagemCarro(:,:,1).*uint8(labelSelecionada);
        G = imagemCarro(:,:,2).*uint8(labelSelecionada);
        B = imagemCarro(:,:,3).*uint8(labelSelecionada);
        gray = rgb2gray(imagemCarro).*(1-uint8(labelSelecionada));
        imagemCarroSelecionada = cat(3,gray,gray,gray)+cat(3,R,G,B);
        imshow(imagemCarroSelecionada);
    end
    
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

