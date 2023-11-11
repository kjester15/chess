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

  def player_turn
    # Retrieve player move (CREATE NEW METHOD)
    #   enter a move to make - piece letter followed by move location
    # Validate move (CREATE NEW METHOD)
    #   take the entered text and separate the first letter and move location
    #     validate that the first letter is correct (K/Q/R/B/N/pawn is '')
    #     validate that the move location is a valid spot on the board
    # Determine potential spaces piece could move from (CREATE NEW METHOD)
    #   run a possible move method on the move location based on the noted letter and add to array
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
    # piece = Piece.new('king', 'black', [3, 3])
    # piece.king_moves(piece.coordinate)
  end

  # def save_game
  # end
end

game = Game.new
game.run_game
