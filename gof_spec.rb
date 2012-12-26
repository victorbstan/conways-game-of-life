# gof_spec.rb

require "rspec"
require_relative "gof"

describe "board" do
  before(:each) do
    @board = Board.new({:rows => 0, :cols => 0})
    @board2x4 = Board.new({:rows => 4, :cols => 2})
    @board5x5 = Board.new({:rows => 5, :cols => 5})
  end

  it "should have 2 rows and 3 columns" do
    board = Board.new({cols: 3, rows: 2})
    board.rows.should eq 2
    board.cols.should eq 3
  end

  it "should have a grid of type Array" do
    @board.grid.should be_an_instance_of Array
  end

  it "should be able to count rows and cols" do
    board = Board.new({cols:5, rows:6})
    board.grid.count.should eq 6 # rows
    board.grid.each { |rows| rows.count.should eq 5  } # cols (in each row)
  end

  it "should have smallest (1x1) grid initialized with value 0" do
    board = Board.new({rows:1, cols:1})
    board.grid_values.should eq 0
  end

  it "should be able to get values for specified row and column" do
    @board2x4.get({row:0, col:0}).should eq 0
    @board2x4.get({row:1, col:1}).should eq 0
  end

  it "should be able to set grid values for a certain row and column" do
    @board2x4.set({row:1, col:1, val:1})

    # other rows should be empty
    @board2x4.get({row:0, col:0}).should eq 0
    @board2x4.get({row:0, col:1}).should eq 0
    @board2x4.get({row:1, col:0}).should eq 0
    @board2x4.get({row:1, col:1}).should eq 1 # the set row
    @board2x4.get({row:2, col:0}).should eq 0
    @board2x4.get({row:2, col:1}).should eq 0
    @board2x4.get({row:3, col:0}).should eq 0
    @board2x4.get({row:3, col:1}).should eq 0
  end

  it "should output a board" do
    @board2x4.output.should eq <<-DOC.gsub(/^ {6}/, '')
      00
      00
      00
      00
    DOC
    # puts @board2x4.output
  end

  it "should output board with set value" do
    @board2x4.set({row:3, col:1, val:1})
    @board2x4.output.should eq <<-DOC.gsub(/^ {6}/, '')
      00
      00
      00
      01
    DOC

    # next set value, should include the first one
    @board2x4.set({row:1, col:0, val:1})
    @board2x4.output.should eq <<-DOC.gsub(/^ {6}/, '')
      00
      10
      00
      01
    DOC
  end

  it "seed board with initial values set through array of hashes" do
    entities = [
      {row:1, col:1, val:1},
      {row:0, col:0, val:1},
      {row:3, col:1, val:1}
    ]
    @board2x4.seed(entities)
    @board2x4.output.should eq <<-DOC.gsub(/^ {6}/, '')
      10
      01
      00
      01
    DOC
  end

  it "should be able to get neighbour cells' values" do
    @board5x5.output.should eq <<-DOC.gsub(/^ {6}/, '')
      00000
      00000
      00000
      00000
      00000
    DOC

    entities = [
      {row:3, col:3, val:1},
      {row:4, col:2, val:1}
    ]
    @board5x5.seed(entities)
    @board5x5.output.should eq <<-DOC.gsub(/^ {6}/, '')
      00000
      00000
      00000
      00010
      00100
    DOC

    # expected neighbours map
    # 000
    # 000 <- the actual item is reported as 0, for counting purposes (target item is dead centre, no pun intended)
    # 100
    @board5x5.output(@board5x5.neighbours({row:3, col:3})).should eq <<-DOC.gsub(/^ {6}/, '')
      000
      000
      100
    DOC
  end

  # .count { |i| i != 0 }
  it "should be able to count neighbours" do
    # count no neightbours
    @board5x5.count_neighbours(@board5x5.neighbours({row:3, col:3})).should eq 0

    # count one neighbour
    entities = [
      {row:3, col:3, val:1},
      {row:4, col:2, val:1}
    ]
    @board5x5.seed(entities)
    @board5x5.count_neighbours(@board5x5.neighbours({row:3, col:3})).should eq 1
  end
end
