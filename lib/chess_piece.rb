class Piece
  attr_accessor :type, :symbol, :coordinate

  def initialize(type, color, coordinate)
    @pieces = { king_white: '♔', queen_white: '♕', rook_white: '♖', bishop_white: '♗', knight_white: '♘',
                pawn_white: '♙', king_black: '♚', queen_black: '♛', rook_black: '♜', bishop_black: '♝',
                knight_black: '♞', pawn_black: '♟︎' }
    @type = type
    @color = color
    @symbol = @pieces[:"#{type}_#{color}"]
    @coordinate = coordinate
    @possible_moves = []
  end

  def king_moves(current_position)
    # add all moves to @possible_moves
  end

  def queen_moves(current_position)
    # add all moves to @possible_moves
  end

  def rook_moves(current_position)
    # add all moves to @possible_moves
  end

  def bishop_moves(current_position)
    # add all moves to @possible_moves
  end

  def knight_moves(current_position)
    # add all moves to @possible_moves
  end

  def pawn_moves(current_position)
    # add all moves to @possible_moves
  end
end