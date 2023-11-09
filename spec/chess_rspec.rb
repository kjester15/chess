require_relative '../lib/chess_board'
# require_relative '../lib/chess_piece'
# require_relative '../lib/chess_player'
# require_relative '../lib/chess_game'

describe Board do
  subject(:board_main) { described_class.new }

  describe '#initialize' do
    # Initialize -> No test necessary when only creating instance variables.
  end

  describe '#populate_board' do
    # method only iterates over array - no test necessary
  end

  describe '#create_piece' do
    it 'returns a Piece object' do
      row = 0
      column = 0
      result = board_main.create_piece(row, column)
      expect(result).to be_a Piece
    end

    it 'returns a rook' do
      row = 0
      column = 0
      result = board_main.create_piece(row, column).type
      expect(result).to eq('rook')
    end

    it 'returns the coordinate [0, 0]' do
      row = 0
      column = 0
      result = board_main.create_piece(row, column).coordinate
      expect(result).to eq([0, 0])
    end
  end

  describe '#print_board' do
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
