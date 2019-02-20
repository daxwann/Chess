module Slideable
    HORIZONTAL_VERTICAL_DIRS = [
        [-1, 0],
        [0, -1],
        [0, 1],
        [1, 0]
    ].freeze

    DIAGONAL_DIRS = [
        [-1, -1],
        [-1, 1],
        [1, -1],
        [1, 1]
    ].freeze

    def Slideable.horizontal_vertical_dirs
        HORIZONTAL_VERTICAL_DIRS
    end

    def Slideable.diagonal_dirs
        DIAGONAL_DIRS
    end

    def Slideable.moves
        moves = []

        move_dirs.each do |dx, dy|
            moves.concat(find_unblocked_moves_in_dir(dx, dy))
        end
        moves
    end

    private

    def move_dirs
        # subclass implements this
        raise NotImplementedError
    end

    def find_unblocked_moves_in_dir(dx, dy)
        curr_x, curr_y = self.pos
        moves = []

        loop do
            curr_x += dx
            curr_y += dy
            new_pos = [curr_x, curr_y]

            break unless board.valid_pos?(new_pos)

            if board.empty?(pos)
                moves << pos
            else
                # can take an opponent's piece
                moves << pos if board[pos].color != self.color

                # can't move past blocking piece
                break
            end
        end
        moves
    end
end