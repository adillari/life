from gridv1 import Grid

def main():
  input = input("Enter a grid size for the game: ")
  grid_size = Int(input)
  world = Grid.random(grid_size, grid_size)
  world.live()
