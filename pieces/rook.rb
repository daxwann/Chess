require_relative 'piece'

class Rook < Piece
    def symbol
        "\u265C".colorize(@color)
    end
end