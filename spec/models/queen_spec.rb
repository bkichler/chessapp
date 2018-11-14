require 'rails_helper'

RSpec.describe Queen, type: :model do

	it 'is created with populate_game method' do
    game = FactoryBot.create(:game)
    user = FactoryBot.create(:user)
    game.black_player_user_id = user.id
    game.populate_game!
    expect(game.pieces.where(type: "Queen").size).to be(1)
  end
	
	describe 'queen valid_move? method' do
		it 'should return false if move is off board' do
			queen = FactoryBot.create(:queen)
			expect(queen.valid_move?(8, 1)).to eq(false)
		end
	
		it 'should return true if move is diagonal 5' do
			queen = FactoryBot.create(:queen)
			expect(queen.valid_move?(7, 4)).to eq(true)
		end
		
		it 'should return false if move is not in a straight path' do
			queen = FactoryBot.create(:queen)
			expect(queen.valid_move?(4, 4)).to eq(false)
		end
	end
end
