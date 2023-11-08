require_relative '../lib/chess_board'
# require_relative '..lib/chess_piece'
# require_relative '..lib/chess_player'
# require_relative '..lib/chess_game'

describe Board do
  subject(:board_main) { described_class.new }

  describe '#initialize' do
    # Initialize -> No test necessary when only creating instance variables.
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
