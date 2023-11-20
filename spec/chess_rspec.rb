require_relative '../lib/chess_board'
require_relative '../lib/chess_piece'
require_relative '../lib/chess_game'

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
  subject(:game_main) { described_class.new }

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

  describe '#translate_move' do
    it 'returns [3, 1]' do
      selection = 'b5'
      result = game_main.translate_move(selection)
      expect(result).to eq([3, 1])
    end
  end
end