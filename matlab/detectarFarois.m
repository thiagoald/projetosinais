function [mascaraFarois] = detectarFarois( carImage )

    % Transformação para yCbCr
    carroYCbCr = rgb2ycbcr(carImage);
    
    % Isolando o canal Cr para identificar o farol
    carroCr = carroYCbCr(:,:,3);
    
    % Aplicando borramento (filtro da média) para remover frequências altas
    borrado = imfilter(carroCr,fspecial('average'));

    % Aplicando Laplaciano do Gaussiano para identificar borda do farol
    bordas = edge(borrado,'canny',0.1);
    
    % Aplicando fechamento para transformar farol numa área sólida
    mascaraFarois = imclose(bordas,strel('disk',15)).*255;
    
    % Aplicando abertura para eliminar outros detalhes e corrigir os limites da área do farol
    mascaraFarois = double((imopen(mascaraFarois, strel('disk',20)))./255);
    
end

