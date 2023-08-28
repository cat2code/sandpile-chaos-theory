function  plotShannon(shannonPlot, pile, ct)
    S = shannonEntropy(pile);
    set(shannonPlot, 'XData', [shannonPlot.XData, ct-1],'YData', [shannonPlot.YData, S]);
end