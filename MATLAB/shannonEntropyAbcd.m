function S = shannonEntropyAbcd(b, c, d, size)
    NbrGrains = 3*d + 2*c + b;
    logSum = d*3*log2(3) + 2*c;
    if NbrGrains ~= 0
        S = log2(NbrGrains) - logSum ./ NbrGrains;
        S = S / log2(size);
    else
        S = 0;
    end
end