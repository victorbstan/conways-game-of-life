# gof.rb

# The universe of the Game of Life is an infinite two-dimensional orthogonal grid of square cells,
# each of which is in one of two possible states, alive or dead. Every cell interacts with its eight neighbours,
# which are the cells that are horizontally, vertically, or diagonally adjacent. At each step in time,
# the following transitions occur:

# Any live cell with fewer than two live neighbours dies, as if caused by under-population.
# Any live cell with two or three live neighbours lives on to the next generation.
# Any live cell with more than three live neighbours dies, as if by overcrowding.
# Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

class Board
  attr_reader :rows, :cols, :grid
  def initialize params
    @rows = params[:rows]
    @cols = params[:cols]

    # build row count first then colums
    @grid = Array.new(rows) { Array.new(cols) { 0 } }
  end

  def grid_values
    grid.flatten.join('').to_i
  end

  def get(params)
    col = params[:col]
    row = params[:row]
    grid[row][col]
  end

  def set(params)
    col = params[:col]
    row = params[:row]
    val = params[:val]
    # puts grid.to_s
    grid[row][col] = val
  end

  def output(matrix=nil)
    martrix = matrix || grid
    out = ''
    martrix.each { |row|
      # joining column values for each row
      out << row.join('') + "\n"
    }
    out.to_s
  end

  # params should be an array of objects that can be "set"
  # params = [
  #   {row:3, col:3, val:1},
  #   {row:4, col:2, val:1}
  # ]
  def seed(params)
    params.each { |param|
      set(param)
    }
  end

  # provide a location on the grid
  def neighbours(params)
    col = params[:col]
    row = params[:row]

    # above, left
    n1 = get({row: row-1, col: col-1})
    # above
    n2 = get({row: row-1, col: col})
    # above, right
    n3 = get({row: row-1, col: col+1})

    # left
    n4 = get({row: row, col: col-1})

    # right
    n5 = get({row: row, col: col+1})

    # below, left
    n6 = get({row: row+1, col: col-1})
    # below
    n7 = get({row: row+1, col: col})
    # below, right
    n8 = get({row: row+1, col: col+1})

    out = [
      [n1, n2, n3],
      [n4, 'x', n5],
      [n6, n7, n8]
    ]
  end
end
