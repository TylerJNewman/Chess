require 'byebug'
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
      p char
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
    
    end

  end

end

class Player

  def get_move
    move = $stdin.getch

  end
end

g = Game.new
g.play
