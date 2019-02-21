require_relative 'piece'
require_relative 'stepable'

class Knight < Piece
    include Stepable
    
    def symbol
        "\u2658".colorize(@color)
    end

    def moves
        Stepable.moves
    end

    protected

    def Stepable.move_diffs
        [
            [-2, -1],
            [-1, -2],
            [-2, 1],
            [-1, 2],
            [1, -2],
            [2, -1],
            [1, 2],
            [2, 1]
        ]
    end
end