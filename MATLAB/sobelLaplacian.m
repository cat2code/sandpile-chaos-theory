function [laplacian_mean, laplacian_variance, laplacian_pile] = sobelLaplacian(pile)
    %dX = [1, 0, -1; 2, 0, -2; 1, 0, -1]; % Sobel
    %dY = [1, 2, 1; 0, 0, 0; -1, -2, -1]; % Sobel
    
    dX = [1, 0, -1; 162/47, 0, -162/47; 1, 0, -1]; % Scharr
    dY = [1, 162/47, 1; 0, 0, 0; -1, -162/47, -1]; % Scharr
    
    Gx = conv2(pile, dX);
    Gy = conv2(pile, dY);
    
    G2x = conv2(Gx(2:end-1, 2:end-1), dX);
    G2y = conv2(Gy(2:end-1, 2:end-1), dY);
    
    laplacian_pile = abs(G2x(2:end-1, 2:end-1) + G2y(2:end-1, 2:end-1));
    
    laplacian_mean = mean(reshape(laplacian_pile,[],1));
    laplacian_variance = var(reshape(laplacian_pile,[],1));
end