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

  describe '#change_tile' do
    # method only updates instance variable - no test required
  end

  describe '#update_coordinate' do
    # method only updates instance variable - no test required
  end

  describe '#clear_tile' do
    # method only updates instance variable - no test required
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
        en_passant = ['none', false]
        expected_directions = [[-1, 0]]
        result = piece_main.pawn_move_directions(position, color, capture, en_passant)
        expect(result).to eq(expected_directions)
      end

      it 'returns standard plus first move directions when moving on first turn and not capturing' do
        position = [6, 0]
        color = 'white'
        capture = false
        en_passant = ['none', false]
        expected_directions = [[-1, 0], [-2, 0]]
        result = piece_main.pawn_move_directions(position, color, capture, en_passant)
        expect(result).to eq(expected_directions)
      end

      it 'returns standard plus capture directions when moving on 2nd+ turn and capturing' do
        position = [4, 0]
        color = 'white'
        capture = true
        en_passant = ['none', false]
        expected_directions = [[-1, 0], [-1, 1], [-1, -1]]
        result = piece_main.pawn_move_directions(position, color, capture, en_passant)
        expect(result).to eq(expected_directions)
      end

      it 'returns standard plus left en passant directions when able to perform en passant' do
        position = [4, 1]
        color = 'white'
        capture = false
        left_check = [4, 0]
        en_passant = ['left', true, left_check]
        expected_directions = [[-1, 0], [-1, -1]]
        result = piece_main.pawn_move_directions(position, color, capture, en_passant)
        expect(result).to eq(expected_directions)
      end

      it 'returns standard plus right en passant directions when able to perform en passant' do
        position = [4, 1]
        color = 'white'
        capture = false
        right_check = [4, 2]
        en_passant = ['right', true, right_check]
        expected_directions = [[-1, 0], [-1, 1]]
        result = piece_main.pawn_move_directions(position, color, capture, en_passant)
        expect(result).to eq(expected_directions)
      end
    end

    context 'when a black pawn is moving' do
      it 'returns standard directions when moving on 2nd+ turn and not capturing' do
        position = [2, 0]
        color = 'black'
        capture = false
        en_passant = ['none', false]
        expected_directions = [[1, 0]]
        result = piece_main.pawn_move_directions(position, color, capture, en_passant)
        expect(result).to eq(expected_directions)
      end

      it 'returns standard plus first move directions when moving on first turn and not capturing' do
        position = [1, 0]
        color = 'black'
        capture = false
        en_passant = ['none', false]
        expected_directions = [[1, 0], [2, 0]]
        result = piece_main.pawn_move_directions(position, color, capture, en_passant)
        expect(result).to eq(expected_directions)
      end

      it 'returns standard plus capture directions when moving on 2nd+ turn and capturing' do
        position = [4, 0]
        color = 'black'
        capture = true
        en_passant = ['none', false]
        expected_directions = [[1, 0], [1, 1], [1, -1]]
        result = piece_main.pawn_move_directions(position, color, capture, en_passant)
        expect(result).to eq(expected_directions)
      end

      it 'returns standard plus left en passant directions when able to perform en passant' do
        position = [4, 1]
        color = 'black'
        capture = false
        left_check = [4, 0]
        en_passant = ['left', true, left_check]
        expected_directions = [[1, 0], [1, -1]]
        result = piece_main.pawn_move_directions(position, color, capture, en_passant)
        expect(result).to eq(expected_directions)
      end

      it 'returns standard plus right en passant directions when able to perform en passant' do
        position = [4, 1]
        color = 'black'
        capture = false
        right_check = [4, 2]
        en_passant = ['right', true, right_check]
        expected_directions = [[1, 0], [1, 1]]
        result = piece_main.pawn_move_directions(position, color, capture, en_passant)
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
        en_passant = ['none', false]
        expected_moves = [[5, 3], [4, 3]]
        result = piece_main.pawn_moves(position, color, capture, en_passant)
        expect(result).to eq(expected_moves)
      end

      it 'returns correct tiles when moving on 2nd+ turn and not capturing' do
        position = [5, 3]
        color = 'white'
        capture = false
        en_passant = ['none', false]
        expected_moves = [[4, 3]]
        result = piece_main.pawn_moves(position, color, capture, en_passant)
        expect(result).to eq(expected_moves)
      end

      it 'returns correct tiles when moving on 2nd+ turn and capturing' do
        position = [5, 3]
        color = 'white'
        capture = true
        en_passant = ['none', false]
        expected_moves = [[4, 3], [4, 4], [4, 2]]
        result = piece_main.pawn_moves(position, color, capture, en_passant)
        expect(result).to eq(expected_moves)
      end

      it 'doesn\'t add out of bounds tiles' do
        position = [4, 0]
        color = 'white'
        capture = true
        en_passant = ['none', false]
        expected_moves = [[3, 0], [3, 1]]
        result = piece_main.pawn_moves(position, color, capture, en_passant)
        expect(result).to eq(expected_moves)
      end
    end

    context 'when a black pawn is moving' do
      it 'returns correct tiles when moving on first turn and not capturing' do
        position = [1, 3]
        color = 'black'
        capture = false
        en_passant = ['none', false]
        expected_moves = [[2, 3], [3, 3]]
        result = piece_main.pawn_moves(position, color, capture, en_passant)
        expect(result).to eq(expected_moves)
      end

      it 'returns correct tiles when moving on 2nd+ turn and not capturing' do
        position = [2, 3]
        color = 'black'
        capture = false
        en_passant = ['none', false]
        expected_moves = [[3, 3]]
        result = piece_main.pawn_moves(position, color, capture, en_passant)
        expect(result).to eq(expected_moves)
      end

      it 'returns correct tiles when moving on 2nd+ turn and capturing' do
        position = [2, 3]
        color = 'black'
        capture = true
        en_passant = ['none', false]
        expected_moves = [[3, 3], [3, 4], [3, 2]]
        result = piece_main.pawn_moves(position, color, capture, en_passant)
        expect(result).to eq(expected_moves)
      end

      it 'doesn\'t add out of bounds tiles' do
        position = [3, 0]
        color = 'black'
        capture = true
        en_passant = ['none', false]
        expected_moves = [[4, 0], [4, 1]]
        result = piece_main.pawn_moves(position, color, capture, en_passant)
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

  describe '#update_enpassant' do
    it 'updates @en_passant to true' do
      value = true
      piece_main.update_enpassant(value)
      expect(piece_main.en_passant).to be true
    end

    it 'updates @en_passant to false' do
      value = false
      piece_main.update_enpassant(value)
      expect(piece_main.en_passant).to be false
    end
  end

  describe '#update_enpassant_count' do
    it 'updates @en_passant_count to 2' do
      value = 2
      piece_main.update_enpassant_count(value)
      expect(piece_main.en_passant_count).to eq(2)
    end

    it 'updates @en_passant_count to " "' do
      value = ''
      piece_main.update_enpassant_count(value)
      expect(piece_main.en_passant_count).to eq('')
    end
  end

  describe '#decrease_enpassant_count' do
    it 'decrease @en_passant_count by 1' do
      value = 1
      piece_main.instance_variable_set(:@en_passant_count, 2)
      piece_main.decrease_enpassant_count(value)
      expect(piece_main.en_passant_count).to eq(1)
    end
  end

  describe '#update_has_moved' do
    it 'updates @has_moved to true' do
      piece_main.update_has_moved
      expect(piece_main.has_moved).to be true
    end
  end

  describe '#update_check' do
    it 'updates @check to true' do
      piece_main.update_check(true)
      expect(piece_main.check).to be true
    end

    it 'updates @check to false' do
      piece_main.instance_variable_set(:@check, true)
      piece_main.update_check(false)
      expect(piece_main.has_moved).to be false
    end
  end
