require_relative 'piece'

class Bishop < Piece
    def symbol
        "\u265D".colorize(@color)
    end
end