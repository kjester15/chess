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
    # current_position = [row, column]
    # possible moves = [ [row + 1, column], [row + 1, column + 1], [row, column + 1], [row - 1, column + 1]
    #                    [row - 1, column], [row - 1, column - 1], [row, column - 1], [row + 1, column - 1] ]
    # for each in possible moves, if it's in bounds, add it to @possible_moves
  end

  def queen_moves(current_position)
    # add all moves to @possible_moves
    # current_position = [row, column]
    # x = any amount of spaces until a space is occupied
    # possible moves = [ [row + x, column], [row + x, column + x], [row, column + x], [row - x, column + x]
    #                    [row - x, column], [row - x, column - x], [row, column - x], [row + 1, column - x] ]
  end

  def rook_moves(current_position)
    # add all moves to @possible_moves
    # current_position = [row, column]
    # x = any amount of spaces until a space is occupied
    # possible moves = [ [row + x, column], [row, column + x], [row - x, column], [row, column - x] ]
  end

  def bishop_moves(current_position)
    # add all moves to @possible_moves
    # current_position = [row, column]
    # x = any amount of spaces until a space is occupied
    # possible moves = [ [row + x, column + x], [row - x, column + x], [row - x, column - x], [row + 1, column - x] ]
  end

  def knight_moves(current_position)
    # add all moves to @possible_moves
    # current_position = [row, column]
    # possible moves = [ [row - 2, column + 1], [row - 1, column + 2], [row + 1, column + 2], [row + 2, column + 1]
    #                    [row + 2, column - 1], [row + 1, column - 2], [row - 1, column - 2], [row - 2, column - 1] ]
  end

  def pawn_moves(current_position)
    # add all moves to @possible_moves
    # color = black or white
    # current_position = [row, column]
    # possible moves (black) = [ [row + 1, column],
    #                            if caputuring: [row + 1, column + 1], [row + 1, column - 1]
    #                            if first move: [row + 2, column] ]
    # possible moves (white) = [ [row - 1, column],
    #                            if caputuring: [row - 1, column + 1], [row - 1, column - 1]
    #                            if first move: [row - 2, column] ]
  end
end