%% Linearity of loglog in Phase Space
% Authors: Aron Paulsson, Eliot Montesino Petren & Torbjörn Onshage
clear all;
%close all;
%clc;

side_length = 20;
size = side_length * side_length;

%%

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
            NbrPiles = 10000;
            for idx=NbrGrains
                out = simulate_state(side_length,idx,Entropy,NbrPiles);

                if(isnan(out))
                    continue
                else
                    avalanche_histogram = avalanche_histogram + out;
                end
            end
            
            Y = avalanche_histogram(2:end);
            %Y = Y(1:find(Y~=0, 1, 'last'))
            
            range = find(Y~=0, 1, 'last') - find(Y~=0, 1);
            if isempty(range)
                tempL(i,j) = 0;
                continue
            end
            
            X = log( 1:length(Y) );
            X = X(find(Y~=0, 1):find(Y~=0, 1, 'last'));
            Y = Y(find(Y~=0, 1):find(Y~=0, 1, 'last'));
            
            Y(Y~=0) = log( Y(Y~=0) );
            
            if length(Y) < 2
                tempL(i,j) = 0;
                continue
            end
            
            R = corrcoef(X, Y);
            
            if sum(sum(isnan(R)))
                tempL(i,j) = 0;
                continue
            end
            
            tempL(i,j) = R(2) * range / size;
            
        end

    end
    L = L + tempL;
end

%% Store Matrix

save(['data/Range_side', num2str(side_length),'.mat'], 'L')

%save(['data/LinearCorrelation_side', num2str(side_length),'.mat'], 'L')

%% Plot

load(['data/Range_side', num2str(side_length),'.mat'])

% load(['data/LinearCorrelation_side', num2str(side_length),'.mat'])

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
c.Limits = [ -1, 1 ];
caxis([ -1, 1 ])
cmap = [ [zeros(1, 501), linspace(0.15,1,500)]', zeros(1001,1), [linspace(1,0.15,500), zeros(1, 501)]'];
colormap(cmap);
%colormap(hot(1000))
hold off;

