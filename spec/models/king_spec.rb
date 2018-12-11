require 'rails_helper'

RSpec.describe King, type: :model do

	# it 'is created with populate_game method' do
 #    game = FactoryBot.create(:game)
 #    user = FactoryBot.create(:user)
 #    game.black_player_user_id = user.id
 #    game.populate_game!
 #    expect(game.pieces.where(type: "King").size).to eq(2)
 #  end
	
	describe 'king valid_move? method' do
		it 'should return false if move is too long' do
			game = FactoryBot.create(:game)
      king = FactoryBot.create(:king, x_pos: 3, y_pos: 0, color: false, game: game)
			expect(king.valid_move?(4, 2)).to eq(false)
		end
	
		it 'should return true if move is horizontal 1' do
			game = FactoryBot.create(:game)
      king = FactoryBot.create(:king, x_pos: 3, y_pos: 0, color: false, game: game)
			expect(king.valid_move?(4, 0)).to be true
		end
	end

  describe 'king can_castle method' do
    it 'should castle king side' do
      game = FactoryBot.create(:game)
      king = FactoryBot.create(:king, x_pos: 3, y_pos: 0, color: false, game: game)
      rook = FactoryBot.create(:rook, x_pos: 0, y_pos: 0, color: false, game: game)
      # expect(king.can_castle?(5)).to raise_error("undefined method `pieces' for nil:NilClass")
      expect(king.can_castle?(1)).to be true
    end

    it 'should castle king side' do
      game = FactoryBot.create(:game)
      king = FactoryBot.create(:king, x_pos: 3, y_pos: 7, color: true, game: game)
      rook = FactoryBot.create(:rook, x_pos: 0, y_pos: 7, color: true, game: game)
      # expect(king.can_castle?(5)).to raise_error("undefined method `pieces' for nil:NilClass")
      expect(king.can_castle?(1)).to be true
    end
    it 'should castle queen side' do
      game = FactoryBot.create(:game)
      king = FactoryBot.create(:king, x_pos: 3, y_pos: 0, color: false, game: game)
      rook = FactoryBot.create(:rook, x_pos: 0, y_pos: 0, color: false, game: game)
      # expect(king.can_castle?(5)).to raise_error("undefined method `pieces' for nil:NilClass")
      expect(king.can_castle?(5)).to be true
    end

    it 'should castle queen side' do
      game = FactoryBot.create(:game)
      king = FactoryBot.create(:king, x_pos: 3, y_pos: 7, color: true, game: game)
      rook = FactoryBot.create(:rook, x_pos: 0, y_pos: 7, color: true, game: game)
      # expect(king.can_castle?(5)).to raise_error("undefined method `pieces' for nil:NilClass")
      expect(king.can_castle?(5)).to be true
    end

  end
end
