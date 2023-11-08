class Piece
  attr_accessor :pieces

  def initialize
    @pieces = { king_w: '♔', queen_w: '♕', rook_w: '♖', bishop_w: '♗', knight_w: '♘', pawn_w: '♙', king_b: '♚',
                queen_b: '♛', rook_b: '♜', bishop_b: '♝', knight_b: '♞', pawn_b: '♟︎' }
  end
end