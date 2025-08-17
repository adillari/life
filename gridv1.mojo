from time import sleep
import random

@fieldwise_init
struct Grid(Copyable, Movable, Stringable):
  var data: List[List[Int]]

  fn live(mut self):
    while True:
        for _ in range(len(self.data)):
          print("--", end="")
        print()

        print(String(self))
        sleep(0.1)

        self.evolve()

  fn evolve(mut self):
    next_generation = List[List[Int]]()

    for row in range(len(self.data)):
      next_generation.append([])
      row_above = (row - 1) % len(self.data)
      row_below = (row + 1) % len(self.data)
      for pixel in range(len(self.data[row])):
        pixel_left = (pixel - 1) % len(self.data[row])
        pixel_right = (pixel + 1) % len(self.data[row])

        living_neighbors = (
          self[row_above, pixel_left]
          + self[row_above, pixel]
          + self[row_above, pixel_right]
          + self[row, pixel_left]
          + self[row, pixel_right]
          + self[row_below, pixel_left]
          + self[row_below, pixel]
          + self[row_below, pixel_right]
        )

        if self[row, pixel] == 1 and (living_neighbors == 2 or living_neighbors == 3):
          next_generation[-1].append(1)
        elif self[row, pixel] == 0 and living_neighbors == 3:
          next_generation[-1].append(1)
        else:
          next_generation[-1].append(0)

    self.data = next_generation

  @staticmethod
  fn random(height: Int, width: Int) -> Self:
    random.seed()

    var data: List[List[Int]] = []

    for _ in range(height):
      data.append([])
      for _ in range(width):
        data[-1].append(Int(random.random_si64(0, 1)))

    return Self(data)

  fn __getitem__(self, x: Int, y: Int) -> Int:
    return self.data[x][y]

  fn __setitem__(mut self, x: Int, y: Int, value: Int):
    self.data[x][y] = value

  fn __str__(self) -> String:
    row_num = 0
    str = ""

    for row in self.data:
      for pixel in row:
        if pixel == 1:
          str += "* "
        else:
          str += "  "

      if row_num < len(self.data)-1:
        str += "\n"
      row_num += 1

    return str
