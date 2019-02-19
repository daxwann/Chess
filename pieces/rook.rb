require_relative 'piece'

class Rook < Piece
    def symbol
        "\u265C".colorize(@color)
    end

    protected

    def move_dirs
        horizontal_vertical_dirs
    end
end