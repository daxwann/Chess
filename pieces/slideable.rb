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

    def horizontal_vertical_dirs
        HORIZONTAL_VERTICAL_DIRS
    end

    def diagonal_dirs
        DIAGONAL_DIRS
    end

    def moves
        moves = []

        move_dirs.each do |dx, dy|
            moves.concat(find_unblocked_moves(dx, dy))
        end
        moves
    end

    # private

    def move_dirs
        # subclass implements this
        raise NotImplementedError
    end

    def find_unblocked_moves(dx, dy)
        curr_x, curr_y = pos
        moves = []

        loop do
            curr_x += dx
            curr_y += dy
            new_pos = [curr_x, curr_y]

            break unless board.valid_pos?(new_pos)

            if board.empty?(new_pos)
                moves << new_pos
            else
                # can take an opponent's piece
                moves << new_pos if board[new_pos].color != color

                # can't move past blocking piece
                break
            end
        end
        moves
    end
end