require 'byebug'
require_relative 'piece'
require_relative 'board'

class Game
  attr_reader :board, :player1
  attr_accessor :quit_var

  def initialize
    @board = Board.new
    @player1 = Player.new
    @quit_var = false
  end

  def play
    until over?
      render_board
      char = player1.get_move
      cursor_move(char)
    end
  end

  def render_board
    system("clear")
    board.render
  end

  def over?
    quit_var
  end

  def cursor_move(char)
    case char
    when "q"
      self.quit_var = true
    when "a"
      board.move_cursor(:left)
    when "s"
      board.move_cursor(:down)
    when "d"
      board.move_cursor(:right)
    when "w"
      board.move_cursor(:up)
    end

  end

end

class Player

  def get_move
    move = $stdin.getch

  end
end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end
