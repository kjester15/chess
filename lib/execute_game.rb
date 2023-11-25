require_relative 'chess_game'
require 'pry-byebug'

game = Game.new(Board.new(Array.new(8) { Array.new(8) { ' ' } }))
game.run_game