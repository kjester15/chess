require_relative '../lib/chess_board'
require_relative '../lib/chess_piece'
require_relative '../lib/chess_game'
require 'pry-byebug'

describe Board do
  subject(:board_main) { described_class.new }

  describe '#initialize' do
    # Initialize -> No test necessary when only creating instance variables.
  end

  describe '#populate_board' do
    # method only iterates over array - no test necessary
  end

  describe '#create_piece' do
    it 'creates a Piece object' do
      row = 0
      column = 0
      type = 'king'
      color = 'black'
      result = board_main.create_piece(row, column, type, color)
      expect(result).to be_a Piece
    end

    it 'creates a rook' do
      row = 0
      column = 0
      type = 'rook'
      color = 'black'
      result = board_main.create_piece(row, column, type, color).type
      expect(result).to eq('rook')
    end

    it 'creates a piece at the coordinate [0, 0]' do
      row = 0
      column = 0
      type = 'king'
      color = 'black'
      result = board_main.create_piece(row, column, type, color).coordinate
      expect(result).to eq([0, 0])
    end

    it 'creates a white piece' do
      row = 0
      column = 0
      type = 'king'
      color = 'white'
      result = board_main.create_piece(row, column, type, color).color
      expect(result).to eq('white')
    end
  end

  describe '#determine_piece' do
    it 'creates a Piece object' do
      row = 0
      column = 0
      result = board_main.determine_piece(row, column)
      expect(result).to be_a Piece
    end
  end

  describe '#print_board' do
    # method only prints to terminal - no test necessary
  end

  describe '#print_tile' do
    # method only prints to terminal - no test necessary
  end

  describe '#tile_occupied?' do
    context 'when given an occupied tile' do
      it 'returns true when given "[0, 0]"' do
        array = Array.new(8) { Array.new(8) { 'x' } }
        board_main.instance_variable_set(:@board_array, array)
        tile = [0, 0]
        result = board_main.tile_occupied?(tile)
        expect(result).to be true
      end
    end
    context 'when given an empty tile' do
      it 'returns nil when given "[3, 0]"' do
        tile = [3, 0]
        result = board_main.tile_occupied?(tile)
        expect(result).to be nil
      end
    end
  end
end

