from sandpile import Sandpile
import numpy as np
import matplotlib.pyplot as plt

# Load the array
arr = np.load('pile_grid.npy')

# Set size of grid
rows = 101
cols = rows

middle = int(rows/2-1/2)

# First pile run
pile = Sandpile(rows = rows, cols = cols, grid = arr)
pile.set_sand(middle, middle, 2**10)
pile.run()
pile_grid = pile.get_pile()


# Plot pile
pile.show()

# Second pile run
pile = Sandpile(rows = rows, cols = cols, grid = pile_grid)
pile.set_sand(middle, middle, 2**10)
pile.run()
pile.get_pile()

# Plot pile
pile.show()

# Save the array
np.save('pile_grid', pile_grid)



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
