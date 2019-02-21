require_relative 'pieces'

class Board
  attr_reader :rows

  def initialize(fill_board = true)
    @sentinel = NullPiece.instance
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

  def move_piece(turn_color, start_pos, end_pos)
    piece = self[start_pos]
    if piece.empty?
      raise 'start position is empty'
    elsif piece.color != turn_color
      raise 'You must move your own piece'
    elsif !piece.moves.include?(end_pos)
      raise 'Piece does not move like that'
    elsif !piece.valid_moves.include?(end_pos)
      raise 'You cannot move into check'
    end

    move_piece!(start_pos, end_pos)
  end

  def dup
    new_board = Board.new(false)

    pieces.each do |piece|
      piece.class.new(piece.color, new_board, piece.pos)
    end
    new_board
  end

  def empty?(pos)
    self[pos].empty?
  end

  def move_piece!(start_pos, end_pos)
    piece = self[start_pos]
    raise 'Piece does not move like that' unless piece.moves.include?(end_pos)
    self[end_pos] = piece
    self[start_pos] = @sentinel
    piece.pos = end_pos
    nil
  end

  def in_check?(color)
    king_pos = find_king(color).pos
    pieces.any?
  end

  def pieces
    @rows.flatten.reject(&:empty?)
  end

  private

  attr_reader: sentinel

  def fill_back_row(color)
    back_pieces = [
      Rook, Knight, Bishop, Queen, King, Bishop,
      Knight, Rook
    ]

    row = color == :light_black ? 7 : 0
    back_pieces.each_with_index do |type, col|
      type.new(color, self, [col, row])
    end
  end

  def fill_pawns_row(color)
    row = color == :light_black ? 6 : 1
    8.times {|col| Pawn.new(color, self, [col, row])}
  end

  def make_starting_grid(fill_board)
    @rows = Array.new(8) { Array.new(8, @sentinel)}
    return unless fill_board
    %i(light_black black).each do |color|
      fill_back_row(color)
      fill_pawns_row(color)
    end
  end

  def find_king(color)
    king_pos = pieces.find {|p| p.color == color && p.is_a?(King)}
    king_pos || (raise 'King not found')
  end
end