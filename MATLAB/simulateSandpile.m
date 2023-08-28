function [pile, avalanche_histogram, grain_sums, entropies, laplacians] = simulateSandpile(pile, nbr_grains)

    pile_width = length(pile);
    pile_frame = zeros(pile_width+2); % zero padding to handle out of bounds
    
    avalanche_histogram = zeros(1000, 1);
    
    grain_sums = zeros(nbr_grains+1, 1);
    entropies = zeros(nbr_grains+1, 1);
    laplacians = zeros(nbr_grains+1, 1);
    
    % Append initial pile data
    grain_sums(1) = sum(sum(pile));
    entropies(1) = shannonEntropy(pile);
    laplacians(1) = sobelLaplacian(pile);   
    
    for idx_grain = 1:nbr_grains
        % Random grain placement
        idx_x = randi([1, pile_width]);
        idx_y = randi([1, pile_width]);
                
        avalanche_size = 0;
        
        % Add grain to pile
        %disp(['Adding grain ', num2str(idx_grain), ' of ', num2str(nbr_grains)]);
        pile(idx_x, idx_y) = pile(idx_x, idx_y) + 1;

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
        
        % Append pile data
        grain_sums(idx_grain+1) = sum(sum(pile));
        entropies(idx_grain+1) = shannonEntropy(pile);
        laplacians(idx_grain+1) = sobelLaplacian(pile);   
    end    
    
     grain_sums = grain_sums ./ (3 * pile_width * pile_width); % Get Number of Grains as a Fraction of Maximal Number of Grains
end
