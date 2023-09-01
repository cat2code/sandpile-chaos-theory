%% Aboralian Sandpile Simulations
% Authors: Aron Paulsson, Eliot Montesino Petren & Torbjörn Onshage
clear all;
close all;
clc;

%% Initial Run

pile_width = 10;
simulation_length = 10000;

load(['data/StateDensity_side', num2str(pile_width),'.mat'])
load(['data/Range_side', num2str(pile_width),'.mat'])

pile = 3 * ones(pile_width);
%pile = randi([0, 3], pile_width, pile_width);
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

fig_phase_ge_density = figure('position',[0,0,1600,900]); hold on;
title('Phase Space State Density, with a Trajectory')
xlabel('Number of Grains [as a Fraction of the Maximal Number of Grains]')
ylabel('Shannon Entropy')
img = image([0, 1], [0,1], Z');
img.CDataMapping = 'scaled';
set(gca,'YDir','normal')
xlim([0,1])
ylim([0,1])
c = colorbar();
c.Limits = [ 0, max(max( Z(~isinf(Z)) )) ];
c.Label.String = "Natural Logarithm of State Count";
c.Label.Rotation = 270;
c.Label.FontSize = 12;
c.Label.Position = c.Label.Position + [1, 0, 0];
caxis([0, max(max( Z(~isinf(Z)))) ])
colormap(hot(5000))
plot(grain_sums, entropies, 'g--')
legend('Trajectory','Location','southeast')
hold off;

fig_phase_ge_range = figure('position',[0,0,1600,900]); hold on;
title('Phase Space Power Lawness, with a Trajectory')
xlabel('Number of Grains [as a Fraction of the Maximal Number of Grains]')
ylabel('Shannon Entropy')
img = image([0, 1], [0,1], L');
img.CDataMapping = 'scaled';
set(gca,'YDir','normal')
xlim([0,1])
ylim([0,1])
c = colorbar();
c.Limits = [ -1, 1 ];
c.Label.String = 'Power Lawness';
c.Label.Rotation = 270;
c.Label.FontSize = 12;
c.Label.Position = c.Label.Position + [1, 0, 0];
caxis([-1, 1 ])
cmap = [ [zeros(1, 501), linspace(0.15,1,500)]', zeros(1001,1), [linspace(1,0.15,500), zeros(1, 501)]'];
colormap(cmap);
plot(grain_sums, entropies, 'g--')
legend('Trajectory','Location','southeast')
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