describe Piece do
  subject(:piece_main) { described_class.new('king', 'black', [0, 4]) }

  describe '#initialize' do
    # Initialize -> No test necessary when only creating instance variables.
  end

  describe '#pawn_move_directions' do
    context 'when a white pawn is moving' do
      it 'returns standard directions when moving on 2nd+ turn and not capturing' do
        position = [5, 0]
        color = 'white'
        capture = false
        expected_directions = [[-1, 0]]
        result = piece_main.pawn_move_directions(position, color, capture)
        expect(result).to eq(expected_directions)
      end

      it 'returns standard plus first move directions when moving on first turn and not capturing' do
        position = [6, 0]
        color = 'white'
        capture = false
        expected_directions = [[-1, 0], [-2, 0]]
        result = piece_main.pawn_move_directions(position, color, capture)
        expect(result).to eq(expected_directions)
      end

      it 'returns standard plus capture directions when moving on 2nd+ turn and capturing' do
        position = [4, 0]
        color = 'white'
        capture = true
        expected_directions = [[-1, 0], [-1, 1], [-1, -1]]
        result = piece_main.pawn_move_directions(position, color, capture)
        expect(result).to eq(expected_directions)
      end
    end

    context 'when a black pawn is moving' do
      it 'returns standard directions when moving on 2nd+ turn and not capturing' do
        position = [2, 0]
        color = 'black'
        capture = false
        expected_directions = [[1, 0]]
        result = piece_main.pawn_move_directions(position, color, capture)
        expect(result).to eq(expected_directions)
      end

      it 'returns standard plus first move directions when moving on first turn and not capturing' do
        position = [1, 0]
        color = 'black'
        capture = false
        expected_directions = [[1, 0], [2, 0]]
        result = piece_main.pawn_move_directions(position, color, capture)
        expect(result).to eq(expected_directions)
      end

      it 'returns standard plus capture directions when moving on 2nd+ turn and capturing' do
        position = [4, 0]
        color = 'black'
        capture = true
        expected_directions = [[1, 0], [1, 1], [1, -1]]
        result = piece_main.pawn_move_directions(position, color, capture)
        expect(result).to eq(expected_directions)
      end
    end
  end

  describe '#pawn_moves' do
    context 'when a white pawn is moving' do
      it 'returns correct tiles when moving on first turn and not capturing' do
        position = [6, 3]
        color = 'white'
        capture = false
        expected_moves = [[5, 3], [4, 3]]
        result = piece_main.pawn_moves(position, color, capture)
        expect(result).to eq(expected_moves)
      end

      it 'returns correct tiles when moving on 2nd+ turn and not capturing' do
        position = [5, 3]
        color = 'white'
        capture = false
        expected_moves = [[4, 3]]
        result = piece_main.pawn_moves(position, color, capture)
        expect(result).to eq(expected_moves)
      end

      it 'returns correct tiles when moving on 2nd+ turn and capturing' do
        position = [5, 3]
        color = 'white'
        capture = true
        expected_moves = [[4, 3], [4, 4], [4, 2]]
        result = piece_main.pawn_moves(position, color, capture)
        expect(result).to eq(expected_moves)
      end

      it 'doesn\'t add out of bounds tiles' do
        position = [4, 0]
        color = 'white'
        capture = true
        expected_moves = [[3, 0], [3, 1]]
        result = piece_main.pawn_moves(position, color, capture)
        expect(result).to eq(expected_moves)
      end
    end

    context 'when a black pawn is moving' do
      it 'returns correct tiles when moving on first turn and not capturing' do
        position = [1, 3]
        color = 'black'
        capture = false
        expected_moves = [[2, 3], [3, 3]]
        result = piece_main.pawn_moves(position, color, capture)
        expect(result).to eq(expected_moves)
      end

      it 'returns correct tiles when moving on 2nd+ turn and not capturing' do
        position = [2, 3]
        color = 'black'
        capture = false
        expected_moves = [[3, 3]]
        result = piece_main.pawn_moves(position, color, capture)
        expect(result).to eq(expected_moves)
      end

      it 'returns correct tiles when moving on 2nd+ turn and capturing' do
        position = [2, 3]
        color = 'black'
        capture = true
        expected_moves = [[3, 3], [3, 4], [3, 2]]
        result = piece_main.pawn_moves(position, color, capture)
        expect(result).to eq(expected_moves)
      end

      it 'doesn\'t add out of bounds tiles' do
        position = [3, 0]
        color = 'black'
        capture = true
        expected_moves = [[4, 0], [4, 1]]
        result = piece_main.pawn_moves(position, color, capture)
        expect(result).to eq(expected_moves)
      end
    end
  end

  describe '#king_knight_moves' do
    context 'when a king is moving' do
      it 'returns correct tiles' do
        position = [3, 3]
        move_directions = [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]]
        expected_moves = [[4, 3], [4, 4], [3, 4], [2, 4], [2, 3], [2, 2], [3, 2], [4, 2]]
        result = piece_main.king_knight_moves(position, move_directions)
        expect(result).to eq(expected_moves)
      end

      it 'doesn\'t add out of bounds tiles' do
        position = [0, 0]
        move_directions = [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]]
        expected_moves = [[1, 0], [1, 1], [0, 1]]
        result = piece_main.king_knight_moves(position, move_directions)
        expect(result).to eq(expected_moves)
      end
    end

    context 'when a knight is moving' do
      it 'returns correct tiles' do
        position = [3, 3]
        move_directions = [[-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1]]
        expected_moves = [[1, 4], [2, 5], [4, 5], [5, 4], [5, 2], [4, 1], [2, 1], [1, 2]]
        result = piece_main.king_knight_moves(position, move_directions)
        expect(result).to eq(expected_moves)
      end

      it 'doesn\'t add out of bounds tiles' do
        position = [0, 0]
        move_directions = [[-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1]]
        expected_moves = [[1, 2], [2, 1]]
        result = piece_main.king_knight_moves(position, move_directions)
        expect(result).to eq(expected_moves)
      end
    end
  end

  describe '#queen_rook_bishop_moves' do
    context 'when a queen is moving' do
      it 'returns correct tiles with none out of bounds' do
        position = [3, 3]
        move_directions = [['x', 0], ['x', 'x'], [0, 'x'], ['-x', 'x'], ['-x', 0], ['-x', '-x'], [0, '-x'], ['x', '-x']]
        expected_moves = [[4, 3], [5, 3], [6, 3], [7, 3], # straight down
                          [4, 4], [5, 5], [6, 6], [7, 7], # down right diagonal
                          [3, 4], [3, 5], [3, 6], [3, 7], # straight right
                          [2, 4], [1, 5], [0, 6], # up right diagonal
                          [2, 3], [1, 3], [0, 3], # straight up
                          [2, 2], [1, 1], [0, 0], # up left diagonal
                          [3, 2], [3, 1], [3, 0], # straight left
                          [4, 2], [5, 1], [6, 0]] # down left diagonal
        result = piece_main.queen_rook_bishop_moves(position, move_directions)
        expect(result).to eq(expected_moves)
      end
    end

    context 'when a rook is moving' do
      it 'returns correct tiles with none out of bounds' do
        position = [3, 3]
        move_directions = [['x', 0], [0, 'x'], ['-x', 0], [0, '-x']]
        expected_moves = [[4, 3], [5, 3], [6, 3], [7, 3], # straight down
                          [3, 4], [3, 5], [3, 6], [3, 7], # straight right
                          [2, 3], [1, 3], [0, 3], # straight up
                          [3, 2], [3, 1], [3, 0]] # straight left
        result = piece_main.queen_rook_bishop_moves(position, move_directions)
        expect(result).to eq(expected_moves)
      end
    end

    context 'when a bishop is moving' do
      it 'returns correct tiles with none out of bounds' do
        position = [3, 3]
        move_directions = [['x', 'x'], ['-x', 'x'], ['-x', '-x'], ['x', '-x']]
        expected_moves = [[4, 4], [5, 5], [6, 6], [7, 7], # down right diagonal
                          [2, 4], [1, 5], [0, 6], # up right diagonal
                          [2, 2], [1, 1], [0, 0], # up left diagonal
                          [4, 2], [5, 1], [6, 0]] # down left diagonal
        result = piece_main.queen_rook_bishop_moves(position, move_directions)
        expect(result).to eq(expected_moves)
      end
    end
  end

  describe '#piece_moves' do
    # method only calls other methods based on case statement - no test necessary
  end

  describe '#in_bounds?' do
    it 'returns true if coordinate is within the game board' do
      coordinate = [1, 1]
      expect(piece_main.in_bounds?(coordinate)).to be true
    end

    it 'returns nil if coordinate is outside the game board' do
      coordinate = [-1, 1]
      expect(piece_main.in_bounds?(coordinate)).to be nil
    end
  end
