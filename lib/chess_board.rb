class Board
  attr_accessor :board_array

  def initialize(board_array = Array.new(8) { Array.new(8) { ' ' } })
    @board_array = board_array
  end

  def print_board
    @board_array.each_with_index do |row, index|
      puts '   - - - - - - - - - - - - - - - -'
      print "#{7 - (index - 1)} | "
      row.each do |column|
        print "#{column} | "
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
end