end

describe Game do
  subject(:game_main) { described_class.new(Board.new) }

  describe '#initialize' do
    # Initialize -> No test necessary when only creating instance variables.
  end

  describe '#set_current_player' do
    # method only sets value of instance variable - no test required
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

    it 'returns pawn when symbol is anything else' do
      symbol = 'x'
      result = game_main.convert_symbol_to_piece(symbol)
      expect(result).to eq('pawn')
    end
  end

  describe '#convert_piece_to_symbol' do
    it 'returns K when piece is king' do
      piece = 'king'
      result = game_main.convert_piece_to_symbol(piece)
      expect(result).to eq('K')
    end

    it 'returns queen when symbol is Q' do
      piece = 'queen'
      result = game_main.convert_piece_to_symbol(piece)
      expect(result).to eq('Q')
    end

    it 'returns pawn when symbol is anything else' do
      piece = 'pawn'
      result = game_main.convert_piece_to_symbol(piece)
      expect(result).to be nil
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

  describe '#convert_file_to_column' do
    # method only subtracts from input - no testing required
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
    context 'when final_pieces is length = 1' do
      it 'calls #translate_move & #call_moves_method' do
        move = 'Ka3'
        pieces_array = [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
        expect(game_main).to receive(:translate_move).once.and_return([0, 0])
        expect(game_main).to receive(:call_moves_method).once.and_return([0, 0])
        game_main.find_piece(pieces_array, move)
      end
    end

    context 'when final_pieces is length > 1' do
      it 'calls #translate_move, #call_moves_method & #narrow_pieces' do
        move = 'Ka3'
        pieces_array = [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
        expect(game_main).to receive(:translate_move).once.and_return([0, 0])
        expect(game_main).to receive(:call_moves_method).once.and_return([[0, 0], [1, 1]])
        expect(game_main).to receive(:narrow_pieces).once
        game_main.find_piece(pieces_array, move)
      end
    end
  end

  describe '#call_moves_method' do
    let(:board) { Board.new(Array.new(8) { Array.new(8) { Piece.new('king', 'black', [1, 2]) } }) }
    let(:player) { { name: 'test', color: 'white' } }
    subject(:game_main) { described_class.new(board, player) }

    context 'when move includes K Q R B or N' do
      it 'calls #piece_moves & #add_moves' do
        piece = 'K'
        pieces = [[0, 0], [1, 1]]
        move = 'Ka3'
        color = 'white'
        tile = [0, 0]
        moves = [[0, 0], [1, 1]]
        expect(game_main.board.board_array[0][0]).to receive(:piece_moves).and_return(moves)
        expect(game_main.board.board_array[1][1]).to receive(:piece_moves).and_return(moves)
        expect(game_main).to receive(:add_moves).with(moves, tile, piece, [0, 0])
        expect(game_main).to receive(:add_moves).with(moves, tile, piece, [1, 1])
        game_main.call_moves_method(piece, pieces, move, color, tile)
      end
    end

    context 'when move does not include K Q R B or N' do
      it 'calls #pawn_moves, #is_pawn_capture?, #en_passant?, & #add_moves' do
        piece = 'x'
        pieces = [[0, 0], [1, 1]]
        move = 'a3'
        color = 'white'
        tile = [0, 0]
        moves = [[0, 0], [1, 1]]
        expect(game_main.board.board_array[0][0]).to receive(:pawn_moves).and_return(moves)
        expect(game_main.board.board_array[1][1]).to receive(:pawn_moves).and_return(moves)
        expect(game_main).to receive(:is_pawn_capture?).and_return(true)
        expect(game_main).to receive(:is_pawn_capture?).and_return(true)
        expect(game_main).to receive(:en_passant?)
        expect(game_main).to receive(:en_passant?)
        expect(game_main).to receive(:add_moves).with(moves, tile, piece, [0, 0])
        expect(game_main).to receive(:add_moves).with(moves, tile, piece, [1, 1])
        game_main.call_moves_method(piece, pieces, move, color, tile)
      end
    end
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

  describe '#pawn_first_move?' do
    array = [%w[x x x x x x x x], ['x', 'x', Piece.new('pawn', 'black', [1, 2]), 'x', 'x', 'x', 'x', 'x'],
             %w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x], %w[x x x x x x x x],
             ['x', 'x', Piece.new('pawn', 'white', [6, 2]), 'x', 'x', 'x', 'x', 'x'], %w[x x x x x x x x]]
    let(:board) { Board.new(array) }
    subject(:game_main) { described_class.new(board) }

    context 'when called on a piece that is not a pawn' do
      it 'returns nil' do
        start_tile = [4, 4]
        end_tile = [5, 5]
        result = game_main.pawn_first_move?(start_tile, end_tile)
        expect(result).to be nil
      end
    end

    context 'when called on a pawn moving two tiles, from the wrong row' do
      it 'returns nil' do
        wrong_row = 5
        start_tile = [wrong_row, 2]
        end_tile = [4, 2]
        result = game_main.pawn_first_move?(start_tile, end_tile)
        expect(result).to be nil
      end
    end

    context 'when called on a white pawn moving two tiles' do
      it 'calls #update_enpassant & #update_enpassant_count' do
        start_tile = [6, 2]
        end_tile = [4, 2]
        expect(game_main.board.board_array[start_tile[0]][start_tile[1]]).to receive(:update_enpassant).with(true)
        expect(game_main.board.board_array[start_tile[0]][start_tile[1]]).to receive(:update_enpassant_count).with(2)
        game_main.pawn_first_move?(start_tile, end_tile)
      end
    end

    context 'when called on a black pawn moving two tiles' do
      it 'calls #update_enpassant & #update_enpassant_count' do
        start_tile = [1, 2]
        end_tile = [3, 2]
        expect(game_main.board.board_array[start_tile[0]][start_tile[1]]).to receive(:update_enpassant).with(true)
        expect(game_main.board.board_array[start_tile[0]][start_tile[1]]).to receive(:update_enpassant_count).with(2)
        game_main.pawn_first_move?(start_tile, end_tile)
      end
    end
  end

  describe '#decrease_enpassant_count' do
    array = [[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', Piece.new('pawn', 'black', [1, 2], true, 2), ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']]
    let(:board) { Board.new(array) }
    subject(:game_main) { described_class.new(board) }

    context 'when one pawn has @en_passant set to true' do
      it 'calls #decrease_enpassant_count once' do
        pawn_tile = [1, 2]
        expect(game_main.board.board_array[pawn_tile[0]][pawn_tile[1]]).to receive(:decrease_enpassant_count).once
        game_main.decrease_enpassant_count
      end
    end
  end

  describe '#reset_en_passant' do
    array = [[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', Piece.new('pawn', 'black', [1, 2], true, 0), ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']]
    let(:board) { Board.new(array) }
    subject(:game_main) { described_class.new(board) }

    context 'when one pawn has @en_passant_count set to 0' do
      it 'calls #update_enpassant & #update_enpassant_count' do
        pawn_tile = [1, 2]
        expect(game_main.board.board_array[pawn_tile[0]][pawn_tile[1]]).to receive(:update_enpassant).once
        expect(game_main.board.board_array[pawn_tile[0]][pawn_tile[1]]).to receive(:update_enpassant_count).once
        game_main.reset_en_passant
      end
    end
  end

  describe '#move_piece' do
    array = [[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
             [' ', Piece.new('pawn', 'black', [1, 1], true, 2), ' ', ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']]
    let(:board) { Board.new(array) }
    subject(:game_main) { described_class.new(board) }

    context 'when #tile_occupied? and #can_capture?' do
      it 'calls all appropriate methods' do
        piece = [0, 0]
        move = 'Kb7'
        move_to = [1, 1]
        expect(game_main).to receive(:translate_move).with('b7').and_return(move_to)
        expect(game_main.board).to receive(:tile_occupied?).with(move_to).and_return(true)
        expect(game_main).to receive(:can_capture?).with(piece, move).and_return(true)
        expect(game_main).to receive(:pawn_first_move?).with(piece, move_to)
        expect(game_main).to receive(:prevent_king_check?).with(move_to).and_return(false)
        expect(game_main.board).to receive(:change_tile).with(move_to, piece)
        expect(game_main.board).to receive(:update_coordinate).with(move_to)
        expect(game_main.board).to receive(:clear_tile).with(piece)
        expect(game_main.board.board_array[move_to[0]][move_to[1]]).to receive(:update_has_moved)
        game_main.move_piece(piece, move)
      end
    end

    context 'when #tile_occupied? but not #can_capture?' do
      it 'returns after puts' do
        piece = [0, 0]
        move = 'Kb7'
        move_to = [1, 1]
        message = 'You cannot capture this piece.'
        expect(game_main).to receive(:translate_move).with('b7').and_return(move_to)
        expect(game_main.board).to receive(:tile_occupied?).with(move_to).and_return(true)
        expect(game_main).to receive(:can_capture?).with(piece, move).and_return(false)
        expect(game_main).to receive(:puts).with(message)
        expect(game_main).not_to receive(:pawn_first_move?).with(piece, move_to)
        expect(game_main).not_to receive(:prevent_king_check?).with(move_to)
        expect(game_main.board).not_to receive(:change_tile).with(move_to, piece)
        expect(game_main.board).not_to receive(:update_coordinate).with(move_to)
        expect(game_main.board).not_to receive(:clear_tile).with(piece)
        expect(game_main.board.board_array[move_to[0]][move_to[1]]).not_to receive(:update_has_moved)
        game_main.move_piece(piece, move)
      end
    end

    context 'when not #tile_occupied? and pawn is en passant' do
      it 'calls all appropriate methods' do
        piece = [0, 0]
        move = 'Kb7'
        move_to = [1, 1]
        expect(game_main).to receive(:translate_move).with('b7').and_return(move_to)
        expect(game_main.board).to receive(:tile_occupied?).with(move_to).and_return(false)
        expect(game_main).not_to receive(:can_capture?).with(piece, move)
        expect(game_main).to receive(:en_passant?).exactly(3).times.with(piece).and_return(['left', true, [0, 0]])
        expect(game_main.board).to receive(:clear_tile)
        expect(game_main).to receive(:pawn_first_move?).with(piece, move_to)
        expect(game_main).to receive(:prevent_king_check?).with(move_to).and_return(false)
        expect(game_main.board).to receive(:change_tile).with(move_to, piece)
        expect(game_main.board).to receive(:update_coordinate).with(move_to)
        expect(game_main.board).to receive(:clear_tile).with(piece)
        expect(game_main.board.board_array[move_to[0]][move_to[1]]).to receive(:update_has_moved)
        game_main.move_piece(piece, move)
      end
    end

    context 'when not #tile_occupied? and not #en_passant?' do
      it 'calls all appropriate methods' do
        piece = [0, 0]
        move = 'Kb7'
        move_to = [1, 1]
        expect(game_main).to receive(:translate_move).with('b7').and_return(move_to)
        expect(game_main.board).to receive(:tile_occupied?).with(move_to).and_return(false)
        expect(game_main).not_to receive(:can_capture?).with(piece, move)
        expect(game_main).to receive(:en_passant?).with(piece).and_return(nil)
        expect(game_main).not_to receive(:en_passant?).with(piece)
        expect(game_main).to receive(:pawn_first_move?).with(piece, move_to)
        expect(game_main).to receive(:prevent_king_check?).with(move_to).and_return(false)
        expect(game_main.board).to receive(:change_tile).with(move_to, piece)
        expect(game_main.board).to receive(:update_coordinate).with(move_to)
        expect(game_main.board).to receive(:clear_tile).with(piece)
        expect(game_main.board.board_array[move_to[0]][move_to[1]]).to receive(:update_has_moved)
        game_main.move_piece(piece, move)
      end
    end

    context 'when symbol is K and #prevent_king_check?' do
      it 'calls all appropriate methods' do
        piece = [0, 0]
        move = 'Kb7'
        move_to = [1, 1]
        expect(game_main).to receive(:translate_move).with('b7').and_return(move_to)
        expect(game_main.board).to receive(:tile_occupied?).with(move_to).and_return(false)
        expect(game_main).to receive(:en_passant?).with(piece).and_return(nil)
        expect(game_main).to receive(:pawn_first_move?).with(piece, move_to)
        expect(game_main).to receive(:prevent_king_check?).with(move_to).and_return(true)
        expect(game_main.board).not_to receive(:change_tile).with(move_to, piece)
        expect(game_main.board).not_to receive(:update_coordinate).with(move_to)
        expect(game_main.board).not_to receive(:clear_tile).with(piece)
        expect(game_main.board.board_array[move_to[0]][move_to[1]]).not_to receive(:update_has_moved)
        result = game_main.move_piece(piece, move)
        expect(result).to be nil
      end
    end
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

  describe '#en_passant?' do
    pawn_true = Piece.new('pawn', 'black', [1, 2], true, 0)
    pawn_false = Piece.new('pawn', 'black', [1, 2], false, 0)
    not_pawn = Piece.new('king', 'black', [2, 2], true, 0)
    array = [[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', pawn_true, pawn_true, ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', not_pawn, ' ', ' ', ' ', ' ', ' '], [' ', ' ', pawn_true, pawn_true, ' ', ' ', ' ', ' '],
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', pawn_true, ' ', ' ', ' ', ' '],
             [' ', pawn_false, pawn_false, pawn_false, ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']]
    let(:board) { Board.new(array) }
    subject(:game_main) { described_class.new(board) }

    context 'when start tile is not a piece' do
      it 'returns nil' do
        start_tile = [0, 0]
        result = game_main.en_passant?(start_tile)
        expect(result).to be nil
      end
    end

    context 'when start tile is not a pawn' do
      it 'returns nil' do
        start_tile = [2, 2]
        result = game_main.en_passant?(start_tile)
        expect(result).to be nil
      end
    end

    context 'when start tile is a pawn and pawn to left has @en_passant = true' do
      it 'returns correct array' do
        start_tile = [1, 2]
        correct_array = ['left', true, [1, 1]]
        result = game_main.en_passant?(start_tile)
        expect(result).to eq(correct_array)
      end
    end

    context 'when start tile is a pawn and pawn to right has @en_passant = true' do
      it 'returns correct array' do
        start_tile = [3, 2]
        correct_array = ['right', true, [3, 3]]
        result = game_main.en_passant?(start_tile)
        expect(result).to eq(correct_array)
      end
    end

    context 'when start tile is a pawn and no pawn to right or left has @en_passant = true' do
      it 'returns correct array' do
        start_tile = [6, 2]
        correct_array = ['none', false]
        result = game_main.en_passant?(start_tile)
        expect(result).to eq(correct_array)
      end
    end

    context 'when start tile is a pawn and there is no pawn to right or left' do
      it 'returns correct array' do
        start_tile = [5, 3]
        correct_array = ['none', false]
        result = game_main.en_passant?(start_tile)
        expect(result).to eq(correct_array)
      end
    end
  end

  describe '#convert_coord_to_move' do
    context 'when given K and a coordinate' do
      it 'returns the correct move' do
        symbol = 'K'
        coordinate = [1, 2]
        move = 'Kc7'
        result = game_main.convert_coord_to_move(symbol, coordinate)
        expect(result).to eq(move)
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

      # TODO: test when check is true
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

  describe '#castle' do
    context '' do
      xit '' do
      end
    end
  end

  describe '#prevent_king_check?' do
    context 'when #check? returns false' do
      it 'returns nil' do
        move_to = [0, 0]
        expect(game_main).to receive(:check?).and_return(false)
        result = game_main.prevent_king_check?(move_to)
        expect(result).to be nil
      end
    end

    context 'when #check? returns true' do
      it 'puts to terminal and returns true' do
        move_to = [0, 0]
        message = 'That tile is in check, you cannot move there.'
        expect(game_main).to receive(:check?).and_return(true)
        expect(game_main).to receive(:puts).with(message)
        result = game_main.prevent_king_check?(move_to)
        expect(result).to be true
      end
    end
  end

  describe '#find_king' do
    context 'when color is white' do
      array = [[' ', ' ', ' ', Piece.new('king', 'white', [0, 3]), ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', Piece.new('king', 'black', [2, 3]), ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],]
      let(:board) { Board.new(array) }
      let(:player) { { name: 'test', color: 'white' } }
      subject(:game_main) { described_class.new(board, player) }

      it 'returns king coordinate of opposite color' do
        king = [2, 3]
        result = game_main.find_king
        expect(result).to eq(king)
      end
    end

    context 'when color is black' do
      array = [[' ', ' ', ' ', Piece.new('king', 'white', [0, 3]), ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', Piece.new('king', 'black', [2, 3]), ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],]
      let(:board) { Board.new(array) }
      let(:player) { { name: 'test', color: 'black' } }
      subject(:game_main) { described_class.new(board, player) }

      it 'returns king coordinate of opposite color' do
        king = [0, 3]
        result = game_main.find_king
        expect(result).to eq(king)
      end
    end

    context 'when no king of opposite color is found' do
      array = [[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],]
      let(:board) { Board.new(array) }
      let(:player) { { name: 'test', color: 'black' } }
      subject(:game_main) { described_class.new(board, player) }

      it 'returns false' do
        result = game_main.find_king
        expect(result).to be false
      end
    end
  end

  describe '#collect_pieces' do
    context 'when current player is white' do
      array = [[' ', ' ', ' ', Piece.new('king', 'white', [0, 3]), ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', Piece.new('king', 'black', [1, 3]), ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', Piece.new('king', 'white', [2, 3]), ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', Piece.new('king', 'black', [3, 3]), ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', Piece.new('king', 'white', [4, 3]), ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', Piece.new('king', 'black', [5, 3]), ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', Piece.new('king', 'white', [6, 3]), ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', Piece.new('king', 'black', [7, 3]), ' ', ' ', ' ', ' ']]
      let(:board) { Board.new(array) }
      let(:player) { { name: 'test', color: 'white' } }
      subject(:game_main) { described_class.new(board, player) }

      it 'returns correct piece array' do
        pieces = [[0, 3], [2, 3], [4, 3], [6, 3]]
        result = game_main.collect_pieces
        expect(result).to eq(pieces)
      end
    end

    context 'when current player is black' do
      array = [[' ', ' ', ' ', Piece.new('king', 'white', [0, 3]), ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', Piece.new('king', 'black', [1, 3]), ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', Piece.new('king', 'white', [2, 3]), ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', Piece.new('king', 'black', [3, 3]), ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', Piece.new('king', 'white', [4, 3]), ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', Piece.new('king', 'black', [5, 3]), ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', Piece.new('king', 'white', [6, 3]), ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', Piece.new('king', 'black', [7, 3]), ' ', ' ', ' ', ' ']]
      let(:board) { Board.new(array) }
      let(:player) { { name: 'test', color: 'black' } }
      subject(:game_main) { described_class.new(board, player) }

      it 'returns correct piece array' do
        pieces = [[1, 3], [3, 3], [5, 3], [7, 3]]
        result = game_main.collect_pieces
        expect(result).to eq(pieces)
      end
    end
  end

  describe '#check?' do
    context 'when piece is K Q R B or N' do
      let(:board) { Board.new(Array.new(8) { Array.new(8) { Piece.new('king', 'black', [1, 2]) } }) }
      let(:player) { { name: 'test', color: 'white' } }
      subject(:game_main) { described_class.new(board, player) }

      it 'calls appropriate methods' do
        pieces = [[0, 0]]
        tile = pieces[0]
        prevent = false
        move_to = nil
        expect(game_main).to receive(:collect_pieces).and_return(pieces)
        expect(game_main).to receive(:convert_piece_to_symbol).with('king').and_return('K')
        expect(game_main.board.board_array[0][0]).to receive(:piece_moves).with('K', tile)
        expect(game_main).to receive(:add_moves)
        game_main.check?(prevent, move_to)
      end
    end

    context 'when piece is pawn' do
      let(:board) { Board.new(Array.new(8) { Array.new(8) { Piece.new('pawn', 'black', [1, 2]) } }) }
      let(:player) { { name: 'test', color: 'white' } }
      subject(:game_main) { described_class.new(board, player) }

      it 'call appropriate methods when moves array is nil' do
        pieces = [[0, 0]]
        tile = pieces[0]
        prevent = false
        move_to = nil
        expect(game_main).to receive(:find_king).and_return([1, 1])
        expect(game_main).to receive(:collect_pieces).and_return(pieces)
        expect(game_main).to receive(:convert_piece_to_symbol).with('pawn').and_return(nil)
        expect(game_main.board.board_array[0][0]).to receive(:pawn_moves).with(tile, 'white', true, ['', false])
        expect(game_main).to receive(:add_moves).and_return([])
        expect(game_main.board.board_array[1][1]).to receive(:update_check).with(true)
        result = game_main.check?(prevent, move_to)
        expect(result).to be true
      end

      it 'call appropriate methods when moves array is not nil' do
        pieces = [[0, 0]]
        tile = pieces[0]
        prevent = false
        move_to = nil
        expect(game_main).to receive(:find_king).and_return([1, 1])
        expect(game_main).to receive(:collect_pieces).and_return(pieces)
        expect(game_main).to receive(:convert_piece_to_symbol).with('pawn').and_return(nil)
        expect(game_main.board.board_array[0][0]).to receive(:pawn_moves).with(tile, 'white', true, ['', false])
        expect(game_main).to receive(:add_moves)
        expect(game_main.board.board_array[1][1]).to receive(:update_check).with(false)
        game_main.check?(prevent, move_to)
      end
    end

    context 'when called from #prevent_king_check?' do
      let(:board) { Board.new(Array.new(8) { Array.new(8) { Piece.new('pawn', 'black', [1, 2]) } }) }
      let(:player) { { name: 'test', color: 'white' } }
      subject(:game_main) { described_class.new(board, player) }

      it 'does not call #find_king' do
        prevent = true
        move_to = [2, 2]
        expect(game_main).not_to receive(:find_king)
        game_main.check?(prevent, move_to)
      end
    end

    # board.board_array[king_tile[0]][king_tile[1]].update_check(false)
  end

  describe '#checkmate?' do
    array = [[' ', ' ', ' ', Piece.new('king', 'white', [0, 3]), 'x', ' ', ' ', ' '],
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']]
    let(:board) { Board.new(array) }
    let(:player) { { name: 'test', color: 'white' } }
    subject(:game_main) { described_class.new(board, player) }

    context 'when #check? is false' do
      it 'returns nil' do
        expect(game_main).to receive(:check?).with(false, nil).and_return(false)
        result = game_main.checkmate?
        expect(result).to be nil
      end
    end

    context 'when #check? is true and move is added via first if' do
      it 'returns nil when moves array is not empty ' do
        king_tile = [0, 3]
        possible_moves = [[0, 2]]
        move = possible_moves[0]
        expect(game_main).to receive(:check?).with(false, nil).and_return(true)
        expect(game_main).to receive(:find_king).and_return(king_tile)
        expect(game_main.board.board_array[king_tile[0]][king_tile[1]]).to receive(:piece_moves).with('K', king_tile)
                                                                       .and_return(possible_moves)
        expect(game_main).to receive(:check?).with(true, move).and_return(false)
        result = game_main.checkmate?
        expect(result).to be nil
      end
    end

    context 'when #check? is true and move is added via else if' do
      it 'returns nil when moves array is not empty ' do
        king_tile = [0, 3]
        possible_moves = [[0, 4]]
        move = possible_moves[0]
        expect(game_main).to receive(:check?).with(false, nil).and_return(true)
        expect(game_main).to receive(:find_king).and_return(king_tile)
        expect(game_main.board.board_array[king_tile[0]][king_tile[1]]).to receive(:piece_moves).with('K', king_tile)
                                                                       .and_return(possible_moves)
        expect(game_main.board).to receive(:tile_occupied?).with(move).and_return(true)
        expect(game_main).to receive(:convert_coord_to_move).with('K', move).and_return('e8')
        expect(game_main).to receive(:can_capture?).with(king_tile, 'e8', true).and_return(true)
        result = game_main.checkmate?
        expect(result).to be nil
      end
    end

    context 'when #check? is true and move is not added' do
      it 'returns true when moves array is empty ' do
        king_tile = [0, 3]
        possible_moves = [[0, 4]]
        move = possible_moves[0]
        expect(game_main).to receive(:check?).with(false, nil).and_return(true)
        expect(game_main).to receive(:find_king).and_return(king_tile)
        expect(game_main.board.board_array[king_tile[0]][king_tile[1]]).to receive(:piece_moves).with('K', king_tile)
                                                                       .and_return(possible_moves)
        expect(game_main.board).to receive(:tile_occupied?).with(move).and_return(true)
        expect(game_main).to receive(:convert_coord_to_move).with('K', move).and_return('e8')
        expect(game_main).to receive(:can_capture?).with(king_tile, 'e8', true).and_return(false)
        result = game_main.checkmate?
        expect(result).to be true
      end
    end
  end

  describe '#game_over?' do
    context 'when there is no king left' do
      it 'calls #find_king and puts to terminal' do
        expect(game_main).to receive(:find_king).and_return(false)
        expect(game_main).to receive(:puts).once
        game_main.game_over?
      end
    end

    context 'when there is a king' do
      it 'calls #find_king & #checkmate? and puts to terminal' do
        expect(game_main).to receive(:find_king).and_return(true)
        expect(game_main).to receive(:checkmate?).and_return(true)
        expect(game_main).to receive(:puts).once
        game_main.game_over?
      end
    end

    context 'when there is a king and it is not in checkmate' do
      it 'calls #find_king & #checkmate? and does not puts to terminal' do
        expect(game_main).to receive(:find_king).and_return(true)
        expect(game_main).to receive(:checkmate?).and_return(false)
        expect(game_main).not_to receive(:puts)
        game_main.game_over?
      end
    end
  end

  describe '#promotion' do
    context 'when moving a non-pawn piece' do
      it 'returns nil' do
        move = 'Kc8'
        expect(game_main).to receive(:translate_move).and_return([0, 2])
        result = game_main.promotion(move)
        expect(result).to be nil
      end
    end

    context 'when moving a pawn, current player is white, and tile is row 0' do
      array = [[' ', ' ', Piece.new('pawn', 'white', [0, 3]), ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', Piece.new('pawn', 'black', [7, 2]), ' ', ' ', ' ', ' ', ' ']]
      let(:board) { Board.new(array) }
      let(:player) { { name: 'test', color: 'white' } }
      subject(:game_main) { described_class.new(board, player) }

      it 'calls #create_piece' do
        move = 'c8'
        move_to = [0, 2]
        expect(game_main).to receive(:translate_move).and_return(move_to)
        expect(game_main.board).to receive(:create_piece).with(move_to[0], move_to[1], 'queen', 'white')
        game_main.promotion(move)
      end
    end

    context 'when moving a pawn, current player is white, and tile is row 1' do
      array = [[' ', ' ', Piece.new('pawn', 'white', [0, 3]), ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', Piece.new('pawn', 'black', [7, 2]), ' ', ' ', ' ', ' ', ' ']]
      let(:board) { Board.new(array) }
      let(:player) { { name: 'test', color: 'white' } }
      subject(:game_main) { described_class.new(board, player) }

      it 'calls #create_piece' do
        move = 'c7'
        move_to = [1, 2]
        expect(game_main).to receive(:translate_move).and_return(move_to)
        expect(game_main.board).not_to receive(:create_piece).with(move_to[0], move_to[1], 'queen', 'white')
        game_main.promotion(move)
      end
    end

    context 'when moving a pawn, current player is black, and tile is row 7' do
      array = [[' ', ' ', Piece.new('pawn', 'white', [0, 3]), ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', Piece.new('pawn', 'black', [7, 2]), ' ', ' ', ' ', ' ', ' ']]
      let(:board) { Board.new(array) }
      let(:player) { { name: 'test', color: 'black' } }
      subject(:game_main) { described_class.new(board, player) }

      it 'calls #create_piece' do
        move = 'c1'
        move_to = [7, 2]
        expect(game_main).to receive(:translate_move).and_return(move_to)
        expect(game_main.board).to receive(:create_piece).with(move_to[0], move_to[1], 'queen', 'black')
        game_main.promotion(move)
      end
    end

    context 'when moving a pawn, current player is black, and tile is row 6' do
      array = [[' ', ' ', Piece.new('pawn', 'white', [0, 3]), ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
               [' ', ' ', Piece.new('pawn', 'black', [7, 2]), ' ', ' ', ' ', ' ', ' ']]
      let(:board) { Board.new(array) }
      let(:player) { { name: 'test', color: 'black' } }
      subject(:game_main) { described_class.new(board, player) }

      it 'calls #create_piece' do
        move = 'c2'
        move_to = [6, 2]
        expect(game_main).to receive(:translate_move).and_return(move_to)
        expect(game_main.board).not_to receive(:create_piece).with(move_to[0], move_to[1], 'queen', 'black')
        game_main.promotion(move)
      end
    end
  end

  describe '#player_turn' do
    # method only calls methods / updates instance variable - tested via gameplay
  end

  describe '#run_game' do
    # method only calls methods - tested via gameplay
  end
end