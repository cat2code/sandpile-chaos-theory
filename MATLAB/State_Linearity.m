%% Linearity of loglog in Phase Space
% Authors: Aron Paulsson, Eliot Montesino Petren & Torbjörn Onshage
clear all;
close all;
clc;

side_length = 3;
size = side_length * side_length;

load(['data/StateDensity_side', num2str(side_length),'.mat'])

L = zeros(101,101);

parfor i = 1:length(Z)
    w = warning ('off','all');
    %i
    tempL = zeros(101,101);
    for j = 1:length(Z)
        if Z(i,j) ~= 0
            NbrGrains = ceil((i-1)*3*size/100):ceil(3*i*size/100)-1;
            NbrGrains = NbrGrains(NbrGrains <= 3*size);
            Entropy = (j-1)/100;
            
            avalanche_histogram = zeros(1000, 1);
            NbrPiles = 1000;
            for idx=NbrGrains
                out = simulate_state(side_length,idx,Entropy,NbrPiles);

                if(isnan(out))
                    continue
                else
                    avalanche_histogram = avalanche_histogram + out;
                end
            end
            
            Y = avalanche_histogram(2:end);
            
            min_length = 25;
            if length(Y) > min_length
               %idx = find(Y, 1, 'last')
               Y = Y(1:find(Y, 1, 'last'))
            end
            
            Y = [Y; zeros(min_length-length(Y),1)]
            Y(Y~=0) = log( Y(Y~=0) );
            
            X = log( 1:length(Y) );
            
            R = corrcoef(X, Y);
            
            Y
            
            if (length(R) < 2)
                tempL(i,j) = 0;                
            else
                if isnan(R(2))
                    tempL(i,j) = 0;
                else
                    tempL(i,j) = abs(R(2));
                end
            end
        end

    end
    L = L + tempL;
end

%% Store Matrix

save(['data/LinearCorrelation_side', num2str(side_length),'.mat'], 'L')

%% Plot

load(['data/LinearCorrelation_side', num2str(15),'.mat'])

fig_state_density = figure(); hold on;
title('State Density');
xlabel('Number of Grains [as a Fraction of the Maximal Number of Grains]')
ylabel('Shannon Entropy')
img = image([0, 1], [0,1], L');
img.CDataMapping = 'scaled';
set(gca,'YDir','normal')
xlim([0,1])
ylim([0,1])
c = colorbar();
c.Limits = [ 0, max(max( L(~isinf(L)) )) ];
caxis([0, max(max( L(~isinf(L)))) ])
colormap(hot(1000))
hold off;

