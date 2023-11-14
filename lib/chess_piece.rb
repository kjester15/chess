class Piece
  attr_accessor :type, :color, :symbol, :coordinate, :possible_moves

  def initialize(type, color, coordinate)
    @pieces = { king_white: '♔', queen_white: '♕', rook_white: '♖', bishop_white: '♗', knight_white: '♘',
                pawn_white: '♙', king_black: '♚', queen_black: '♛', rook_black: '♜', bishop_black: '♝',
                knight_black: '♞', pawn_black: '♟︎' }
    @type = type
    @color = color
    @symbol = @pieces[:"#{type}_#{color}"]
    @coordinate = coordinate
  end
end