require 'rails_helper'

RSpec.describe Pawn, type: :model do

	it 'is created with populate_game method' do
    game = FactoryBot.create(:game)
    user = FactoryBot.create(:user)
    game.black_player_user_id = user.id
    game.populate_game!
    expect(game.pieces.where(type: "Pawn").size).to be(16)
  end

  describe 'pawn backwards_move? method' do
    it 'should return true for backwards move' do
			pawn = FactoryBot.create(:pawn)
			expect(pawn.backwards_move?(0)).to eq(true)
		end
	end
	
	describe 'pawn horizontal_move? method' do
		it 'should return true for horizontal move' do
			pawn = FactoryBot.create(:pawn)
			expect(pawn.horizontal_move?(2)).to eq(true)
		end
	end

	describe 'pawn first_move? method' do
		it 'should return true for the first move' do
			pawn = FactoryBot.create(:pawn)
			expect(pawn.first_move?(2)).to eq(true)
		end
	end
	
	describe 'pawn okay_length? method' do
		it 'shoudl return false if length is 3' do
			pawn = FactoryBot.create(:pawn)
			expect(pawn.okay_length?(4)).to eq(false)
		end
	end
	
	describe 'pawn valid_move? method' do
		it 'should return false if move is horizontal' do
			pawn = FactoryBot.create(:pawn)
			expect(pawn.valid_move?(1, 2)).to eq(false)
		end
	
		it 'should return true if move is forward 1' do
			pawn = FactoryBot.create(:pawn)
			expect(pawn.valid_move?(2, 1)).to eq(true)
		end
		
		it 'shoudl return true if first move is forward 2' do
			pawn = FactoryBot.create(:pawn)
			expect(pawn.valid_move?(3, 1)).to eq(true)
		end
	end

	describe 'pawn is_obstructed? behavior' do
		it 'should return true if a vertical obstruction exists' do
			
		end
	end
end