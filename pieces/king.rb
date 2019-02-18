require_relative 'piece'

class King < Piece
    def symbol
        "\u2654".colorize(@color)
    end
end