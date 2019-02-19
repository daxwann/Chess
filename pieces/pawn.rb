require_relative 'piece'

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
        x, y = self.pos
        one_step = [x, y + forward_dir]
        return moves unless board.valid_pos?(one_step) && board.empty?(one_step)

        moves << one_step
        two_step = [x, y + 2 * forward_dir]
        moves << two_step if at_start_row? && board.empty(two_step)
    end
end