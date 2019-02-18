require_relative "cursor"
require "colorize"

class Display
    attr_reader :board, :notifications, :cursor

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0, 0], board)
        @notifications = {}
    end

    def build_grid
        @board.rows.map.with_index do |row, y|
            build_row(row, y)
        end
    end

    def build_row(row, y)
        row.map.with_index do |piece, x|
            color_options = colors_for(x, y)
            piece.to_s.colorize(color_options)
        end
    end

    def colors_for(x, y)
        if cursor.cursor_pos == [x, y] && cursor.selected
            bg = :light_green
        elsif cursor.cursor_pos == [x, y]
            bg = :light_red
        elsif (x + y).odd?
            bg = :light_blue
        else
            bg = :yellow
        end
        { background: bg }
    end

    def render
        system("clear")
        puts "Arrow keys, WASD, or vim to move. Space or enter to confirm."
        build_grid.each {|row| puts row.join}
        nil
    end
end