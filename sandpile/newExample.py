### newExample.py

from sandpile import Sandpile
import numpy as np
import matplotlib.pyplot as plt
import random

# Load am array
#arr = np.load('pile_grid.npy')

# Set size of grid
rows = 101
cols = rows

middle = int(rows/2-1/2)
pile = Sandpile(rows = rows, cols = cols)


# Maybe a faster way: get sand in x y and + 1 

# put a single grain of sand n times
n = 100000
for i in range(n):
    random_x = random.randint(0,100)
    random_y = random.randint(0,100)
    placing_pile = Sandpile(rows = rows, cols = cols)
    placing_pile.set_sand(random_x, random_y, 1)
    pile = pile + placing_pile
    
pile.show()

# # First pile run
# pile = Sandpile(rows = rows, cols = cols)
# pile.set_sand(middle, middle, 2**10)
# pile.run()
# pile_grid = pile.get_pile()


# # Plot pile
# pile.show()




# # Second pile run
# pile = Sandpile(rows = rows, cols = cols, grid = pile_grid)
# pile.set_sand(middle, middle, 2**10)
# pile.run()
# pile.get_pile()

# # Plot pile
# pile.show()

# # Save the array
# np.save('pile_grid', pile_grid)



# print(np.array_equal(pile_grid, pile_grid) and np.all(pile_grid == pile_grid)) # test gone wrong?

# # create a figure with two subplots
# fig, axs = plt.subplots(1, 2)

# # display the arrays in the subplots
# axs[0].imshow(pile_grid)
# axs[0].set_title('Array 1')
# axs[1].imshow(pile_grid)
# axs[1].set_title('Array 2')

# # show the figure
# plt.show()

# # Save pile
# #pile.save(filename = "2^20 grains(2).png")
