require 'byebug'
require_relative 'piece'
require_relative 'knight'
require_relative 'rook'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'pawn'


require_relative 'board'

class Game
  attr_reader :board, :player1
  attr_accessor :quit_var, :moved, :current_player

  def initialize
    @board = Board.new
    @player1 = Player.new("Player 1", :white) 
    @player2 = Player.new("Player 2", :black)
    @current_player = @player1
    @quit_var = false
    @move_completed = false
  end

  def play
    piece = nil
    until over? || force_quit?
      until moved? || force_quit?
        render_board
        char = current_player.get_move
        handle_char(char)
      end
      change_current_player
    end
  end

  def render_board
    system("clear")
    board.render
    puts current_player.name
  end

  def change_current_player
    current_player == @player1 ? self.current_player = @player2 : self.current_player = @player1
    @move_completed = false
  end

  def force_quit?
    quit_var
  end

  def over?
    false
  end

  def moved?
    @move_completed
  end

  def handle_char(char)
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
    when "\r"
      # debugger
      if board.selected_piece.nil?
        board.select_piece(current_player.colour)
      else
        if board.selected_piece.move_to(board.cursor_pos)

          @move_completed = true
          board.selected_piece.move_to!(board.cursor_pos)
        end
        board.selected_piece = nil
      end
    end

  end


end

class Player
  attr_reader :name, :colour

  def initialize(name, colour)
    @name = name
    @colour = colour
  end

  def get_move
    move = $stdin.getch
  end

end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end
