require_relative 'piece'

class King < Piece
include Steppable

  def move_steps
    KING_STEPS
  end

  def to_s
    "♚ ".colorize(colour)
  end
end
