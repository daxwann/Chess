require_relative 'pieces'

class Board
  attr_reader :rows

  def initialize(fill_board = true)
    make_starting_grid(fill_board)
  end

  def [](pos)
    raise ArgumentError unless valid_pos?(pos)
    x, y = pos
    @rows[y][x]
  end

  def []=(pos, piece)
    raise ArgumentError unless valid_pos?(pos)
    x, y = pos
    @rows[y][x] = piece
  end

  def valid_pos?(pos)
    pos.all? { |coord| coord.between?(0, 7)}
  end

  def add_piece(piece, pos)
    self[pos] = piece
  end

  private

  def fill_back_row(color)
    back_pieces = [
      Rook, Knight, Bishop, Queen, King, Bishop,
      Knight, Rook
    ]

    row = color == :white ? 7 : 0
    back_pieces.each_with_index do |type, col|
      type.new(color, self, [col, row])
    end
  end

  def fill_pawns_row(color)
    row = color == :white ? 6 : 1
    8.times {|col| Pawn.new(color, self, [col, row])}
  end

  def make_starting_grid(fill_board)
    @rows = Array.new(8) { Array.new(8, nil)}
    return unless fill_board
    %i(white black).each do |color|
      fill_back_row(color)
      fill_pawns_row(color)
    end
  end
end