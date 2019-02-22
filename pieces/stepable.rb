require "byebug"

module Stepable
    def moves
        move_diffs.each_with_object([]) do |diff, moves|
            dx, dy = diff
            curr_x, curr_y = pos
            new_pos = [curr_x + dx, curr_y + dy]

            next unless board.valid_pos?(new_pos)

            if board.empty?(new_pos)
                moves << new_pos
            elsif board[new_pos].color != color
                moves << new_pos
            end
        end
    end

    # private

    def move_diffs
        # subclass implements this
        raise NotImplementedError
    end
end