end

describe Game do
  subject(:game_main) { described_class.new(Board.new) }

  describe '#initialize' do
    # Initialize -> No test necessary when only creating instance variables.
  end

  describe '#greeting_setup' do
    # method only prints to terminal and updates instance variables - no test necessary
  end

  describe '#player_input' do
    # method only prints to terminal and gets player input - no test necessary
  end

  describe '#create_two_dig_array' do
    # method only interates and creates an array - no test necessary
  end

  describe '#create_three_dig_array' do
    # method only interates and creates an array - no test necessary
  end

  describe '#create_four_dig_array' do
    # method only interates and creates an array - no test necessary
  end

  describe '#create_five_dig_array' do
    # method only interates and creates an array - no test necessary
  end

  describe '#validate_input' do
    context 'when given a valid input' do
      it 'returns true when given "g5"' do
        input = 'g5'
        result = game_main.validate_input(input)
        expect(result).to be true
      end

      it 'returns true when given "Kg5"' do
        input = 'Kg5'
        result = game_main.validate_input(input)
        expect(result).to be true
      end

      it 'returns true when given "Kdg5"' do
        input = 'Kdg5'
        result = game_main.validate_input(input)
        expect(result).to be true
      end

      it 'returns true when given "K2g5"' do
        input = 'K2g5'
        result = game_main.validate_input(input)
        expect(result).to be true
      end

      it 'returns true when given "Kd2g5"' do
        input = 'Kd2g5'
        result = game_main.validate_input(input)
        expect(result).to be true
      end

      it 'returns true when given "eg5"' do
        input = 'eg5'
        result = game_main.validate_input(input)
        expect(result).to be true
      end

      it 'returns true when given "2g5"' do
        input = '2g5'
        result = game_main.validate_input(input)
        expect(result).to be true
      end
    end

    context 'when given an invalid input' do
      before do
        expect(game_main).to receive(:puts)
      end

      it 'returns false when given single letter "g"' do
        input = 'g'
        result = game_main.validate_input(input)
        expect(result).to be nil
      end

      it 'returns false when given single number "5"' do
        input = '5'
        result = game_main.validate_input(input)
        expect(result).to be nil
      end

      it 'returns false when given out of order "5g"' do
        input = '5g'
        result = game_main.validate_input(input)
        expect(result).to be nil
      end

      it 'returns false when given out of order "aK5"' do
        input = 'aK5'
        result = game_main.validate_input(input)
        expect(result).to be nil
      end

      it 'returns false when given 6 letter "Kad2g5"' do
        input = 'Kad2g5'
        result = game_main.validate_input(input)
        expect(result).to be nil
      end
    end
  end

  describe '#update_current_player' do
    # method only updates instance variable - no test required
  end

  describe '#convert_symbol_to_piece' do
    it 'returns king when symbol is K' do
      symbol = 'K'
      result = game_main.convert_symbol_to_piece(symbol)
      expect(result).to eq('king')
    end

    it 'returns queen when symbol is Q' do
      symbol = 'Q'
      result = game_main.convert_symbol_to_piece(symbol)
      expect(result).to eq('queen')
    end

    it 'returns rook when symbol is R' do
      symbol = 'R'
      result = game_main.convert_symbol_to_piece(symbol)
      expect(result).to eq('rook')
    end

    it 'returns bishop when symbol is B' do
      symbol = 'B'
      result = game_main.convert_symbol_to_piece(symbol)
      expect(result).to eq('bishop')
    end

    it 'returns knight when symbol is N' do
      symbol = 'N'
      result = game_main.convert_symbol_to_piece(symbol)
      expect(result).to eq('knight')
    end

    it 'returns pawn when symbol is anything else' do
      symbol = 'x'
      result = game_main.convert_symbol_to_piece(symbol)
      expect(result).to eq('pawn')
    end
  end

  describe '#find_piece_locations' do
    context 'when looking for white pawns' do
      array = [['x', 'x', Piece.new('pawn', 'white', [0, 2]), 'x', 'x', 'x', 'x', 'x'], %w[x x x x x x x x],
               ['x', 'x', Piece.new('pawn', 'white', [2, 2]), 'x', 'x', 'x', 'x', 'x'], %w[x x x x x x x x],
               %w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x]]
      let(:board) { Board.new(array) }
      let(:player) { { name: 'test', color: 'white' } }
      subject(:game_main) { described_class.new(board, player) }

      before do
        allow(game_main).to receive(:convert_symbol_to_piece).and_return('pawn')
      end

      it 'returns two white pawns' do
        move = 'a3' # test another piece
        possible_pieces = [[0, 2], [2, 2]]
        result = game_main.find_piece_locations(move)
        expect(result).to eq(possible_pieces)
      end
    end

    context 'when looking for white kings' do
      array = [['x', Piece.new('king', 'white', [0, 2]), 'x', 'x', 'x', 'x', 'x', 'x'], %w[x x x x x x x x],
               ['x', 'x', 'x', 'x', Piece.new('king', 'white', [2, 2]), 'x', 'x', 'x'], %w[x x x x x x x x],
               %w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x]]
      let(:board) { Board.new(array) }
      let(:player) { { name: 'test', color: 'white' } }
      subject(:game_main) { described_class.new(board, player) }

      before do
        allow(game_main).to receive(:convert_symbol_to_piece).and_return('king')
      end

      it 'returns two white kings' do
        move = 'Ka3'
        possible_pieces = [[0, 1], [2, 4]]
        result = game_main.find_piece_locations(move)
        expect(result).to eq(possible_pieces)
      end
    end
  end

  describe '#add_moves' do
    context 'when the moves array does not include the given tile' do
      it 'returns nothing' do
        moves = [[1, 1], [2, 2], [3, 3]]
        tile = [2, 3]
        piece = 'K'
        coordinate = [4, 4]
        result = game_main.add_moves(moves, tile, piece, coordinate)
        expect(result).to be nil
      end
    end

    context 'when the moves array does include the given tile and the piece is not Q/R/B' do
      it 'returns coordinate' do
        moves = [[1, 1], [2, 2], [3, 3]]
        tile = [2, 2]
        piece = 'K'
        coordinate = [4, 4]
        result = game_main.add_moves(moves, tile, piece, coordinate)
        expect(result).to eq(coordinate)
      end
    end

    context 'when the moves array does include the given tile and the piece is Q/R/B, and #not_obscured? returns true' do
      before do
        allow(game_main).to receive(:not_obscured?).and_return(true)
      end

      it 'returns coordinate' do
        moves = [[1, 1], [2, 2], [3, 3]]
        tile = [2, 2]
        piece = 'Q'
        coordinate = [4, 4]
        result = game_main.add_moves(moves, tile, piece, coordinate)
        expect(result).to eq(coordinate)
      end
    end

    context 'when the moves array does include the given tile and the piece is Q/R/B, and #not_obscured? returns nil' do
      before do
        allow(game_main).to receive(:not_obscured?).and_return(false)
      end

      it 'returns nil' do
        moves = [[1, 1], [2, 2], [3, 3]]
        tile = [2, 2]
        piece = 'Q'
        coordinate = [4, 4]
        result = game_main.add_moves(moves, tile, piece, coordinate)
        expect(result).to eq(nil)
      end
    end
  end

  describe '#narrow_pieces' do
    context 'when entered move is 2 characters long' do
      it 'returns an empty array' do
        final_pieces = [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
        move = 'a3'
        piece = []
        result = game_main.narrow_pieces(final_pieces, move)
        expect(result).to eq(piece)
      end
    end

    context 'when entered move is 3 characters long and starts with a piece letter' do
      it 'returns an empty array' do
        final_pieces = [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
        move = 'Ka3'
        piece = []
        result = game_main.narrow_pieces(final_pieces, move)
        expect(result).to eq(piece)
      end
    end

    context 'when entered move is 3 characters long and doesn\'t start with a piece letter' do
      it 'returns [2, 2] when move[0] is c' do
        final_pieces = [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
        move = 'ca3'
        piece = [[2, 2]]
        result = game_main.narrow_pieces(final_pieces, move)
        expect(result).to eq(piece)
      end

      it 'returns [3, 3] when move[0] is d' do
        final_pieces = [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
        move = 'da3'
        piece = [[3, 3]]
        result = game_main.narrow_pieces(final_pieces, move)
        expect(result).to eq(piece)
      end

      it 'returns [2, 2] when move[0] is 6' do
        final_pieces = [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
        move = '6a3'
        piece = [[2, 2]]
        result = game_main.narrow_pieces(final_pieces, move)
        expect(result).to eq(piece)
      end

      it 'returns [3, 3] when move[0] is 5' do
        final_pieces = [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
        move = '5a3'
        piece = [[3, 3]]
        result = game_main.narrow_pieces(final_pieces, move)
        expect(result).to eq(piece)
      end
    end

    context 'when entered move is 4 characters long' do
      it 'returns [2, 2] when move[1] is c' do
        final_pieces = [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
        move = 'Kca3'
        piece = [[2, 2]]
        result = game_main.narrow_pieces(final_pieces, move)
        expect(result).to eq(piece)
      end

      it 'returns [3, 3] when move[1] is d' do
        final_pieces = [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
        move = 'Kda3'
        piece = [[3, 3]]
        result = game_main.narrow_pieces(final_pieces, move)
        expect(result).to eq(piece)
      end

      it 'returns [2, 2] when move[1] is 6' do
        final_pieces = [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
        move = 'K6a3'
        piece = [[2, 2]]
        result = game_main.narrow_pieces(final_pieces, move)
        expect(result).to eq(piece)
      end

      it 'returns [3, 3] when move[1] is 5' do
        final_pieces = [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
        move = 'K5a3'
        piece = [[3, 3]]
        result = game_main.narrow_pieces(final_pieces, move)
        expect(result).to eq(piece)
      end
    end

    context 'when entered move is 5 characters long' do
      it 'returns [2, 2] when move[1] is c and move[2] is 5' do
        final_pieces = [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
        move = 'Kc6a3'
        piece = [[2, 2]]
        result = game_main.narrow_pieces(final_pieces, move)
        expect(result).to eq(piece)
      end

      it 'returns [5, 5] when move[1] is f and move[2] is 3' do
        final_pieces = [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
        move = 'Kf3a3'
        piece = [[5, 5]]
        result = game_main.narrow_pieces(final_pieces, move)
        expect(result).to eq(piece)
      end
    end
  end

  describe '#find_piece' do
    context '' do
      xit '' do
      end
    end

    # find_piece(pieces_array, move)
    #   piece = move[0]
    #   final_pieces = []
    #   tile = translate_move(move[-2..])
    #   moves = []
    #   color = @current_player[:color]
    #   pieces_array.each do |coordinate|
    #     if %w[K Q R B N].include?(piece)
    #       moves = board.board_array[coordinate[0]][coordinate[1]].piece_moves(piece, coordinate)
    #     else
    #       moves = board.board_array[coordinate[0]][coordinate[1]].pawn_moves(coordinate, color, is_pawn_capture?(coordinate, move))
    #     end
    #     added_move = add_moves(moves, tile, piece, coordinate)
    #     final_pieces << added_move unless added_move.nil?
    #   end
    #   if final_pieces.length > 1 then final_pieces = narrow_pieces(final_pieces, move) end
    #   final_pieces
  end

  describe '#is_pawn_capture?' do
    context 'when two tiles given are more than 1 row and column apart' do
      before do
        allow(game_main).to receive(:translate_move).and_return([4, 4])
      end

      it 'returns nothing' do
        start_tile = [1, 1]
        move = 'Ke4'
        result = game_main.is_pawn_capture?(start_tile, move)
        expect(result).to be nil
      end
    end

    context 'when two tiles given are 1 row and column apart and tile is occupied' do
      before do
        allow(game_main).to receive(:translate_move).and_return([2, 2])
        allow(game_main.board).to receive(:tile_occupied?).and_return(true)
      end

      it 'returns true' do
        start_tile = [1, 1]
        move = 'Kc6'
        result = game_main.is_pawn_capture?(start_tile, move)
        expect(result).to be true
      end
    end

    context 'when two tiles given are 1 row and column apart and tile is not occupied' do
      before do
        allow(game_main).to receive(:translate_move).and_return([2, 2])
        allow(game_main.board).to receive(:tile_occupied?).and_return(false)
      end

      it 'returns true' do
        start_tile = [1, 1]
        move = 'Kc6'
        result = game_main.is_pawn_capture?(start_tile, move)
        expect(result).to be nil
      end
    end
  end

  describe '#move_piece' do
    context '' do
      xit '' do
      end
    end

    # move_piece(piece, move)
    #   piece = piece[0] # remove this once #find_piece returns one piece and not an array
    #   move_to = translate_move(move[-2..])
    #   if board.tile_occupied?(move_to)
    #     unless can_capture?(piece, move)
    #       # TODO: doesn't allow black pawn to capture white pawn when there are two pawns able to capture
    #       # also didn't allow single black pawn to capture white pawn when it was a valid capture
    #       puts 'You cannot capture this piece.'
    #       return
    #     end
    #   end
    #   board.board_array[move_to[0]][move_to[1]] = board.board_array[piece[0]][piece[1]]
    #   board.board_array[piece[0]][piece[1]] = ' '
    #   @move_complete = true
  end

  describe '#translate_move' do
    it 'returns [3, 1]' do
      selection = 'b5'
      result = game_main.translate_move(selection)
      expect(result).to eq([3, 1])
    end
  end

  describe '#diagonal_from_pawn?' do
    context 'when given tile 1 tile diagonal from current piece' do
      it 'returns true' do
        start_tile = [0, 0]
        end_tile = [1, 1]
        result = game_main.diagonal_from_pawn?(start_tile, end_tile)
        expect(result).to be true
      end
    end

    context 'when given tile more than 1 tile diagonal from current piece' do
      it 'returns nil' do
        start_tile = [0, 0]
        end_tile = [2, 2]
        result = game_main.diagonal_from_pawn?(start_tile, end_tile)
        expect(result).to be nil
      end
    end
  end

  describe '#can_capture?' do
    context 'when given a non-pawn of opposite color' do
      let(:board) { Board.new(Array.new(8) { Array.new(8) { Piece.new('king', 'white', [0, 2]) } }) }
      let(:player) { { name: 'test', color: 'black' } }
      subject(:game_main) { described_class.new(board, player) }

      before do
        allow(game_main).to receive(:translate_move).and_return([0, 0])
      end

      it 'returns true' do
        start_tile = [0, 0]
        move = 'Ka8'
        result = game_main.can_capture?(start_tile, move)
        expect(result).to be true
      end
    end

    context 'when given a non-pawn of the same color (white)' do
      let(:board) { Board.new(Array.new(8) { Array.new(8) { Piece.new('king', 'white', [0, 2]) } }) }
      let(:player) { { name: 'test', color: 'white' } }
      subject(:game_main) { described_class.new(board, player) }

      before do
        allow(game_main).to receive(:translate_move).and_return([0, 0])
      end

      it 'returns false' do
        start_tile = [0, 0]
        move = 'Ka8'
        result = game_main.can_capture?(start_tile, move)
        expect(result).to be false
      end
    end

    context 'when given a non-pawn of the same color (black)' do
      let(:board) { Board.new(Array.new(8) { Array.new(8) { Piece.new('king', 'black', [0, 2]) } }) }
      let(:player) { { name: 'test', color: 'black' } }
      subject(:game_main) { described_class.new(board, player) }

      before do
        allow(game_main).to receive(:translate_move).and_return([0, 0])
      end

      it 'returns false' do
        start_tile = [0, 0]
        move = 'Ka8'
        result = game_main.can_capture?(start_tile, move)
        expect(result).to be false
      end
    end

    context 'when given a pawn of opposite color' do
      let(:board) { Board.new(Array.new(8) { Array.new(8) { Piece.new('pawn', 'white', [0, 2]) } }) }
      let(:player) { { name: 'test', color: 'black' } }
      subject(:game_main) { described_class.new(board, player) }

      before do
        allow(game_main).to receive(:translate_move).and_return([0, 0])
        allow(game_main).to receive(:diagonal_from_pawn?).and_return(true)
      end

      it 'returns true' do
        start_tile = [0, 0]
        move = 'a8'
        result = game_main.can_capture?(start_tile, move)
        expect(result).to be true
      end
    end

    context 'when given a pawn of the same color (white)' do
      let(:board) { Board.new(Array.new(8) { Array.new(8) { Piece.new('pawn', 'white', [0, 2]) } }) }
      let(:player) { { name: 'test', color: 'white' } }
      subject(:game_main) { described_class.new(board, player) }

      before do
        allow(game_main).to receive(:translate_move).and_return([0, 0])
        allow(game_main).to receive(:diagonal_from_pawn?).and_return(true)
      end

      it 'returns false' do
        start_tile = [0, 0]
        move = 'a8'
        result = game_main.can_capture?(start_tile, move)
        expect(result).to be false
      end
    end

    context 'when given a pawn of the same color (black)' do
      let(:board) { Board.new(Array.new(8) { Array.new(8) { Piece.new('pawn', 'black', [0, 2]) } }) }
      let(:player) { { name: 'test', color: 'black' } }
      subject(:game_main) { described_class.new(board, player) }

      before do
        allow(game_main).to receive(:translate_move).and_return([0, 0])
        allow(game_main).to receive(:diagonal_from_pawn?).and_return(true)
      end

      it 'returns false' do
        start_tile = [0, 0]
        move = 'a8'
        result = game_main.can_capture?(start_tile, move)
        expect(result).to be false
      end
    end
  end

  describe '#not_obscured?' do
    context 'when start and end are in the same row and end is obscured by piece' do
      array = [['x', 'x', Piece.new('king', 'black', [0, 2]), 'x', 'x', 'x', 'x', 'x'], %w[x x x x x x x x],
               %w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x],
               %w[x x x x x x x x]]
      let(:board) { Board.new(array) }
      subject(:game_main) { described_class.new(board) }

      it 'returns false' do
        start_tile = [0, 0]
        end_tile = [0, 5]
        result = game_main.not_obscured?(start_tile, end_tile)
        expect(result).to be nil
      end
    end

    context 'when start and end are in the same row and end is not obscured by piece' do
      array = [%w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x],
               %w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x]]
      let(:board) { Board.new(array) }
      subject(:game_main) { described_class.new(board) }

      it 'returns true' do
        start_tile = [0, 0]
        end_tile = [0, 5]
        result = game_main.not_obscured?(start_tile, end_tile)
        expect(result).to be true
      end
    end

    context 'when start and end are in the same column and end is obscured by piece' do
      array = [%w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x],
               ['x', 'x', 'x', Piece.new('king', 'black', [0, 2]), 'x', 'x', 'x', 'x'], %w[x x x x x x x x],
               %w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x]]
      let(:board) { Board.new(array) }
      subject(:game_main) { described_class.new(board) }

      it 'returns false' do
        start_tile = [5, 3]
        end_tile = [0, 3]
        result = game_main.not_obscured?(start_tile, end_tile)
        expect(result).to be nil
      end
    end

    context 'when start and end are in the same column and end is not obscured by piece' do
      array = [%w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x],
               %w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x]]
      let(:board) { Board.new(array) }
      subject(:game_main) { described_class.new(board) }

      it 'returns true' do
        start_tile = [5, 3]
        end_tile = [0, 3]
        result = game_main.not_obscured?(start_tile, end_tile)
        expect(result).to be true
      end
    end

    context 'when start and end are diagonal from each other and end is obscured by piece' do
      array = [%w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x],
               ['x', 'x', 'x', Piece.new('king', 'black', [0, 2]), 'x', 'x', 'x', 'x'], %w[x x x x x x x x],
               %w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x]]
      let(:board) { Board.new(array) }
      subject(:game_main) { described_class.new(board) }

      it 'returns false' do
        start_tile = [0, 0]
        end_tile = [5, 5]
        result = game_main.not_obscured?(start_tile, end_tile)
        expect(result).to be nil
      end
    end

    context 'when start and end are diagonal from each other and end is not obscured by piece' do
      array = [%w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x],
               %w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x]]
      let(:board) { Board.new(array) }
      subject(:game_main) { described_class.new(board) }

      it 'returns true' do
        start_tile = [0, 0]
        end_tile = [5, 5]
        result = game_main.not_obscured?(start_tile, end_tile)
        expect(result).to be true
      end
    end
  end

  describe '#player_turn' do
    context '' do
      xit '' do
      end
    end
  end

  describe '#run_game' do
    # test the until game_over loop
    context 'when the game is over' do
      xit 'ends the game loop' do
        expect(game_main).to receive(:make_guess).once
        game_main.run_game
        game_main.instance_variable_set(:@game_over, true)
        expect(game_main).to receive().once
        game_main.run_game
      end
    end
  end
end