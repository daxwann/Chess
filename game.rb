require_relative 'board'
require_relative 'human_player'

class Game
  attr_reader :board, :display, :current_player, :players

  def initialize()
    @board = Board.new
    @display = Display.new(@board)
    @players = {
      white: HumanPlayer.new(:white, @display),
      black: HumanPlayer.new(:black, @display)
    }
    @current_player = :white
  end

  def play
    until self.board.checkmate?(self.current_player)
      begin
        start_pos, end_pos = self.players[self.current_player].make_move(board)
        self.board.move_piece(self.current_player, start_pos, end_pos)

        swap_turn
        notify_players
      rescue StandardError => e
        @display.notifications[:error] = e.message
        retry
      end
    end

    self.display.render
    puts "#{self.current_player} is checkmated."

    nil
  end

  private

  def notify_players
    if self.board.in_check?(self.current_player)
      self.display.in_check
    else
      self.display.uncheck
    end
  end

  def swap_turn
    @current_player = self.current_player == :white? :black : :white
  end

end