function avalanche_output = simulateSandpile(pile)
%% run model
no_of_grains = (length(pile));
add_pos = 1;
for grain = 1:no_of_grains
    % add grain to pile
    fprintf('Adding grain %.0f of %.0f...\n', grain, no_of_grains);
    
    pile(add_pos) = pile(add_pos) + 1;
    add_pos = add_pos +1;
    avalanche_size = 0;
    
    % resolve peaks
    draw_speed = 0;
    peaks = scanPileForPeaks(pile);
    intermediate_piles = [];
    while numel(peaks) ~= 0
        [pile, intermediate_piles] = resolvePeaks(pile, peaks);
        if ~isempty(intermediate_piles)
            if draw_speed
                pile_store = cat(3, pile_store, intermediate_piles);
            end
            avalanche_size = avalanche_size + size(intermediate_piles, 3);
        end
        peaks = scanPileForPeaks(pile);
    end
    
    % update avalanche counter
    if avalanche_size > 0
        if numel(avalanche_plt)>=avalanche_size
            avalanche_plt(avalanche_size) = ...
                avalanche_plt(avalanche_size)+1;
        else
            avalanche_plt(avalanche_size) = 1;
        end
        fprintf(['Captured avalanche with duration of %.0f time ',...
            'steps.\n'], avalanche_size);
    end
   
    %plotShannon(shannonPlot, pile, grain);
end

avalanche_output = [1:numel(avalanche_plt);avalanche_plt]';
