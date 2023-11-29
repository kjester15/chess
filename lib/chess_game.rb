require 'pry-byebug'
require_relative 'chess_board'
require_relative 'chess_piece'

class Game
  attr_accessor :player1, :player2, :board, :current_player, :move_log, :game_over, :move_complete, :current_enpassant, :enpassant_count

  def initialize(board, current_player = {})
    @player1 = { name: '', color: 'white' }
    @player2 = { name: '', color: 'black' }
    @board = board
    @current_player = current_player
    @move_log = []
    @game_over = false
    @move_complete = false
    @current_enpassant = ''
    @enpassant_count = 2
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

  def convert_file_to_column(file)
    file.ord - 97
  end

  def narrow_pieces(final_pieces, move)
    file = %w[a b c d e f g h]
    rank = %w[1 2 3 4 5 6 7 8]
    piece = []
    case move.length
    when 3
      unless %w[K Q R B N].include?(move[0])
        if file.include?(move[0])
          file = move[0]
          column = convert_file_to_column(file)
          piece = final_pieces.select { |tile| tile[1] == column }
        elsif rank.include?(move[0])
          rank = move[0].to_i
          row = (rank - 8).abs
          piece = final_pieces.select { |tile| tile[0] == row }
        end
      end
    when 4
      if file.include?(move[1])
        file = move[1]
        column = convert_file_to_column(file)
        piece = final_pieces.select { |tile| tile[1] == column }
      elsif rank.include?(move[1])
        rank = move[1].to_i
        row = (rank - 8).abs
        piece = final_pieces.select { |tile| tile[0] == row }
      end
    when 5
      if file.include?(move[1]) && rank.include?(move[2])
        file = move[1]
        rank = move[2].to_i
        column = convert_file_to_column(file)
        row = (rank - 8).abs
        piece = final_pieces.select { |tile| tile[0] == row && tile[1] == column }
      end
    end
    piece
  end

  def find_piece(pieces_array, move)
    tile = translate_move(move[-2..])
    color = @current_player[:color]
    piece = move[0]
    final_pieces = call_moves_method(piece, pieces_array, move, color, tile)
    if final_pieces.length > 1 then final_pieces = narrow_pieces(final_pieces, move) end
    final_pieces
  end

  def call_moves_method(piece, pieces, move, color, tile)
    final_pieces = []
    moves = []
    pieces.each do |coordinate|
      if %w[K Q R B N].include?(piece)
        moves = board.board_array[coordinate[0]][coordinate[1]].piece_moves(piece, coordinate)
      else
        moves = board.board_array[coordinate[0]][coordinate[1]].pawn_moves(coordinate, color,
                                                                           is_pawn_capture?(coordinate, move),
                                                                           en_passant?(coordinate))
      end
      added_move = add_moves(moves, tile, piece, coordinate)
      final_pieces << added_move unless added_move.nil?
    end
    final_pieces
  end

  def is_pawn_capture?(start_tile, move)
    move_to = translate_move(move[-2..])
    return unless (start_tile[0] - move_to[0]).abs == 1 && (start_tile[1] - move_to[1]).abs == 1

    board.tile_occupied?(move_to) ? true : nil
  end

  def pawn_first_move?(start_tile, end_tile)
    return unless board.board_array[start_tile[0]][start_tile[1]].type == 'pawn'

    return unless (start_tile[0] - end_tile[0]).abs == 2

    return unless start_tile[0] == 1 || start_tile[0] == 6

    if board.board_array[start_tile[0]][start_tile[1]].color == 'black' && start_tile[0] == 1
      board.board_array[start_tile[0]][start_tile[1]].en_passant = true
      board.board_array[start_tile[0]][start_tile[1]].en_passant_count = 2
    elsif board.board_array[start_tile[0]][start_tile[1]].color == 'white' && start_tile[0] == 6
      board.board_array[start_tile[0]][start_tile[1]].en_passant = true
      board.board_array[start_tile[0]][start_tile[1]].en_passant_count = 2
    end
    @current_enpassant = board.board_array[start_tile[0]][start_tile[1]]
  end

  def update_enpassant_count
    8.times do |row|
      8.times do |column|
        unless board.board_array[row][column] == ' '
          if board.board_array[row][column].en_passant == true
            board.board_array[row][column].en_passant_count -= 1
          end
        end
      end
    end
  end

  def reset_en_passant
    8.times do |row|
      8.times do |column|
        unless board.board_array[row][column] == ' '
          if board.board_array[row][column].en_passant_count == 0
            board.board_array[row][column].en_passant = false
            board.board_array[row][column].en_passant_count = ''
          end
        end
      end
    end
  end

  def move_piece(piece, move)
    piece = piece[0]
    move_to = translate_move(move[-2..])
    if board.tile_occupied?(move_to)
      unless can_capture?(piece, move)
        puts 'You cannot capture this piece.'
        return
      end
    elsif en_passant?(piece)[1]
      captured_pawn = en_passant?(piece)[2]
      board.board_array[captured_pawn[0]][captured_pawn[1]] = ' '
    end
    pawn_first_move?(piece, move_to)
    board.board_array[move_to[0]][move_to[1]] = board.board_array[piece[0]][piece[1]]
    board.board_array[move_to[0]][move_to[1]].coordinate = [move_to]
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

  def en_passant?(start_tile)
    return unless board.board_array[start_tile[0]][start_tile[1]].type == 'pawn'

    left_check = [start_tile[0], start_tile[1] - 1]
    right_check = [start_tile[0], start_tile[1] + 1]

    if board.board_array[left_check[0]][left_check[1]].instance_of?(Piece) &&
       board.board_array[left_check[0]][left_check[1]].en_passant == true
      ['left', true, left_check]
    elsif board.board_array[right_check[0]][right_check[1]].instance_of?(Piece) &&
          board.board_array[right_check[0]][right_check[1]].en_passant == true
      ['right', true, right_check]
    else
      ['none', false]
    end
  end

  def castle?
    # TODO
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

  def check?
    # TODO
  end

  def checkmate?
    # TODO
  end

  def promotion?
    # TODO
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
      update_enpassant_count
      reset_en_passant
    end
  end

  def save_game
    # TODO
  end
end
