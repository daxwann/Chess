require_relative 'piece'
require "byebug"

class Pawn < Piece
    def symbol
        "\u2659".colorize(@color)
    end

    def moves
        forward_steps + side_attacks
    end

    private

    def at_start_row?
        pos[0] == (color == :white) ? 6 : 1
    end

    def forward_dir
        color == :white ? -1 : 1
    end

    def forward_steps
        moves = []
        x, y = pos
        one_step = [x, y + forward_dir]
        return moves unless board.valid_pos?(one_step) && board.empty?(one_step)

        moves << one_step
        two_step = [x, y + 2 * forward_dir]
        moves << two_step if at_start_row? && board.empty?(two_step)
        moves
    end

    def side_attacks
        x, y = pos
        side_moves = [[x - 1, y + forward_dir], [x + 1, y + forward_dir]]
        side_moves.select do |new_pos|
            next false unless board.valid_pos?(new_pos)
            next false if board.empty?(new_pos)
      
            threatened_piece = board[new_pos]
            threatened_piece && threatened_piece.color != color
        end
    end
end