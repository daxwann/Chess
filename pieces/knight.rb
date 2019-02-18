require_relative 'piece'

class Knight < Piece
    def symbol
        "\u2658".colorize(@color)
    end
end