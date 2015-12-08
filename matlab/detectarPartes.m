function [ ] = detectarPartes( imagemCarro )

% Gerando a mascara dos farois e labels da placa
mascaraFarois = detectarFarois(imagemCarro);
[labelsPlaca, numLabels] = detectarPlaca(imagemCarro);

% Juntando as duas
labels = labelsPlaca.*(1-mascaraFarois) + mascaraFarois.*(numLabels+1);
label2rgb(labels, 'colorcube', 'c', 'noshuffle');

imshow(imagemCarro);

while(1)
    % Selecionando o pixel na placa
    pixelSelecionado = int64(ginput(1));
    labelEscolhida = labels(pixelSelecionado(2),pixelSelecionado(1));

    mascaraEscolhida = uint8(labels == labelEscolhida);

    imagemCarroR = imagemCarro(:,:,1);
    imagemCarroG = imagemCarro(:,:,2);
    imagemCarroB = imagemCarro(:,:,3);

    blurFactor = 25;
    imagemCarroBorrada = imfilter(imagemCarro, ones(blurFactor,blurFactor)/(blurFactor*blurFactor));
    imagemCarroBorradaR = imagemCarroBorrada(:,:,1)/1.2;
    imagemCarroBorradaG = imagemCarroBorrada(:,:,2)/1.2;
    imagemCarroBorradaB = imagemCarroBorrada(:,:,3)/1.2;

    imagemCarroBorradaR = imagemCarroBorradaR.*(1-mascaraEscolhida)+imagemCarroR.*(mascaraEscolhida);
    imagemCarroBorradaG = imagemCarroBorradaG.*(1-mascaraEscolhida)+imagemCarroG.*(mascaraEscolhida);
    imagemCarroBorradaB = imagemCarroBorradaB.*(1-mascaraEscolhida)+imagemCarroB.*(mascaraEscolhida);

    imagemCarroBorrada = cat(3,imagemCarroBorradaR, imagemCarroBorradaG, imagemCarroBorradaB);
    imshow(imagemCarroBorrada);
end

end

