require_relative 'piece'

class Pawn < Piece
    def symbol
        "\u2659".colorize(@color)
    end
end