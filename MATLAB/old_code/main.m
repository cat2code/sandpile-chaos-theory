pile_width= 32;
sand_sum = 500;  %Limited by 3*pile_width^2
entropy = 0.8;  %Between 0 and log(N)

pile = generateInitialBoard(pile_width, sand_sum, entropy);
plotPile(pile)

%disp(entropy);
%disp(shannonEntropy(pile));
%sum(sum(pile))

%close all
%pile_width = 11;        % Pile represented through 40x40 grid
%no_of_grains = 400;     % Run the simulation until 4000 new sand grains have been added
%draw_speed = 0.1;       % Animate the pile relatively slow
%empty_grid = true;
%avalanche_output = simulateSandpile(pile);