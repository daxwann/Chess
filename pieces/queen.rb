require_relative 'piece'
require_relative 'slideable'

class Queen < Piece
    include Slideable
    
    def symbol
        "\u265B".colorize(@color)
    end

    def moves
        Slideable.moves
    end

    protected

    def Slideable.move_dirs
        Slideable.horizontal_vertical_dirs + Slideable.diagonal_dirs
    end
end