require 'pry-byebug'
require_relative 'chess_board'
require_relative 'chess_piece'
require 'yaml'

class Game
  attr_accessor :player1, :player2, :board, :current_player, :move_log, :game_over, :move_complete, :load

  def initialize(board, current_player = {})
    @player1 = { name: '', color: 'white' }
    @player2 = { name: '', color: 'black' }
    @board = board
    @current_player = current_player
    @move_log = []
    @game_over = false
    @move_complete = false
    @load = false
  end

  def set_current_player
    @current_player = @player1
  end

  def greeting_setup
    puts 'Hello! Welcome to Chess. Let\'s play a game in the console.'
    puts 'If you would like to load a previous game, please type LOAD - otherwise hit enter'
    @load = gets.chomp == 'LOAD' ? true : false
    if @load
      load_game(get_load_data)
      return
    end
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

  def convert_piece_to_symbol(piece)
    case piece
    when 'king'
      symbol = 'K'
    when 'queen'
      symbol = 'Q'
    when 'knight'
      symbol = 'N'
    when 'bishop'
      symbol = 'B'
    when 'rook'
      symbol = 'R'
    end
    symbol
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

    return coordinate unless %w[Q R B].include?(piece)

    return coordinate if not_obscured?(coordinate, tile)
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
    return unless board.board_array[start_tile[0]][start_tile[1]].instance_of?(Piece)

    return unless board.board_array[start_tile[0]][start_tile[1]].type == 'pawn'

    return unless (start_tile[0] - end_tile[0]).abs == 2

    if board.board_array[start_tile[0]][start_tile[1]].color == 'black' && start_tile[0] == 1
      board.board_array[start_tile[0]][start_tile[1]].update_enpassant(true)
      board.board_array[start_tile[0]][start_tile[1]].update_enpassant_count(2)
    elsif board.board_array[start_tile[0]][start_tile[1]].color == 'white' && start_tile[0] == 6
      board.board_array[start_tile[0]][start_tile[1]].update_enpassant(true)
      board.board_array[start_tile[0]][start_tile[1]].update_enpassant_count(2)
    end
  end

  def decrease_enpassant_count
    8.times do |row|
      8.times do |column|
        unless board.board_array[row][column] == ' '
          if board.board_array[row][column].en_passant == true
            board.board_array[row][column].decrease_enpassant_count(1)
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
            board.board_array[row][column].update_enpassant(false)
            board.board_array[row][column].update_enpassant_count('')
          end
        end
      end
    end
  end

  def move_piece(piece, move)
    move_to = translate_move(move[-2..])
    symbol = move[0]
    if board.tile_occupied?(move_to)
      unless can_capture?(piece, move)
        puts 'You cannot capture this piece.'
        return
      end
    elsif !en_passant?(piece).nil? && en_passant?(piece)[1]
      captured_pawn = en_passant?(piece)[2]
      board.clear_tile(captured_pawn)
    end
    pawn_first_move?(piece, move_to)
    return if symbol == 'K' && prevent_king_check?(move_to)

    board.change_tile(move_to, piece)
    board.update_coordinate(move_to)
    board.clear_tile(piece)
    board.board_array[move_to[0]][move_to[1]].update_has_moved
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
    return unless board.board_array[start_tile[0]][start_tile[1]].instance_of?(Piece)

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

  def convert_coord_to_move(symbol, coordinate)
    rank = (coordinate[0] - 8).abs
    file = (coordinate[1] + 97).chr
    "#{symbol}#{file}#{rank}"
  end

  def can_capture?(start_tile, move, check = nil)
    move_to = translate_move(move[-2..])
    piece = move[0]
    if check.nil?
      if %w[K Q R B N].include?(piece)
        board.board_array[move_to[0]][move_to[1]].color != @current_player[:color]
      elsif diagonal_from_pawn?(start_tile, move_to)
        board.board_array[move_to[0]][move_to[1]].color != @current_player[:color]
      end
    else
      if %w[K Q R B N].include?(piece)
        board.board_array[move_to[0]][move_to[1]].color == @current_player[:color]
      elsif diagonal_from_pawn?(start_tile, move_to)
        board.board_array[move_to[0]][move_to[1]].color == @current_player[:color]
      end
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

  def castle
    # DONE: assign piece class a has_moved true false variable
    # DONE: assign piece class a check true false variable
    # TODO: add castle to possible move directions for king
    # return unless king_tile !check? && king.has_moved == false && rook.has_moved == false
    #
    # [array of tiles: [move_to], [tile between]].each do |tile|
    #   return if tile in check?
    # end
    #
    # move_to = king
    # opposite_side_king = rook

    # How it works:
    #   1. Move king 2 tiles towards either rook
    #   2. Move rook that king moved towards on opposite side of king
    # Rules:
    #   1. King and Rook CANNOT HAVE BEEN MOVED YET
    #   2. King CANNOT BE UNDER ATTACK (in check)
    #   3. King CANNOT CASTLE THROUGH CHECK
  end

  def prevent_king_check?(move_to)
    return unless check?(true, move_to)

    puts 'That tile is in check, you cannot move there.'
    true
  end

  def find_king
    color = @current_player[:color] == 'white' ? 'black' : 'white'
    8.times do |row|
      8.times do |column|
        unless board.board_array[row][column] == ' '
          if board.board_array[row][column].type == 'king' && board.board_array[row][column].color == color
            return [row, column]
          end
        end
      end
    end
    false
  end

  def collect_pieces
    # TODO: when called from #check? via #prevent_king_check? it's calling the same players pieces
    color = @current_player[:color]
    pieces = []
    8.times do |row|
      8.times do |column|
        unless board.board_array[row][column] == ' '
          if board.board_array[row][column].instance_of?(Piece) && board.board_array[row][column].color == color
            pieces << [row, column]
          end
        end
      end
    end
    pieces
  end

  def check?(prevent, move_to)
    king_tile = prevent ? move_to : find_king
    pieces = collect_pieces
    pieces.each do |tile|
      piece_type = board.board_array[tile[0]][tile[1]].type
      symbol = convert_piece_to_symbol(piece_type)
      if %w[K Q R B N].include?(symbol)
        all_moves = board.board_array[tile[0]][tile[1]].piece_moves(symbol, tile)
        moves = add_moves(all_moves, king_tile, symbol, tile)
      else
        all_moves = board.board_array[tile[0]][tile[1]].pawn_moves(tile, @current_player[:color], true, ['', false])
        moves = add_moves(all_moves, king_tile, symbol, tile)
      end
      p piece_type
      p tile
      p moves
      unless moves.nil?
        # TODO: this should not call update_check when being called from #prevent_king_check
        board.board_array[king_tile[0]][king_tile[1]].update_check(true)
        return true
      end
      board.board_array[king_tile[0]][king_tile[1]].update_check(false)
    end
  end

  def checkmate?
    return unless check?(false, nil) == true

    moves = []
    king_tile = find_king
    possible_moves = board.board_array[king_tile[0]][king_tile[1]].piece_moves('K', king_tile)
    possible_moves.each do |move|
      if board.board_array[move[0]][move[1]] == ' ' && !check?(true, move)
        moves << move
      elsif board.tile_occupied?(move) && can_capture?(king_tile, convert_coord_to_move('K', move), true)
        moves << move
      end
    end
    return unless moves.empty?

    true
  end

  def game_over?
    if find_king == false || checkmate?
      puts "Congratulations #{current_player[:name]}, you win!"
      return true
    end
  end

  def promotion(move)
    move_to = translate_move(move[-2..])
    return unless board.board_array[move_to[0]][move_to[1]].instance_of?(Piece)

    return unless board.board_array[move_to[0]][move_to[1]].type == 'pawn'

    if @current_player[:color] == 'white' && move_to[0] == 0
      board.create_piece(move_to[0], move_to[1], 'queen', 'white')
    elsif @current_player[:color] == 'black' && move_to[0] == 7
      board.create_piece(move_to[0], move_to[1], 'queen', 'black')
    end
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
        move_piece(piece[0], move)
        promotion(move)
      end
    end
    @move_complete = false
    move_log << move
  end

  def run_game
    greeting_setup
    unless @load
      board.populate_board
      set_current_player
    end
    # system 'clear'
    until game_over
      board.print_board
      puts "#{current_player[:name]}, your turn."
      player_turn
      # system 'clear'
      board.print_board
      decrease_enpassant_count
      reset_en_passant
      if check?(false, nil) == true
        if checkmate?
          puts 'Checkmate'
          @game_over = true
        else
          puts 'Check'
        end
      end
      if game_over? then @game_over = true end
      update_current_player
      puts 'If you would like to save your game, please type SAVE (the next player will resume upon load) - otherwise hit enter'
      save = gets.chomp == 'SAVE'
      if save then create_save end
      # system 'clear'
    end
  end

  def create_save
    save = Psych.dump(self)
    puts 'Please enter a save ID for your game: '
    id = gets.chomp
    save_game(id, save)
  end

  def save_game(id, save_object)
    Dir.mkdir('saves') unless Dir.exist?('saves')
    filename = "saves/#{id}.yml"
    File.open(filename, 'w') do |file|
      file.puts save_object
    end
  end

  def get_load_data
    file_valid = false
    until file_valid
      puts 'Please enter the game\'s save ID: '
      id = gets.chomp
      if File.file?("saves/#{id}.yml")
        file_valid = true
      else
        puts 'File name is not valid - please try again'
      end
    end
    "saves/#{id}.yml"
  end

  def load_game(filename)
    load = Psych.load_file(filename, aliases: true, permitted_classes: [Symbol, Game, Board, Piece])
    @player1 = load.player1
    @player2 = load.player2
    @board = load.board
    @current_player = load.current_player
    @move_log = load.move_log
    @game_over = load.game_over
    @move_complete = load.move_complete
  end
end
