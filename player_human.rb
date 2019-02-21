require_relative 'display'
require_relative 'player'

class PlayerHuman < Player
  def make_move(board)
    start_pos, end_pos = nil, nil

    until start_pos && end_pos
      display.render
      puts "#{self.color}'s turn"
      unless start_pos
        puts "Select piece."
        start_pos = display.cursor.get_input
        display.reset if start_pos
      else
        puts "Move to where?"
        end_pos = display.cursor.get_input
        display.reset if end_pos
      end
    end
    [start_pos, end_pos]
  end
end