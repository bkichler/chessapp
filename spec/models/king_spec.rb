require 'rails_helper'

RSpec.describe King, type: :model do

	it 'is created with populate_game method' do
    game = FactoryBot.create(:game)
    user = FactoryBot.create(:user)
    game.black_player_user_id = user.id
    game.populate_game!
    expect(game.pieces.where(type: "King").size).to be(2)
  end
	
	describe 'king valid_move? method' do
		it 'should return false if move is too long' do
			king = FactoryBot.create(:king)
			expect(king.valid_move?(4, 2)).to eq(false)
		end
	
		it 'should return true if move is horizontal 1' do
			king = FactoryBot.create(:king)
			expect(king.valid_move?(5, 0)).to eq(true)
		end
	end
	
end
