class Piece
  attr_accessor :type, :color, :symbol, :coordinate, :en_passant, :en_passant_count, :has_moved

  def initialize(type, color, coordinate, en_passant = false, en_passant_count = '')
    @pieces = { king_black: '♔', queen_black: '♕', rook_black: '♖', bishop_black: '♗', knight_black: '♘',
                pawn_black: '♙', king_white: '♚', queen_white: '♛', rook_white: '♜', bishop_white: '♝',
                knight_white: '♞', pawn_white: '♟︎' }
    @type = type
    @color = color
    @en_passant = en_passant
    @en_passant_count = en_passant_count
    @symbol = @pieces[:"#{type}_#{color}"]
    @coordinate = coordinate
    @has_moved = false
  end

  def pawn_move_directions(position, color, capture, enpassant)
    move_adjust = 1
    if color == 'white'
      move_adjust *= -1
    end

    move_directions = [[1 * move_adjust, 0]]
    if capture
      [[1 * move_adjust, 1], [1 * move_adjust, -1]].each do |capture_direction|
        move_directions << capture_direction
      end
    end

    if enpassant[1]
      direction = enpassant[0]
      if direction == 'right'
        move_directions << [1 * move_adjust, 1]
      elsif direction == 'left'
        move_directions << [1 * move_adjust, -1]
      end
    end

    first_move_directions = [2 * move_adjust, 0]
    if color == 'white' && position[0] == 6
      move_directions << first_move_directions
    elsif color == 'black' && position[0] == 1
      move_directions << first_move_directions
    end
    move_directions
  end

  def pawn_moves(position, color, capture, enpassant)
    possible_moves = []
    move_directions = pawn_move_directions(position, color, capture, enpassant)
    move_directions.each do |direction|
      new_tile = [position[0] + (direction[0]), position[1] + direction[1]]
      in_bounds?(new_tile) ? possible_moves << new_tile : next
    end
    possible_moves
  end

  def king_knight_moves(position, move_directions)
    possible_moves = []
    move_directions.each do |direction|
      new_tile = [position[0] + direction[0], position[1] + direction[1]]
      in_bounds?(new_tile) ? possible_moves << new_tile : next
    end
    possible_moves
  end

  def queen_rook_bishop_moves(position, move_directions)
    possible_moves = []
    move_directions.each do |direction|
      7.times do |y|
        if direction.include?('x') && direction.include?('-x')
          updated_direction = direction.map { |num| num == 'x' ? (y + 1) : num }
          updated_direction = updated_direction.map { |num| num == '-x' ? -(y + 1) : num }
        elsif direction.include?('x')
          updated_direction = direction.map { |num| num == 'x' ? (y + 1) : num }
        elsif direction.include?('-x')
          updated_direction = direction.map { |num| num == '-x' ? -(y + 1) : num }
        end
        new_tile = [position[0] + updated_direction[0], position[1] + updated_direction[1]]
        in_bounds?(new_tile) ? possible_moves << new_tile : next
      end
    end
    possible_moves
  end

  def piece_moves(piece, position)
    possible_moves = []
    case piece
    when 'K'
      move_directions = [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]].freeze
      possible_moves = king_knight_moves(position, move_directions)
    when 'N'
      move_directions = [[-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1]].freeze
      possible_moves = king_knight_moves(position, move_directions)
    when 'Q'
      move_directions = [['x', 0], ['x', 'x'], [0, 'x'], ['-x', 'x'], ['-x', 0], ['-x', '-x'], [0, '-x'], ['x', '-x']].freeze
      possible_moves = queen_rook_bishop_moves(position, move_directions)
    when 'R'
      move_directions = [['x', 0], [0, 'x'], ['-x', 0], [0, '-x']].freeze
      possible_moves = queen_rook_bishop_moves(position, move_directions)
    when 'B'
      move_directions = [['x', 'x'], ['-x', 'x'], ['-x', '-x'], ['x', '-x']].freeze
      possible_moves = queen_rook_bishop_moves(position, move_directions)
    end
    possible_moves
  end

  def in_bounds?(position)
    if position[0].between?(0, 7)
      if position[1].between?(0, 7)
        true
      end
    end
  end

  def update_enpassant(value)
    @en_passant = value
  end

  def update_enpassant_count(value)
    @en_passant_count = value
  end

  def decrease_enpassant_count(value)
    @en_passant_count -= value
  end

  def update_has_moved
    @has_moved = true
  end
end