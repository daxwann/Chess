require_relative 'piece'
require_relative 'slideable'

class Bishop < Piece
    include Slideable

    def symbol
        "\u265D".colorize(@color)
    end

    protected

    def moves
        Slideable.moves
    end

    def Slideable.move_dirs
        Slideable.diagonal_dirs
    end
end