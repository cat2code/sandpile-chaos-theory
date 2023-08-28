function S = shannonEntropy(pile)
    grid_size = numel(pile);
    sum_ = 0;
    n = 0;
    for i = 1:grid_size
        height = pile(i);
        if(height ~= 0)
            sum_ = sum_ + height * log2(height);
            n = n + height;
        end
    end
    
    if(n ~= 0)
        S = -(sum_/n - log2(n)) / log2(grid_size);
    else
        S = 0;
    end
end