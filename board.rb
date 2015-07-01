require 'colorize'
require 'io/console'

class Board
  attr_accessor :grid, :cursor_pos, :helper

  CURSOR_MOVES = {
      :left => [0, -1],
      :right => [0, 1],
      :down => [1, 0],
      :up => [-1, 0]
  }

  def initialize
    @grid = Array.new(8) { Array.new(8) { EmptySpace.new } }
    @cursor_pos = 0,0
    @helper = true
    populate_board
  end

  def populate_board
    # (0..7).each do |row|
    #   (0..7).each do |col|
    #     self[row,col] = Rook.new([row,col], :white)
    #   end
    # end

    self[0,0] = Rook.new([0,0], :white, self)
    self[2,2] = Rook.new([2,2], :white, self)
    self[4,4] = Bishop.new([4,4], :black, self)
    self[3,4] = Queen.new([3,4], :black, self)

  end

  def render
    print " "
    (0..7).each { |col_index| print " #{col_index}"}
    puts
    (0..7).each do |row|
      print row
      (0..7).each do |col|
        pos = row, col
        object_on_tile = self[*pos]

        case
        when self[*cursor_pos].direction_moves.include?([*pos])
          print object_on_tile.to_s.on_light_cyan
        when @cursor_pos == [*pos]
          print object_on_tile.to_s.on_light_yellow
        when (row + col).even?
          print object_on_tile.to_s.on_light_white
        when (row + col).odd?
          print object_on_tile.to_s.on_light_black
        end
      end
      puts
    end

    puts debug_info
  end

  def [](*pos)
    row,col = pos
    grid[row][col]
  end

  def []=(*pos,value)
    row,col = pos
    grid[row][col] = value
  end

  def move_cursor(direction)
    dx, dy = CURSOR_MOVES[direction]
    x, y = cursor_pos

    @cursor_pos = dx + x, dy + y
  end
  #
  # def possible_moves_of(piece)
  #   potential_moves = piece.potential_moves
  #   potential_moves.select { |move| valid?(move)}
  # end

  def valid?(move)
    on_board?(move)
  end

  def on_board?(move)
    x, y = move
    x.between?(0,7) && y.between?(0,7)
  end
  #
  # def conflicts
  #   evaluated_piece = self[*cursor_pos]
  #   potential_moves = possible_moves_of(evaluated_piece)
  #   conflicts_array = []
  #
  #   potential_moves.each do |p_move|
  #     conflicts_array << p_move unless self[*p_move].class == EmptySpace
  #   end
  #
  #   conflicts_array
  # end

  def debug_info
    if self.helper
      piece = self[*cursor_pos]
      message = ''
      unless piece.class == EmptySpace
        # debugger
        message += "Class: #{piece.class} \n"
        message += "Colour: #{piece.colour} \n"
        message += "Pos : #{piece.pos} \n"
        message += "Possible moves: #{piece.direction_moves} \n"
        # message += "Conflicts: #{self.conflicts} \n"
      end
      message
    end
  end

end

class EmptySpace
  def to_s
    "  ".colorize(:white)
  end

  def direction_moves
    []
  end
end
