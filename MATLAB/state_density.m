%% Aboralian Sandpile State Density
% Authors: Aron Paulsson, Eliot Montesino Petren & Torbjörn Onshage
clear all;
close all;
clc;
w = warning ('off','all');

%% Calculate State Density
side_length = 3;

size = side_length * side_length;
Z = zeros(101,101);

tic
parfor NbrGrains = 0:3*size
    w = warning ('off','all');
    d = floor(NbrGrains/3);
    c = floor(mod(NbrGrains,3)/2);
    v = zeros(101,101);
    Xind = floor(100*NbrGrains / (3*size)) + 1;
    
    while d >= 0
        while c >= 0
            b = NbrGrains - 3*d - 2*c;
            a = size - b - c - d;
            if a >= 0
                Yind = floor(100*shannonEntropyAbcd(b,c,d,size)) + 1;
                permutations = nchoosek(size, a) * nchoosek(size - a, b) * nchoosek(size - a - b, c);
                v(Xind,Yind) = v(Xind, Yind) + permutations;
            end
    
            c = c - 1;
        end
        d = d - 1;
        c = floor((NbrGrains - 3*d)/2);  
    end
    Z = Z + v;
end
toc
Z = log(Z + 1);

%% Store Matrix

save(['data/StateDensity_side', num2str(side_length),'.mat'], 'Z')

%% Plot

fig_state_density = figure(); hold on;
title('State Density');
xlabel('Number of Grains [as a Fraction of the Maximal Number of Grains]')
ylabel('Shannon Entropy')
img = image([0, 1], [0,1], Z');
set(gca,'YDir','normal')
xlim([0,1])
ylim([0,1])
img.CDataMapping = 'scaled';
hold off;
c = colorbar();
c.Limits = [ 0, max(max( Z(~isinf(Z)) )) ];
caxis([0, max(max( Z(~isinf(Z)))) ])
colormap(hot)