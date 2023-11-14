require_relative 'chess_board'
require_relative 'chess_piece'

class Game
  attr_accessor :player1, :player2, :board, :current_player

  def initialize
    @player1 = { name: '', color: 'white' }
    @player2 = { name: '', color: 'black' }
    @board = Board.new
    @current_player = @player1
  end

  def greeting_setup
    puts 'Hello! Welcome to Chess. Let\'s play a game in the console.'
    puts 'What is player 1\'s name?'
    @player1[:name] = gets.chomp
    puts "#{player1[:name]} will be white."
    puts 'What is player 2\'s name?'
    @player2[:name] = gets.chomp
    puts "#{player2[:name]} will be black."
    puts "White goes first. #{@player1[:name]}, your turn!"
  end

  def player_input
    puts 'Please enter a move'
    gets.chomp
  end

  def create_two_dig_array
    file = %w[a b c d e f g h]
    rank = [1, 2, 3, 4, 5, 6, 7, 8]
    array = []
    file.each do |x|
      rank.each do |y|
        array << "#{x}#{y}"
      end
    end
    array
  end

  def create_three_dig_array
    piece_abrv = %w[K Q R B N]
    file = %w[a b c d e f g h]
    rank = [1, 2, 3, 4, 5, 6, 7, 8]
    array = []
    piece_abrv.each do |x|
      file.each do |y|
        rank.each do |z|
          array << "#{x}#{y}#{z}"
        end
      end
    end
    file.each do |x|
      file.each do |y|
        rank.each do |z|
          array << "#{x}#{y}#{z}"
        end
      end
    end
    rank.each do |x|
      file.each do |y|
        rank.each do |z|
          array << "#{x}#{y}#{z}"
        end
      end
    end
    array
  end

  def create_four_dig_array
    piece_abrv = %w[K Q R B N]
    file = %w[a b c d e f g h]
    rank = [1, 2, 3, 4, 5, 6, 7, 8]
    array = []
    piece_abrv.each do |x|
      file.each do |y|
        file.each do |z|
          rank.each do |a|
            array << "#{x}#{y}#{z}#{a}"
          end
        end
      end
      rank.each do |y|
        file.each do |z|
          rank.each do |a|
            array << "#{x}#{y}#{z}#{a}"
          end
        end
      end
    end
    array
  end

  def create_five_dig_array
    piece_abrv = %w[K Q R B N]
    file = %w[a b c d e f g h]
    rank = [1, 2, 3, 4, 5, 6, 7, 8]
    array = []
    piece_abrv.each do |x|
      file.each do |y|
        rank.each do |z|
          file.each do |a|
            rank.each do |b|
              array << "#{x}#{y}#{z}#{a}#{b}"
            end
          end
        end
      end
    end
    array
  end

  def validate_input(move)
    length = move.length
    if length < 2 || length > 5
      puts 'Please enter a valid move'
      return
    elsif length == 2
      array = create_two_dig_array
    elsif length == 3
      array = create_three_dig_array
    elsif length == 4
      array = create_four_dig_array
    elsif length == 5
      array = create_five_dig_array
    end

    if array.include?(move)
      true
    else
      puts 'That is not a valid move'
    end
  end

  def update_current_player
    if @current_player == @player1
      @current_player = @player2
    elsif @current_player == @player2
      @current_player = @player1
    end
  end

  def find_piece_locations(move)
    piece = move[0]
    file_rank = move[-2..]
    coordinate = translate_move(file_rank)
    if %w[K Q R B N].include?(piece)
      piece_moves(piece, coordinate)
    else
      pawn_moves(coordinate)
    end
  end

  # def find_piece(moves_array)
  # end

  def translate_move(selection)
    row_array = %w[8 7 6 5 4 3 2 1]
    col_array = %w[a b c d e f g h]
    row = row_array.index(selection[1])
    column = col_array.index(selection[0])
    [row, column]
  end

  def in_bounds?(position)
    if position[0].between?(0, 7)
      if position[1].between?(0, 7)
        true
      end
    end
  end

  def tile_occupied?(coordinate)
    # if tile is occupied, return true
  end

  def can_capture?
    # if piece is opposite color, return true
  end

  def player_turn
    move = player_input
    validated = validate_input(move)
    until validated
      move = player_input
      validated = validate_input(move)
    end
    p find_piece_locations(move)
    # Check for piece (CREATE NEW METHOD) - check if the noted piece is in any of the move locations in the previously created array
    # Move (and replace) piece (CREATE NEW METHOD)
    #   if the piece is found, move the piece to the new location (if the piece is not found, reprompt the entire process)
    #       if multiples pieces are found, reprompt user input with file, rank, or rank and file, until only one option remains
    #   if a piece is captured, replace it with the players piece (add an x to the player's entered move before the location (Kxg5))
    # Add move to log (CREATE NEW METHOD) - the player's move text to an array of moves that have been made
    update_current_player
  end

  def pawn_moves(current_position)
    color = @player_turn[:color]
    if color == 'black'
    # move_directions = [ [1, 0],
    #      if caputuring: [1, 1], [1, -1]
    #      if first move: [2, 0] ]
      puts 'pawn black'
    elsif color == 'white'
    # move_directions = [ [-1, 0],
    #      if caputuring: [-1, 1], [-1, -1]
    #      if first move: [-2, 0] ]
      puts 'pawn white'
    end
  end

  def piece_moves(piece, position)
    possible_tiles = []
    case piece
    when 'K'
      move_directions = [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]].freeze
    when 'Q'
      move_directions = [[x, 0], [x, x], [0, x], [-x, x], [-x, 0], [-x, -x], [0, -x], [x, -x]].freeze
    when 'R'
      move_directions = [[x, 0], [0, x], [-x, 0], [0, -x]].freeze
    when 'B'
      move_directions = [[x, x], [-x, x], [-x, -x], [x, -x]].freeze
    when 'N'
      move_directions = [[-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1]].freeze
    end
    move_directions.each do |coordinate|
      new_tile = [position[0] + coordinate[0], position[1] + coordinate[1]]
      if in_bounds?(new_tile)
        possible_tiles << new_tile
      end
    end
    possible_tiles
  end

  def run_game
    greeting_setup
    @board.populate_board
    @board.print_board
    player_turn
    puts current_player[:name]
  end

  # def save_game
  # end
end
