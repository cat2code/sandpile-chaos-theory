%% Aboralian Sandpile Simulations
% Authors: Aron Paulsson, Eliot Montesino Petren & Torbjörn Onshage
clear all;
close all;
clc;

%% Initial Run

pile_width = 20;
simulation_length = 100000;

load(['data/StateDensity_side', num2str(pile_width),'.mat'])

%pile = 0 * ones(pile_width);
pile = randi([0, 3], pile_width, pile_width);
[~, avalanche_histogram, grain_sums, entropies, laplacians] = simulateSandpile(pile, simulation_length);

%% Plots

fig_avalanche_loglog = figure();
loglog(0:length(avalanche_histogram)-1, avalanche_histogram, '--')
title('Avalanches')
xlabel('Avalanche Size, Logarithmic')
ylabel('Number of Occurances, Logarithmic')
grid on; hold on;

fig_grain_sum = figure();
plot(grain_sums, '--')
title('Number of Grains in Pile per Iteration')
xlabel('Iteration')
ylabel('Number of Grains')
grid on; hold on;

fig_entropy = figure();
plot(entropies, '--')
title('Shannon Entropy of Pile per Iteration')
xlabel('Iteration')
ylabel('Shannon Entropy')
grid on; hold on;

% fig_laplacian = figure();
% plot(laplacians, '--')
% title('Laplacian Mean of Pile per Iteration')
% xlabel('Iteration')
% ylabel('Laplacian Mean')
% grid on; hold on;

fig_phase_ge = figure(); hold on;
title('Number of Grains and Shannon Entropy')
xlabel('Number of Grains [as a Fraction of the Maximal Number of Grains]')
ylabel('Shannon Entropy')
img = image([0, 1], [0,1], Z');
img.CDataMapping = 'scaled';
set(gca,'YDir','normal')
xlim([0,1])
ylim([0,1])
c = colorbar();
c.Limits = [ 0, max(max( Z(~isinf(Z)) )) ];
caxis([0, max(max( Z(~isinf(Z)))) ])
colormap(hot(1000))
plot(grain_sums, entropies, 'b--')
hold off;

% fig_phase_gl = figure();
% plot(grain_sums, laplacians, '--')
% title('Number of Grains and Laplacian Mean')
% xlabel('Number of Grains')
% ylabel('Laplacian Mean')
% grid on; hold on;
% 
% fig_phase_el = figure();
% plot(entropies, laplacians, '--')
% title('Shannon Entropy and Laplacian Mean')
% xlabel('Shannon Entropy')
% ylabel('Laplacian Mean')
% grid on; hold on;

%% More Runs

for i = 1:3
    pile = i * ones(pile_width);
    [~, avalanche_histogram, grain_sums, entropies, laplacians] = simulateSandpile(pile, simulation_length);
    
    figure(fig_avalanche_loglog);
    loglog(0:length(avalanche_histogram)-1, avalanche_histogram, '--')

    figure(fig_grain_sum);
    plot(grain_sums, '--')

    figure(fig_entropy);
    plot(entropies, '--')
    
%     figure(fig_laplacian);
%     plot(laplacians, '--')

    figure(fig_phase_ge);
    plot(grain_sums, entropies, '--')

%     figure(fig_phase_gl);
%     plot(grain_sums, laplacians, '--')
% 
%     figure(fig_phase_el);
%     plot(entropies, laplacians, '--')
end

%% Even More runs

for grain_sum = 250:250:2000
    
    pile = randi([0, 3], pile_width, pile_width);
    
    [~, avalanche_histogram, grain_sums, entropies, laplacians] = simulateSandpile(pile, simulation_length);
    
    figure(fig_avalanche_loglog);
    loglog(0:length(avalanche_histogram)-1, avalanche_histogram, '--')

    figure(fig_grain_sum);
    plot(grain_sums, '--')

    figure(fig_entropy);
    plot(entropies, '--')
    
%     figure(fig_laplacian);
%     plot(laplacians, '--')

    figure(fig_phase_ge);
    plot(grain_sums, entropies, '--')

%     figure(fig_phase_gl);
%     plot(grain_sums, laplacians, '--')
% 
%     figure(fig_phase_el);
%     plot(entropies, laplacians, '--')
end


