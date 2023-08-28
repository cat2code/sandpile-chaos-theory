function plotPile(pile, pile_width)
    imagesc(pile);
    axis square
    xlim([0.5, pile_width + 0.5])
    ylim([0.5, pile_width + 0.5])
    c = colorbar;
    colormap(jet(10))
    colorbar
end

