function pile = generateInitialBoard(pile_width, sand_sum, entropy)
    s = sand_sum;
    n = pile_width^2;
    H = entropy;
    k = s*(log2(s) - H*log2(n));
    d_max = floor(min([s/3, k/log2(27)]));
    d = 0:d_max;
    c = round((k - d *log2(27)) / log2(4));
    b = s - 3*d - 2*c; 
    
    valid = zeros(1,length(d));
    for i = 1:length(d)  
        valid(i) = ~(c(i)<=-0.5 || b(i)<=-0.5) && 0 <= (n - round(b(i)) - round(c(i)) - d(i));
    end
    b = b(valid==1);
    c = c(valid==1);
    d = d(valid==1);
    
    if (length(b) <= 0)
        disp('ERROR: No possible configurations')
        return
    end
    
    [~,i] = min((k - c*log2(4)-d*log2(27)).^2);
    i = randsample(i,1);
    b = round(b(i));
    c = round(c(i));
    d = round(d(i));
    a = n - b -c - d;

    v = [zeros(1,a), ones(1,b), 2*ones(1,c), 3*ones(1,d)];
    v = v(randperm(length(v)));
    
    pile = reshape(v,[pile_width, pile_width]);
end