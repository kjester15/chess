require_relative '../lib/chess_board'
require_relative '../lib/chess_piece'
require_relative '../lib/chess_player'
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

  describe '#translate_move' do
    it 'returns [3, 1]' do
      selection = 'b5'
      result = board_main.translate_move(selection)
      expect(result).to eq([3, 1])
    end
  end
end

describe Piece do
  subject(:piece_main) { described_class.new('king', 'black', [0, 4]) }

  describe '#initialize' do
    # Initialize -> No test necessary when only creating instance variables.
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

  describe '#king_moves' do
    it 'adds all possible moves when all are in bounds' do
      coordinate = [3, 3]
      moves = [[4, 3], [4, 4], [3, 4], [2, 4], [2, 3], [2, 2], [3, 2], [4, 2]]
      piece_main.king_moves(coordinate)
      result = piece_main.instance_variable_get(:@possible_moves)
      expect(result).to eq(moves)
    end

    it 'only adds in bounds moves' do
      coordinate = [0, 0]
      moves = [[1, 0], [1, 1], [0, 1]]
      piece_main.king_moves(coordinate)
      result = piece_main.instance_variable_get(:@possible_moves)
      expect(result).to eq(moves)
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
end