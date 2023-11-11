require_relative 'chess_board'
require_relative 'chess_piece'
require_relative 'chess_player'

class Game
  attr_accessor :player1, :player2, :board

  def initialize
    @player1 = Player.new
    @player2 = Player.new
    @board = Board.new
  end

  def greeting_setup
    puts 'Hello! Welcome to Chess. Let\'s play a game in the console.'
    puts 'What is player 1\'s name?'
    @player1.name = gets.chomp
    @player1.color = 'white'
    puts "#{player1.name} will be white."
    puts 'What is player 2\'s name?'
    @player2.name = gets.chomp
    @player2.color = 'black'
    puts "#{player2.name} will be black."
    puts "White goes first. #{@player1.name}, your turn!"
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

  def player_turn
    # Retrieve player move
    move = player_input
    # Validate move
    validated = validate_input(move)
    until validated
      move = player_input
      validated = validate_input(move)
    end
    # Determine potential spaces piece could move from (CREATE NEW METHOD)
    #   run a possible move method on the move location based on the noted letter and add to array
    possible_tiles = []
    # Check for piece (CREATE NEW METHOD)
    #   check if the noted piece is in any of the move locations in the previously created array
    # Move (and replace) piece (CREATE NEW METHOD)
    #   if the piece is found, move the piece to the new location
    #     if the piece is not found, reprompt the entire process
    #       if multiples pieces are found, reprompt user input with file, rank, or rank and file,
    #       until only one option remains
    #   if a piece is captured, replace it with the players piece
    #     add an x to the player's entered move before the location (Kxg5)
    # Add move to log (CREATE NEW METHOD)
    #   the player's move text to an array of moves that have been made
  end

  def run_game
    board = Board.new
    board.populate_board
    board.print_board
    player_turn
    # player_turn
    # piece = Piece.new('king', 'black', [3, 3])
    # piece.king_moves(piece.coordinate)
  end

  # def save_game
  # end
end
