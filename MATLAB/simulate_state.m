function avalanche_histogram = simulate_state(pile_width, NbrGrains, entropy, NbrPiles)
    size = pile_width^2;
    k = NbrGrains*(log2(NbrGrains) - entropy*log2(size));
    d_max = floor(min([NbrGrains/3, k/log2(27)]));
    d_min = floor(max([0,(NbrGrains-2*size)/3]));
    d = d_min:d_max;
    c = round((k - d *log2(27)) / log2(4));
    b = NbrGrains - 3*d - 2*c; 
    
    valid = zeros(1,length(d));
    for i = 1:length(d)  
        valid(i) = (c(i)>=0 && b(i)>=0) && 0 <= (size - round(b(i)) - round(c(i)) - d(i));
    end
    b = b(valid==1);
    c = c(valid==1);
    d = d(valid==1);
    
    if (length(b) <= 0)
        %disp('ERROR: No possible configurations')
        avalanche_histogram = NaN;
        return
    end
    
    S = shannonEntropyAbcd(b,c,d,size);
    idx = abs(S - entropy) <= 0.005;
    d = d(idx);
    c = c(idx);
    b = b(idx);
    a = size - b - c - d;

    if (length(b) <= 0)
        %disp('ERROR: No possible configurations in square')
        avalanche_histogram = NaN;
        return
    end

    permutations = zeros(length(a),1);
    for i=1:length(a)
        permutations(i) = nchoosek(size, a(i)) * nchoosek(size - a(i), b(i)) * nchoosek(size - a(i) - b(i), c(i));
    end
    
    avalanche_histogram = zeros(1000, 1);
    pile_frame = zeros(pile_width+2);

    for pileIdx = 1:NbrPiles
        sampleIdx = randsample(length(a),1,true,permutations);
        v = [zeros(1,a(sampleIdx)), ones(1,b(sampleIdx)), 2*ones(1,c(sampleIdx)), 3*ones(1,d(sampleIdx))];
        v = v(randperm(length(v)));
        original_pile = reshape(v,[pile_width, pile_width]);

        collapses = (original_pile == 3);
        avalanche_histogram(1) = avalanche_histogram(1) + size - length(collapses);

        for i = 1:length(collapses)
            avalanche_size = 0;
            pile = original_pile;
            pile(collapses(i)) = pile(collapses(i)) + 1;
            while true
                % Obtain peak locations
                [peaks_x, peaks_y] = find(pile >= 4);
    
                % Break if there are no peaks
                if length(peaks_x) <= 0
                    break;
                end

                % Resolve present peaks
                for idx_peak = 1:length(peaks_x)
                    x = peaks_x(idx_peak);
                    y = peaks_y(idx_peak);
                    
                    pile_frame(2:end-1, 2:end-1) = pile;
                    pile_frame( x:x+2, y:y+2 ) = pile_frame( x:x+2, y:y+2 ) + [0, 1, 0; 1, -4, 1; 0, 1, 0];
                    pile = pile_frame(2:end-1, 2:end-1);
    
                    avalanche_size = avalanche_size + 1;
                end
            end
            % Update avalanche histogram
            %disp(['Avalanche Size: ', num2str(avalanche_size)]);
            if length(avalanche_histogram) >= avalanche_size + 1
                avalanche_histogram( avalanche_size+1 ) = avalanche_histogram( avalanche_size+1 ) + 1;
            else
                avalanche_histogram( avalanche_size+1 ) = 1;
            end
        end
    end
end