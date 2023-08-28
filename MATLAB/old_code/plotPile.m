function plotPile(pile)
imagesc(pile);
axis square
c = colorbar; c.Limits = [0 3]; caxis([0 3]); c.TickLabels = [0 1 2 3];
colormap(jet(10))
colorbar
end

