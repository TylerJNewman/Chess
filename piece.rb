class Piece

  attr_reader :colour, :pos, :board

  def initialize(pos, colour, board)
    @board = board
    @pos = pos
    @colour = colour
  end


end

module Slideable

  HORIZ_DIRS = [[1,0], [-1,0], [0,1], [0,-1]]
  DIAG_DIRS = [[1,1], [-1,1],[-1,-1],[1,-1]]

  def direction_moves(&blc)
    dirs = move_dirs
    possible_moves = []

    # iterate through move_dirs, and grow your possible moves
    dirs.each do |dir|
      # debugger
      new_pos = pos.each_with_index.map { |x, i| x + dir[i] }
      while board.on_board?(new_pos)
        if board[*new_pos].class == EmptySpace
          possible_moves << new_pos
        elsif board[*new_pos].colour != self.colour
          possible_moves << new_pos
          break
        else
          break
        end
        new_pos = new_pos.each_with_index.map { |x, i| x + dir[i] }
      end
    end

    possible_moves
  end
end


class Pawn < Piece
  def to_s
    "P "
  end
end

class Rook < Piece
include Slideable

  def move_dirs
    HORIZ_DIRS
  end

  def to_s
    "R ".colorize(colour)
  end
end

class Bishop < Piece
include Slideable

  def move_dirs
    DIAG_DIRS
  end

  def to_s
    "B "
  end
end

class Queen < Piece
include Slideable

  def move_dirs
    HORIZ_DIRS + DIAG_DIRS
  end

  def to_s
    "Q ".colorize(colour)
  end
end

class King < Piece
  def to_s
    "K "
  end
end

class Knight < Piece
  def to_s
    "Kn"
  end
end
