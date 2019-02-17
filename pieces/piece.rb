class Piece
  def initialize(color, board, pos)
    raise ArgumentError unless %i(white black).include?(color)
    raise ArgumentError unless board.valid_pos?(pos)
    @color, @board, @pos = color, board, pos
    board.add_piece(self, pos)
  end

  def inspect
    "piece"
  end
end