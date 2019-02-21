module Stepable
    def Stepable.moves
        move_diffs.each_with_object([]) do |(dx, dy), moves|
            curr_x, curr_y = self.pos
            new_pos = [curr_x + dx, curr_y + dy]

            next unless board.valid_pos?(pos)

            if board.empty?(pos)
                moves << pos
            elsif board[pos].color != color
                moves << pos
            end
        end
    end

    private

    def Stepable.move_diffs
        # subclass implements this
        raise NotImplementedError
    end
end