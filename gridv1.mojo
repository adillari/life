import random

@fieldwise_init
struct Grid(Copyable, Movable, Stringable):
  var data: List[List[Int]]

  @staticmethod
  fn random(x: Int, y: Int) -> Self:
    random.seed()
    var data: List[List[Int]] = []
    for _ in range(x):
      data.append([])
      for _ in range(y):
        data[-1].append(Int(random.random_si64(0, 1)))
    return Self(data)

  fn __getitem__(self, x: Int, y: Int) -> Int:
    return self.data[x][y]

  fn __setitem__(mut self, x: Int, y: Int, value: Int):
    self.data[x][y] = value

  fn __str__(self) -> String:
    row_num = 0
    str = ""
    for list in self.data:
      for item in list:
        if item == 1:
          str += "* "
        else:
          str += "  "
      if row_num < len(self.data)-1:
        str += "\n"
      row_num += 1
    return str
