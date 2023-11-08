class Piece
  attr_accessor :pieces

  def initialize
    @pieces = { king_w: '♔', queen_w: '♕', rook_w: '♖', bishop_w: '♗', knight_w: '♘', pawn_w: '♙', king_b: '♚',
                queen_b: '♛', rook_b: '♜', bishop_b: '♝', knight_b: '♞', pawn_b: '♟︎' }
  end

  def king_moves
    # 
  end

  def queen_moves
    # 
  end

  def rook_moves
    # 
  end

  def bishop_moves
    # 
  end

  def knight_moves
    # 
  end

  def pawn_moves
    # 
  end
end