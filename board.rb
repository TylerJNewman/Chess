require 'colorize'
require 'io/console'

class Board
  attr_accessor :grid, :cursor_pos

  def initialize
    @grid = Array.new(8) { Array.new(8) { EmptySpace.new } }
    @cursor_pos = 0,0
  end

  def render
    print " "
    (0..7).each { |col_index| print col_index}
    puts
    (0..7).each do |row|
      print row
      (0..7).each do |col|
        case
        when @cursor_pos == [row, col]
          print self[row,col].render.on_red
        when (row + col).even?
          print self[row,col].render.on_light_white
        when (row + col).odd?
          print self[row,col].render.on_black
        end
      end
      puts
    end
  end

  def [](*pos)
    row,col = pos
    grid[row][col]
  end

  def []=(*pos,value)
    row,col = pos
    grid[row][col] = value
  end

end

class EmptySpace
  def render
    "  "
  end
end
