require_relative 'board'
require_relative 'display'

class Game
  attr_reader :board, :display

  def initialize()
    @board = Board.new
    @display = Display.new(@board) 
  end

  def play
    while true
        @display.render
        @display.cursor.get_input
    end  
  end
end