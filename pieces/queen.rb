require_relative 'piece'
require_relative 'slideable'

class Queen < Piece
    include Slideable
    
    def symbol
        "\u265B".colorize(@color)
    end

    # protected

    def move_dirs
        horizontal_vertical_dirs + diagonal_dirs
    end
end