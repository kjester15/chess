require_relative 'chess_piece'

class Board
  attr_accessor :board_array

  def initialize(board_array = Array.new(8) { Array.new(8) { ' ' } })
    @board_array = board_array
  end

  def populate_board
    [0, 1, 6, 7].each do |row|
      (0..7).each do |column|
        determine_piece(row, column)
      end
    end
  end

  def create_piece(row, column, type, color)
    board_array[row][column] = Piece.new(type, color, [row, column])
  end

  def determine_piece(row, column)
    if [0, 7].include?(row)
      color = row.zero? ? 'black' : 'white'
      case column
      when 0, 7
        type = 'rook'
      when 1, 6
        type = 'knight'
      when 2, 5
        type = 'bishop'
      when 3
        type = 'queen'
      when 4
        type = 'king'
      end
    else
      color = row == 1 ? 'black' : 'white'
      type = 'pawn'
    end
    create_piece(row, column, type, color)
  end

  def print_board
    8.times do |row|
      puts '   - - - - - - - - - - - - - - - -'
      print "#{8 - row} | "
      8.times do |column|
        print_tile(row, column)
      end
      puts
    end
    puts '   - - - - - - - - - - - - - - - -'
    puts '    a   b   c   d   e   f   g   h'
  end

  def print_tile(row, column)
    if board_array[row][column] == ' '
      print "#{board_array[row][column]} | "
    else
      print "#{board_array[row][column].symbol} | "
    end
  end

  def tile_occupied?(coordinate)
    row = coordinate[0]
    column = coordinate[1]
    return unless @board_array[row][column] != ' '

    true
  end

  def change_tile(move_to, piece)
    board_array[move_to[0]][move_to[1]] = board_array[piece[0]][piece[1]]
  end

  def update_coordinate(move_to)
    board_array[move_to[0]][move_to[1]].coordinate = move_to
  end

  def clear_tile(piece)
    board_array[piece[0]][piece[1]] = ' '
  end
end
