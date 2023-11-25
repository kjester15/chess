require 'pry-byebug'
require_relative 'chess_board'
require_relative 'chess_piece'

class Game
  attr_accessor :player1, :player2, :board, :current_player, :move_log, :game_over, :move_complete

  def initialize(board, current_player = {})
    @player1 = { name: '', color: 'white' }
    @player2 = { name: '', color: 'black' }
    @board = board
    @current_player = current_player
    @move_log = []
    @game_over = false
    @move_complete = false
  end

  def set_current_player
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
      puts 'That is not a valid move'
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
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def convert_symbol_to_piece(symbol)
    case symbol
    when 'K'
      piece = 'king'
    when 'Q'
      piece = 'queen'
    when 'R'
      piece = 'rook'
    when 'B'
      piece = 'bishop'
    when 'N'
      piece = 'knight'
    else
      piece = 'pawn'
    end
    piece
  end

  def find_piece_locations(move)
    piece = convert_symbol_to_piece(move[0])
    color = @current_player[:color]
    possible_pieces = []
    8.times do |row|
      8.times do |column|
        unless board.board_array[row][column].instance_of?(String)
          tile = board.board_array[row][column]
          tile.type == piece && tile.color == color ? possible_pieces << [row, column] : next
        end
      end
    end
    possible_pieces
  end

  def add_moves(moves, tile, piece, coordinate)
    return unless moves.include?(tile)

    coordinate unless %w[Q R B].include?(piece)
    if not_obscured?(coordinate, tile) then coordinate end
  end

  def narrow_pieces(final_pieces, move)
    # TODO: check if user input any rank or file specifications and use to narrow down pieces
    if move.length == 3
      # 
    end
    if move.length == 4
    end
    if move.length == 5
    end
    final_pieces
  end

  def find_piece(pieces_array, move)
    piece = move[0]
    final_pieces = []
    tile = translate_move(move[-2..])
    moves = []
    color = @current_player[:color]
    pieces_array.each do |coordinate|
      if %w[K Q R B N].include?(piece)
        moves = board.board_array[coordinate[0]][coordinate[1]].piece_moves(piece, coordinate)
      else
        moves = board.board_array[coordinate[0]][coordinate[1]].pawn_moves(coordinate, color, is_pawn_capture?(coordinate, move))
      end
      added_move = add_moves(moves, tile, piece, coordinate)
      final_pieces << added_move unless added_move.nil?
    end
    # TODO:
    # if final_pieces.length > 1
    #   # final_pieces = new method to narrow final_pieces based on rest of input
    #   final_pieces = narrow_pieces(final_pieces, move)
    # end
    final_pieces # this is returning an array but the step above will narrow it down to one piece (tile)
  end

  def is_pawn_capture?(start_tile, move)
    move_to = translate_move(move[-2..])
    return unless (start_tile[0] - move_to[0]).abs == 1 && (start_tile[1] - move_to[1]).abs == 1

    board.tile_occupied?(move_to) ? true : nil
  end

  def move_piece(piece, move)
    piece = piece[0] # remove this once #find_piece returns one piece and not an array
    move_to = translate_move(move[-2..])
    if board.tile_occupied?(move_to)
      unless can_capture?(piece, move)
        # TODO: doesn't allow black pawn to capture white pawn when there are two pawns able to capture
        # also didn't allow single black pawn to capture white pawn when it was a valid capture
        puts 'You cannot capture this piece.'
        return
      end
    end
    board.board_array[move_to[0]][move_to[1]] = board.board_array[piece[0]][piece[1]]
    board.board_array[piece[0]][piece[1]] = ' '
    @move_complete = true
  end

  def translate_move(selection)
    row_array = %w[8 7 6 5 4 3 2 1]
    col_array = %w[a b c d e f g h]
    row = row_array.index(selection[1])
    column = col_array.index(selection[0])
    [row, column]
  end

  def diagonal_from_pawn?(start_tile, end_tile)
    return unless (end_tile[1] - start_tile[1]).abs == 1

    true
  end

  def can_capture?(start_tile, move)
    move_to = translate_move(move[-2..])
    piece = move[0]
    if %w[K Q R B N].include?(piece)
      board.board_array[move_to[0]][move_to[1]].color != @current_player[:color]
    elsif diagonal_from_pawn?(start_tile, move_to)
      board.board_array[move_to[0]][move_to[1]].color != @current_player[:color]
    end
  end

  def not_obscured?(start_tile, end_tile)
    if start_tile[0] == end_tile[0]
      x_adjust = (start_tile[0] - end_tile[0]).positive? ? -1 : 1
      length = (end_tile[1] - start_tile[1]).abs - 1
      length.times do |x|
        adjust = (x + 1) * x_adjust
        if board.board_array[start_tile[0]][start_tile[1] + adjust].instance_of?(Piece)
          return
        end
      end
    elsif start_tile[1] == end_tile[1]
      y_adjust = (start_tile[0] - end_tile[0]).positive? ? -1 : 1
      length = (end_tile[0] - start_tile[0]).abs - 1
      length.times do |y|
        adjust = (y + 1) * y_adjust
        if board.board_array[start_tile[0] + adjust][start_tile[1]].instance_of?(Piece)
          return
        end
      end
    else
      z_adjust = [(start_tile[0] - end_tile[0]).positive? ? -1 : 1, (start_tile[1] - end_tile[1]).positive? ? -1 : 1]
      length = (end_tile[0] - start_tile[0]).abs - 1
      length.times do |z|
        row_adjust = (z + 1) * z_adjust[0]
        col_adjust = (z + 1) * z_adjust[1]
        if board.board_array[start_tile[0] + row_adjust][start_tile[1] + col_adjust].instance_of?(Piece)
          return
        end
      end
    end
    true
  end

  def player_turn
    until move_complete
      move = player_input
      validated = validate_input(move)
      until validated
        move = player_input
        validated = validate_input(move)
      end
      possible_pieces = find_piece_locations(move)
      piece = find_piece(possible_pieces, move)
      if piece.length == 0
        puts 'No valid piece identified - make another selection'
      else
        move_piece(piece, move)
      end
    end
    @move_complete = false
    # TODO: if multiples pieces are found, reprompt user input with file, rank, or rank and file, until only one option remains
    move_log << move # TODO: if a piece was captured add an x to the player's entered move before the location (Kxg5)) array.insert(-2, 'x')
    update_current_player
  end

  def run_game
    greeting_setup
    board.populate_board
    board.print_board
    set_current_player
    until game_over
      puts "#{current_player[:name]}, your turn."
      player_turn
      board.print_board
    end
  end

  # def save_game
  # end
end
