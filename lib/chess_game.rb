require_relative 'chess_board'
require_relative 'chess_piece'
require_relative 'chess_player'

piece = Piece.new
board = Board.new
puts piece.pieces[:king_w]
board.print_board