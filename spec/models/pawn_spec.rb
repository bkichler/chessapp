require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe 'pawn backwards_move? method' do
    it 'should return false for backwards move' do
			game = FactoryBot.create(:game)
			user = FactoryBot.create(:user)
			pawn = FactoryBot.create(:pawn)
			expect(pawn.backwards_move?(1, 0)).to be_true
		end
	end
end