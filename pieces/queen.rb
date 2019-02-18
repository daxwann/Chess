require_relative 'piece'

class Queen < Piece
    def symbol
        "\u265B".colorize(@color)
    end
end