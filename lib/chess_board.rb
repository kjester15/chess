require_relative 'chess_piece'

class Board
  attr_accessor :board_array

  def initialize(board_array = Array.new(8) { Array.new(8) { ' ' } })
    @board_array = board_array
  end

  def populate_board
    [0, 1, 6, 7].each do |row|
      (0..7).each do |column|
        create_piece(row, column)
      end
    end
  end

  def create_piece(row, column)
    if [0, 7].include?(row)
      color = row.zero? ? 'white' : 'black'
      case column
      when 0, 7
        board_array[row][column] = Piece.new('rook', color, [row, column])
      when 1, 6
        board_array[row][column] = Piece.new('knight', color, [row, column])
      when 2, 5
        board_array[row][column] = Piece.new('bishop', color, [row, column])
      when 3
        board_array[row][column] = Piece.new('queen', color, [row, column])
      when 4
        board_array[row][column] = Piece.new('king', color, [row, column])
      end
    elsif row == 1
      board_array[row][column] = Piece.new('pawn', 'white', [row, column])
    elsif row == 6
      board_array[row][column] = Piece.new('pawn', 'black', [row, column])
    end
  end

  def print_board
    8.times do |row|
      puts '   - - - - - - - - - - - - - - - -'
      print "#{8 - row} | "
      8.times do |column|
        if board_array[row][column] == ' '
          print "#{board_array[row][column]} | "
        else
          print "#{board_array[row][column].symbol} | "
        end
      end
      puts
    end
    puts '   - - - - - - - - - - - - - - - -'
    puts '    a   b   c   d   e   f   g   h'
  end

  def translate_move(selection)
    row_array = %w[8 7 6 5 4 3 2 1]
    col_array = %w[a b c d e f g h]
    row = row_array.index(selection[1])
    column = col_array.index(selection[0])
    [row, column]
  end

  # def move_piece(start_coordinate, end_coordinate)
  # end
end
