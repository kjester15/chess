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

  def in_bounds?(position)
    if position[0].between?(0, 7)
      if position[1].between?(0, 7)
        true
      end
    end
  end

  def king_moves(current_position)
    possible_moves = []
    row = current_position[0]
    column = current_position[1]
    move_directions = [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]].freeze
    move_directions.each do |coordinate|
      if in_bounds?(coordinate)
        row += coordinate[0]
        column += coordinate[1]
        @possible_moves << [row, column]
      end
    end
  end

  def queen_moves(current_position)
    # current_position = [row, column]
    # x = any amount of spaces until a space is occupied
    # possible moves = [ [row + x, column], [row + x, column + x], [row, column + x], [row - x, column + x]
    #                    [row - x, column], [row - x, column - x], [row, column - x], [row + 1, column - x] ]
  end

  def rook_moves(current_position)
    # current_position = [row, column]
    # x = any amount of spaces until a space is occupied
    # possible moves = [ [row + x, column], [row, column + x], [row - x, column], [row, column - x] ]
  end

  def bishop_moves(current_position)
    # current_position = [row, column]
    # x = any amount of spaces until a space is occupied
    # possible moves = [ [row + x, column + x], [row - x, column + x], [row - x, column - x], [row + 1, column - x] ]
  end

  def knight_moves(current_position)
    # current_position = [row, column]
    # possible moves = [ [row - 2, column + 1], [row - 1, column + 2], [row + 1, column + 2], [row + 2, column + 1]
    #                    [row + 2, column - 1], [row + 1, column - 2], [row - 1, column - 2], [row - 2, column - 1] ]
  end

  def pawn_moves(current_position)
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