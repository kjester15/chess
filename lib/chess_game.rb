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
end

board = Board.new
board.populate_board
board.print_board
# x = board.board_array[0]
# puts x.symbol
